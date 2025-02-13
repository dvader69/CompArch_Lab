`include "lab2_problem3.v"
module lab2_problem3_tb;

reg [3:0] A,B;
reg M;
wire [3:0] logical_out;
wire V;

add_sub_4bit uut ( .A(A),.B(B),.M(M),.logical_out(logical_out),.V(V));

initial 
$monitor(,$time,"A=%b,B=%b,M=%b,output=%b,overflow=%b",A,B,M,logical_out,V);
initial begin 
    A=4'b0000;B= 4'b1100; M=0;
    #10;
    A=4'b1111; B=4'b0001;M=1;
    #10;
    A=4'b1111; B=4'b0001;M=1;
    #10;
    A=4'b1111; B=4'b1001;M=1;
    #10;
    A=4'b1000; B=4'b1001;M=0;
    #10;
    A=4'b1111; B=4'b0001;M=1;
    
    $finish;
end
endmodule 

