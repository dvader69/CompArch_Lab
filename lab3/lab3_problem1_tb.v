`include"lab3_problem1.v"


module counter_tb;
reg clk;
wire [3:0] counter_out;

counter uut (.clk(clk), .counter_out(counter_out));

always #5 clk=~clk ;
initial begin 
    clk=0;
    #500;
    $finish;
end
initial begin
      $monitor ("counter_out=%b",    counter_out);
   end
endmodule

//This is the testbench code for the jk flipflop module 
/*
module tb_jk;
   reg j;
   reg k;
   reg clk;
   wire q;

   
   jk_ff jk0 (
       .j(j),
       .k(k),
       .clk(clk),
       .q(q)
   );

   always #5 clk = ~clk;

   initial begin
     
      clk = 0;
      j = 0;
      k = 0;

     
      #10 j = 1; k = 0;  
      #10 j = 0; k = 1;  
      #10 j = 1; k = 1;  
      #10 $finish;
   end
   initial begin
      $monitor (" | j=%b k=%b clk=%b q=%b",  j, k, clk, q);
   end
endmodule
*/