// register file having 32-registers each of 32-bit
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
    input [31:0] reg_data_in_0 , reg_data_in_1,reg_data_in_2,reg_data_in_3 ,
    reg_data_in_4 , reg_data_in_5,reg_data_in_6,reg_data_in_7 ,
    reg_data_in_8 , reg_data_in_9,reg_data_in_10,reg_data_in_11 ,
    reg_data_in_12 , reg_data_in_13,reg_data_in_14,reg_data_in_15 ,
    reg_data_in_16 , reg_data_in_17,reg_data_in_18,reg_data_in_19 ,
    reg_data_in_20 , reg_data_in_21,reg_data_in_22,reg_data_in_23 ,
    reg_data_in_24 , reg_data_in_25,reg_data_in_26,reg_data_in_27 ,
    reg_data_in_28 , reg_data_in_29,reg_data_in_30,reg_data_in_31 ,
    input [4:0] sel,
    output reg [31:0] reg_data_out
);
always @ (*) begin
case(sel) 
5'b00000: reg_data_out= reg_data_in_0 ;
5'b00001: reg_data_out= reg_data_in_1;
5'b00010: reg_data_out= reg_data_in_2;
5'b00011: reg_data_out= reg_data_in_3;
5'b00100: reg_data_out= reg_data_in_4 ;
5'b00101: reg_data_out= reg_data_in_5;
5'b00110: reg_data_out= reg_data_in_6;
5'b00111: reg_data_out= reg_data_in_7;
5'b01000: reg_data_out= reg_data_in_8 ;
5'b01001: reg_data_out= reg_data_in_9;
5'b01010: reg_data_out= reg_data_in_10;
5'b01011: reg_data_out= reg_data_in_11;
5'b01100: reg_data_out= reg_data_in_12 ;
5'b01101: reg_data_out= reg_data_in_13;
5'b01110: reg_data_out= reg_data_in_14;
5'b01111: reg_data_out= reg_data_in_15;
5'b10000: reg_data_out= reg_data_in_16 ;
5'b10001: reg_data_out= reg_data_in_17;
5'b10010: reg_data_out= reg_data_in_18;
5'b10011: reg_data_out= reg_data_in_19;
5'b10100: reg_data_out= reg_data_in_20 ;
5'b10101: reg_data_out= reg_data_in_21;
5'b10110: reg_data_out= reg_data_in_22;
5'b10111: reg_data_out= reg_data_in_23;
5'b11000: reg_data_out= reg_data_in_24 ;
5'b11001: reg_data_out= reg_data_in_25;
5'b11010: reg_data_out= reg_data_in_26;
5'b11011: reg_data_out= reg_data_in_27;
5'b11100: reg_data_out= reg_data_in_28;
5'b11101: reg_data_out= reg_data_in_29;
5'b11110: reg_data_out= reg_data_in_30;
5'b11111: reg_data_out= reg_data_in_31;
endcase 
end
endmodule 

module register_file ( 
    input [4:0] read_register_1, read_register_2,  
    input [4:0] la,
    input [31:0] write_data ,
    input reg_write ,reset,
    output [31:0] read_data_1, read_data_2
);
reg [31:0] register_output [31:0]; 
reg [31:0] decoder_out;
initial begin 
    register_output[1]= 32'h0000000f;
    register_output[3]= 32'h00000001;
    register_output[2]= 32'h00000000;
    register_output[4]= 32'h00000000;
    register_output[0]= 32'h00000000;
    register_output[5]= 32'h00000000;
    register_output[6]= 32'h00000000;
    register_output[7]= 32'h00000000;
    register_output[8]= 32'h00000000;
    register_output[9]= 32'h00000000;
    register_output[10]= 32'h00000000;
    register_output[11]= 32'h00000000;
    register_output[12]= 32'h00000000;
    register_output[13]= 32'h00000000;
    register_output[14]= 32'h00000000;
    register_output[15]= 32'h00000000;
    register_output[16]= 32'h00000000;
    register_output[17]= 32'h00000000;
    register_output[18]= 32'h00000000;
    register_output[19]= 32'h00000000;
    register_output[20]= 32'h00000000;
    register_output[21]= 32'h00000000;
    register_output[22]= 32'h00000000;
    register_output[23]= 32'h00000000;
    register_output[24]= 32'h00000000;
    register_output[25]= 32'h00000000;
    register_output[26]= 32'h00000000;
    register_output[27]= 32'h00000000;
    register_output[28]= 32'h00000000;
    register_output[29]= 32'h00000000;
    register_output[30]= 32'h00000000;
    register_output[31]= 32'h00000000;
