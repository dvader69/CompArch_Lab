//This is the solution to the second problem of lab2
// We are asked to use bahavioural modelling in this question 
module comparator_4bit ( 
    input [3:0] A,B ,
    output reg AgreaterB, AeqB, AlessB
);

always @(*) 
begin 
// breaking stuff down to a lower level of abstraction , technically you can just use one if statement to do this
// Why aren't there return statements in verilog , I could have just used a generate for statement for this shit and returned wherever required 
case( {A[3],B[3]}) 

    2'b10: begin
         AgreaterB = 1;
         AeqB=0;
         AlessB=0;
    end
    2'b01: begin 
        AgreaterB = 0;
        AeqB=0;
        AlessB=1;
    end
    default : begin 
        AgreaterB=0;
        AeqB=0;
        AlessB=0;
    end 
endcase 
if( ~AgreaterB && ~AlessB) begin
case( {A[2],B[2]}) 

    2'b10: begin
        AgreaterB = 1;
        AeqB=0;
        AlessB=0;
    end
    2'b01: begin 
        AgreaterB = 0;
        AeqB=0;
        AlessB=1;
    end
    default : begin 
        AgreaterB=0;
        AeqB=0;
        AlessB=0;
    end 
endcase 
end
if(~AgreaterB && ~AlessB) begin
case( {A[1],B[1]}) 

    2'b10: begin
        AgreaterB = 1;
        AeqB=0;
        AlessB=0;
    end
    2'b01: begin 
        AgreaterB = 0;
        AeqB=0;
        AlessB=1;
    end
    default : begin 
        AgreaterB=0;
        AeqB=0;
        AlessB=0;
    end 
endcase 
end
if(~AgreaterB && ~AlessB) begin
case( {A[0],B[0]}) 

    2'b10: begin
        AgreaterB = 1;
        AeqB=0;
        AlessB=0;
    end
    2'b01: begin 
        AgreaterB = 0;
        AeqB=0;
        AlessB=1;
    end
    default : begin 
        AgreaterB=0;
        AeqB=1;
        AlessB=0;
    end 
endcase 
end 
end
endmodule 
