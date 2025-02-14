module full_adder ( 
    input A,B,C ,
    output sum,cout
);
wire [0:7] decoder;
decoder3_8 m1 (A,B,C, decoder);

assign sum= decoder[1]||decoder[2]||decoder[4]||decoder[7];
assign cout= decoder[3]||decoder[5]||decoder[6]||decoder[7];
endmodule // If you wan to do bitwise or use | , but here all statements are only 1 bit so || also works


module decoder3_8( 
    input A,B,C,
    output [0:7] decoder_out
) ;  
//I'll make the gate level module of a 3:8 decoder now 
wire Abar,Bbar,Cbar;
not n1 (Abar,A);
not n2 (Bbar,B);
not n3 (Cbar,C);

and a1 (decoder_out[0],Abar,Bbar,Cbar);
and a2 (decoder_out[1],Abar,Bbar,C);
and a3 (decoder_out[2],Abar,B,Cbar);
and a4 (decoder_out[3],Abar,B,C);
and a5 (decoder_out[4],A,Bbar,Cbar);
and a6 (decoder_out[5],A,Bbar,C);
and a7 (decoder_out[6],A,B,Cbar);
and a8 (decoder_out[7],A,B,C);
endmodule 