end

multiplexer instance1 (.reg_data_in_0(register_output[0]),.reg_data_in_1(register_output[1]),.reg_data_in_2(register_output[2]),.reg_data_in_3(register_output[3]),
.reg_data_in_4(register_output[4]),.reg_data_in_5(register_output[5]),.reg_data_in_6(register_output[6]),.reg_data_in_7(register_output[7]),
.reg_data_in_8(register_output[8]),.reg_data_in_9(register_output[9]),.reg_data_in_10(register_output[10]),.reg_data_in_11(register_output[11]),
.reg_data_in_12(register_output[12]),.reg_data_in_13(register_output[13]),.reg_data_in_14(register_output[14]),.reg_data_in_15(register_output[15]),
.reg_data_in_16(register_output[16]),.reg_data_in_17(register_output[17]),.reg_data_in_18(register_output[18]),.reg_data_in_19(register_output[19]),
.reg_data_in_20(register_output[20]),.reg_data_in_21(register_output[21]),.reg_data_in_22(register_output[22]),.reg_data_in_23(register_output[23]),
.reg_data_in_24(register_output[24]),.reg_data_in_25(register_output[25]),.reg_data_in_26(register_output[26]),.reg_data_in_27(register_output[27]),
.reg_data_in_28(register_output[28]),.reg_data_in_29(register_output[29]),.reg_data_in_30(register_output[30]),.reg_data_in_31(register_output[31]),
.sel(read_register_1),.reg_data_out(read_data_1));
multiplexer instance2 (.reg_data_in_0(register_output[0]),.reg_data_in_1(register_output[1]),.reg_data_in_2(register_output[2]),.reg_data_in_3(register_output[3]),
.reg_data_in_4(register_output[4]),.reg_data_in_5(register_output[5]),.reg_data_in_6(register_output[6]),.reg_data_in_7(register_output[7]),
.reg_data_in_8(register_output[8]),.reg_data_in_9(register_output[9]),.reg_data_in_10(register_output[10]),.reg_data_in_11(register_output[11]),
.reg_data_in_12(register_output[12]),.reg_data_in_13(register_output[13]),.reg_data_in_14(register_output[14]),.reg_data_in_15(register_output[15]),
.reg_data_in_16(register_output[16]),.reg_data_in_17(register_output[17]),.reg_data_in_18(register_output[18]),.reg_data_in_19(register_output[19]),
.reg_data_in_20(register_output[20]),.reg_data_in_21(register_output[21]),.reg_data_in_22(register_output[22]),.reg_data_in_23(register_output[23]),
.reg_data_in_24(register_output[24]),.reg_data_in_25(register_output[25]),.reg_data_in_26(register_output[26]),.reg_data_in_27(register_output[27]),
.reg_data_in_28(register_output[28]),.reg_data_in_29(register_output[29]),.reg_data_in_30(register_output[30]),.reg_data_in_31(register_output[31]),
.sel(read_register_2),.reg_data_out(read_data_2));
//decoder decoder1 ( .reg_write(write_register),.reg_out(decoder_out)); 
always @ (*) 
begin 
case(la) 
5'b00000: decoder_out=32'b0000_0000_0000_0000_0000_0000_0000_0001;
5'b00001: decoder_out=32'b0000_0000_0000_0000_0000_0000_0000_0010;
5'b00010: decoder_out=32'b0000_0000_0000_0000_0000_0000_0000_0100;
5'b00011: decoder_out=32'b0000_0000_0000_0000_0000_0000_0000_1000;
5'b00100: decoder_out=32'b0000_0000_0000_0000_0000_0000_0001_0000;
5'b00101: decoder_out=32'b0000_0000_0000_0000_0000_0000_0010_0000;
5'b00110: decoder_out=32'b0000_0000_0000_0000_0000_0000_0100_0000;
5'b00111: decoder_out=32'b0000_0000_0000_0000_0000_0000_1000_0000;
5'b01000: decoder_out=32'b0000_0000_0000_0000_0000_0001_0000_0000;
5'b01001: decoder_out=32'b0000_0000_0000_0000_0000_0010_0000_0000;
5'b01010: decoder_out=32'b0000_0000_0000_0000_0000_0100_0000_0000;
5'b01011: decoder_out=32'b0000_0000_0000_0000_0000_1000_0000_0000;
5'b01100: decoder_out=32'b0000_0000_0000_0000_0001_0000_0000_0000;
5'b01101: decoder_out=32'b0000_0000_0000_0000_0010_0000_0000_0000;
5'b01110: decoder_out=32'b0000_0000_0000_0000_0100_0000_0000_0000;
5'b01111: decoder_out=32'b0000_0000_0000_0000_1000_0000_0000_0000;
5'b10000: decoder_out=32'b0000_0000_0000_0001_0000_0000_0000_0000;
5'b10001: decoder_out=32'b0000_0000_0000_0010_0000_0000_0000_0000;
5'b10010: decoder_out=32'b0000_0000_0000_0100_0000_0000_0000_0000;
5'b10011: decoder_out=32'b0000_0000_0000_1000_0000_0000_0000_0000;
5'b10100: decoder_out=32'b0000_0000_0001_0000_0000_0000_0000_0000;
5'b10101: decoder_out=32'b0000_0000_0010_0000_0000_0000_0000_0000;
5'b10110: decoder_out=32'b0000_0000_0100_0000_0000_0000_0000_0000;
5'b10111: decoder_out=32'b0000_0000_1000_0000_0000_0000_0000_0000;
5'b11000: decoder_out=32'b0000_0001_0000_0000_0000_0000_0000_0000;
5'b11001: decoder_out=32'b0000_0010_0000_0000_0000_0000_0000_0000;
5'b11010: decoder_out=32'b0000_0100_0000_0000_0000_0000_0000_0000;
5'b11011: decoder_out=32'b0000_1000_0000_0000_0000_0000_0000_0000;
5'b11100: decoder_out=32'b0001_0000_0000_0000_0000_0000_0000_0000;
5'b11101: decoder_out=32'b0010_0000_0000_0000_0000_0000_0000_0000;
5'b11110: decoder_out=32'b0100_0000_0000_0000_0000_0000_0000_0000;
5'b11111: decoder_out=32'b1000_0000_0000_0000_0000_0000_0000_0000;
    
    default:decoder_out=32'd1;
    endcase
