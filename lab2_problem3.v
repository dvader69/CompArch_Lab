// The final task of this lab is to make a 4-bit full adder/subtractor 
// M=0 (add) , M=1 (subtract) , V--> overflow flag 

module add_sub_4bit ( 
    input [3:0] A,B,
    input M,
    output [3:0] logical_out,
    output V
);

reg[3:0] B_int;
wire [3:0] carry_out;
always @(*)
begin
if (M) 
B_int= ~B;
else 
B_int = B;
end
full_adder FA (.A(A[0]) ,.B(B_int[0]),.cin(M), .sum(logical_out[0]),.cout(carry_out[0]));
genvar j;
generate 
    for(j=1;j<4;j=j+1) begin 
        full_adder FA(.A(A[j]) ,.B(B_int[j]),.cin(carry_out[j-1]), .sum(logical_out[j]),.cout(carry_out[j]));
    end
endgenerate
assign V= carry_out[3]^carry_out[2];

endmodule 


//Implementing a full adder using behavioural modelling 
module full_adder ( 
    input A,B,cin,
    output reg sum,cout
);

always @ (*) 
begin 
    sum= A^B^cin;
    cout = (A&B) || (cin&(A^B));
end
endmodule 
