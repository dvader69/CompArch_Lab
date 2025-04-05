
module mux_32bit2to1 (
    input [31:0] A,B,
    input sel,
    output reg [31:0] mux_out
);
always @(*) begin 
case(sel) 
1'b0: mux_out=A;
1'b1: mux_out=B;
endcase 
end 
endmodule 

module and_32bit (
    input [31:0] A,B,
    output [31:0] and_out
);
assign and_out=A&B;
endmodule 

module or_32bit (
    input [31:0] A,B,
    output [31:0] or_out
);
assign or_out=A|B;
endmodule 

module add_sub_32bit (  // I have taken a behavoural approach here ,can also be done using structural modelling (only more hardwork to be done 😊)
    input [31:0] A,B,
    input control , // if control==0 ( add) , else if control==1 (subtract)
    output reg [31:0] add_sub_out
);

always @ (*) begin
    if(~control)
    add_sub_out = A + B;
    else if(control)
    add_sub_out= A-B;
end
endmodule 

module ALU_32bit ( 
    input [31:0] A,B,
    input [1:0] operation,
    input Binvert,
    output [31:0] ALU_result
);
wire [31:0] intermediate [3:0];


or_32bit o1 ( .A(A),.B(B),.or_out(intermediate[1]));
add_sub_32bit as1 (.A(A),.B(B),.control(Binvert), .add_sub_out(intermediate[2]));
and_32bit a1 (.A(A),.B(B),.and_out(intermediate[0]));



mux_32bit2to1 m1 (.A(intermediate[1]),.B(intermediate[0]),.sel(operation[0]),.mux_out(intermediate[3]));
mux_32bit2to1 m2 (.A(intermediate[3]),.B(intermediate[2]),.sel(operation[1]),.mux_out(ALU_result));

endmodule 

/* cool now we will construct the main control unit 
The main control unit will take a 6-bit opcodes and will produce 9 different control signals 
Implementing it using PLA logic
*/

module main_control_logic (
    input [5:0] opcode,
    output RegDst,ALUSrc, MemtoReg, RegWrite,MemRead, MemWrite,Branch,ALUOp1,ALUOp2
);

// making the and-arrays 
wire [3:0] intermediate;
and and3(intermediate[3],~opcode[5],~opcode[4],~opcode[3],~opcode[2],~opcode[1],~opcode[0]);
and and2(intermediate[2],opcode[5],~opcode[4],~opcode[3],~opcode[2],opcode[1],opcode[0]);
and and1(intermediate[1],opcode[5],~opcode[4],opcode[3],~opcode[2],opcode[1],opcode[0]);
and and0(intermediate[0],~opcode[5],~opcode[4],~opcode[3],opcode[2],~opcode[1],~opcode[0]);
assign RegDst=intermediate[3];
assign ALUsrc= intermediate[2]||intermediate[1];
assign MemtoReg = intermediate[2];
assign RegWrite = intermediate[3] || intermediate[2];
assign MemRead = intermediate[2];
assign MemWrite = intermediate[1];
assign Branch= intermediate[0];
assign ALUOp1 = intermediate[3];
assign ALUOp2 = intermediate[0];
endmodule

// making the ALU Control Unit 
module controlunit_ALU (
    input [5:0] function_field,opcode, // Sadly we can use system verilog , else we would be able to directly use the output of the main controller module 
    output [2:0] operation,
    output [1:0] ALUop
);
wire [1:0] inter;
//wire [1:0] ALUop;
main_control_logic instance1 (.opcode(opcode),.ALUOp1(ALUop[1]),.ALUOp2(ALUop[0]));

or o1(operation[2],ALUop[0],inter[0]);
and a2(inter[0],function_field[1],ALUop[1]);
or a3(operation[1],~ALUop[1],~function_field[2]);
or a4 (inter[1],function_field[3],function_field[0]);
and a5 (operation[0],inter[1],ALUop[1]);
endmodule 

//ALU Control Testbench
module ALU_control_tb;
reg [5:0] function_field,opcode;
wire [1:0] ALUop;
wire [2:0] operation;
controlunit_ALU uut (.function_field(function_field),.opcode(opcode),.operation(operation),.ALUop(ALUop));
initial begin 
    function_field= 6'b000010;
    opcode = 6'b000000;
    #10;
    function_field= 6'b011010;
    opcode = 6'b000100;
    #10;
    $finish;
end
initial begin 
    $monitor($time, "function_field=%b,opcode=%b,operation=%b,ALUop=%b",function_field,opcode,operation,ALUop);
end
endmodule 

/*
module ALU_tb1 ;
reg [31:0] A,B;
reg [1:0] operation;
reg Binvert;
wire [31:0] ALU_result;

ALU_32bit uut (.A(A),.B(B),.operation(operation),.Binvert(Binvert),.ALU_result(ALU_result));

initial begin 
    A=32'h00000000;
    B=32'h00000000;
    operation=2'b00;
    Binvert=1'b0;
    #10
    A=32'h00000001;
    B=32'h00000001;
    operation=2'b10;
    Binvert=1'b0;
    #10
    A=32'h0000ffff;
    B=32'h0000f000;
    operation=2'b01;
    Binvert=1'b0;
    #10
    A=32'h00000000;
    B=32'h00000001;
    operation=2'b10;
    Binvert=1'b1;
    #10
    $finish;
end
initial begin 
    $monitor($time ,"A=%h,B=%h,operation=%b,Binvert=%b,ALU_out=%h",A,B,operation,Binvert,ALU_result);
end
endmodule
    
*/
