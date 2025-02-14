module counter ( 
    input clk ,
    output [3:0] counter_out
);

wire int2, int1;
jk_ff j1 (.j(1'b1),.k(1'b1),.clk(clk),.q(counter_out[3]));
jk_ff j2 (.j(counter_out[3]),.k(counter_out[3]),.clk(clk),.q(counter_out[2]));
jk_ff j3 (.j(int2),.k(int2),.clk(clk),.q(counter_out[1]));
jk_ff j4 (.j(int1),.k(int1),.clk(clk),.q(counter_out[0]));
assign int2= counter_out[3] & counter_out[2] ;
assign int1 = counter_out[1] & int2; 
endmodule 
module jk_ff (
    input j,
    input k,
    input clk,
    output reg q
);

   initial q = 0; // Make sure that you instantiate q with 0 , inorder to avoid going into an undefined state 
   // The initial statement can not be synthesized in hardware though , keep that in mind, there you can use reset 
   always @ (posedge clk) begin
      case ({j, k})
         2'b00:  q <= q;     
         2'b01:  q <= 0;    
         2'b10:  q <= 1;    
         2'b11:  q <= ~q;    
      endcase
   end
endmodule