end

  genvar i;
  generate 
    for(i=0;i<32;i=i+1) begin 
        register_32_bit regu (.data_in(write_data), .clk( reg_write & decoder_out[i] ), .data_out(),.reset(reset));
    end
    endgenerate
endmodule 


module register_file_testbench ;
    reg [4:0] read_register_1, read_register_2,la;
    reg [31:0] write_data;
    reg reg_write,reset;
    wire [31:0] read_data_1, read_data_2 ;
    register_file uut (.read_data_1(read_data_1),.la(la), .read_data_2(read_data_2),.write_data(write_data),.reg_write(reg_write),.read_register_2(read_register_2),.read_register_1(read_register_1),.reset(reset));
    initial begin 
   
        reset=0;
        reg_write=0;
        la=0;
        write_data=0;
        #10 reset =1;
        read_register_1=5'b11111; read_register_2=5'b00000;
        #10
        reg_write=1; read_register_1=5'b00001; read_register_2=5'b00111;la=5'b00001;write_data=32'hffffffff;
        #10
        reg_write=1; read_register_1=5'b00011; read_register_2=5'b00010;la=5'b00011;write_data=32'h1234aaaa;
        #10
        reg_write=1; read_register_1=5'b00000; read_register_2=5'b00001;la=5'b00000;write_data=32'heeeeaaa0;
        #10
        reg_write=1; read_register_1=5'b00011; read_register_2=5'b00010;la=5'b00010;write_data=32'heeeeaaaa;
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


