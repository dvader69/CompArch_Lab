module d_flipflop (
    input D,clk,reset,
    output reg Q
) ;

always @ (posedge clk or reset )
begin 
    if(~reset)
    Q<=0;
    else begin 
        Q<= D;
    end 
end
endmodule 

module register_32_bit ( 
    input [31:0] data_in,
    input clk,reset,
    output [31:0] data_out
); 

genvar i;
generate 
    for( i=0 ; i<32; i=i+1) begin 
        d_flipflop ff (.clk(clk), .reset(reset), .D(data_in[i]), .Q(data_out[i]));
    end
endgenerate 
endmodule 

module multiplexer ( 
    input [31:0] reg_data_in_0 , reg_data_in_1,reg_data_in_2,reg_data_in_3,
    input [1:0] sel,
    output reg [31:0] reg_data_out
);
always @ (*) begin
case(sel) 
2'b00: reg_data_out= reg_data_in_0 ;
2'b01: reg_data_out= reg_data_in_1;
2'b10: reg_data_out= reg_data_in_2;
2'b11: reg_data_out= reg_data_in_3;
endcase 
end
endmodule 

module register_file ( 
    input [1:0] read_register_1, read_register_2,  
    input [1:0] la,
    input [31:0] write_data ,
    input reg_write,clk ,reset,
    output [31:0] read_data_1, read_data_2,
    output [3:0] test
);
wire [31:0] register_output [3:0]; 
reg [3:0] decoder_out;
multiplexer instance1 (.reg_data_in_0(register_output[0]),.reg_data_in_1(register_output[1]),.reg_data_in_2(register_output[2]),.reg_data_in_3(register_output[3]),.sel(read_register_1),.reg_data_out(read_data_1));
multiplexer instance2 (.reg_data_in_0(register_output[0]),.reg_data_in_1(register_output[1]),.reg_data_in_2(register_output[2]),.reg_data_in_3(register_output[3]),.sel(read_register_2),.reg_data_out(read_data_2));
//decoder decoder1 ( .reg_write(write_register),.reg_out(decoder_out)); 
always @ (*) 
begin 
    case(la) 
    2'b00:decoder_out=4'b0001;
    2'b01:decoder_out=4'b0010;
    2'b10:decoder_out=4'b0100;
    2'b11:decoder_out=4'b1000;
    default:decoder_out=4'b0000;
    endcase
end

  
        register_32_bit reg1 (.data_in(write_data), .clk(clk & reg_write & decoder_out[0] ), .data_out(register_output[0]),.reset(reset));
        register_32_bit reg2 (.data_in(write_data), .clk(clk & reg_write & decoder_out[1] ), .data_out(register_output[1]),.reset(reset));
        register_32_bit reg3 (.data_in(write_data), .clk(clk & reg_write & decoder_out[2] ), .data_out(register_output[2]),.reset(reset));
        register_32_bit reg4 (.data_in(write_data), .clk(clk & reg_write & decoder_out[3] ), .data_out(register_output[3]),.reset(reset));
 
endmodule 


module register_file_testbench ;
    reg [1:0] read_register_1, read_register_2,la;
    reg [31:0] write_data;
    reg reg_write, clk,reset;
    wire [31:0] read_data_1, read_data_2 ;
    register_file uut (.read_data_1(read_data_1),.la(la), .read_data_2(read_data_2),.write_data(write_data),.reg_write(reg_write),.read_register_2(read_register_2),.read_register_1(read_register_1),.reset(reset),.clk(clk));
    always #5 clk= ~clk;
    initial begin 
        clk=1;
        reset=0;
        reg_write=0;
        write_data=0;
        #10 reset =1;
        read_register_1=2'b11; read_register_2=2'b00;
        #10
        reg_write=1; read_register_1=2'b01; read_register_2=2'b11;la=2'b01;write_data=32'hfff7aaaa;
        #10
        reg_write=1; read_register_1=2'b11; read_register_2=2'b10;la=2'b11;write_data=32'h1234aaaa;
        #10
        reg_write=1; read_register_1=2'b00; read_register_2=2'b10;la=2'b00;write_data=32'heeeeaaa0;
        #10
        reg_write=1; read_register_1=2'b11; read_register_2=2'b10;la=2'b10;write_data=32'heeeeaaaa;
        #10 $finish;
    end 
    initial begin 
        $monitor($time, "read_data1=%h,read_data_2=%h,write_data=%h,write_register=%b",read_data_1,read_data_2,write_data,la);
    end
endmodule 




/*
module register_32_tb ;
reg [31:0] data_in;
reg clk, reset;
wire [31:0] data_out;
register_32_bit uut (.clk(clk),.reset(reset), .data_in(data_in), .data_out(data_out));
always #5 clk=~clk;
initial begin 
    clk=1;
    reset=0;
    data_in=0;
    #10 reset=1;
    #10
    data_in= 32'hAFAFAFAF;
    #10 data_in= 32'h0000FFFF;
    #10 data_in = 32'h69696969;
    #10 $finish;
end 
initial begin 
    $monitor($time , "data_in=%h, data_out=%h ", data_in, data_out);
end
endmodule 
*/



/*
module D_FF_tb;
reg D,clk,reset;
wire Q;
d_flipflop uut (.D(D) , .clk(clk), .reset(reset), .Q(Q));
always #5 clk=~clk;
initial begin 
    clk=1;
    reset=0;
    D=0;

#10 reset=1;
D=1;
#10 D=0;
#10 D=1;
#10 D=0;
#10 $finish;
end

initial begin 
    $monitor($time , "D=%b, Q=%b",D,Q);
end
endmodule 
*/ 


