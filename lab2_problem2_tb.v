`include "lab2_problem2.v"

module lab2_problem2_tb;

reg [3:0] A,B;
wire AgreaterB, AlessB,AeqB;

comparator_4bit uut (.A(A),.B(B),.AgreaterB(AgreaterB),.AeqB(AeqB),.AlessB(AlessB));

initial 
$monitor(,$time, "A=%b,B=%b,AgreaterB=%b,AeqB=%b,AlessB=%b",A,B,AgreaterB,AeqB,AlessB);
initial begin 
    A=4'b1000; B=4'b1000;
    #2 A=4'b1010; B=4'b1000;
    #2 A=4'b1010; B=4'b1000;
    #2 A=4'b1011; B=4'b1010;
    #2 A=4'b1010; B=4'b1010;
    #2 A=4'b1010; B=4'b1100;
    #2 A=4'b1110; B=4'b1011;
    $finish;
end 
endmodule 

