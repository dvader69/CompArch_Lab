module state_machine 
#(parameter S0 = 3'b000,
parameter S1= 3'b001,
parameter S2= 3'b010,
parameter S3= 3'b011,
parameter S4=3'b100)
( 
        input input_reg ,
        input clk ,reset,
       output reg [2:0] state_reg,
        output output_reg
);
// I have implemented it as a mealay machine, a moore machine implementation can also be done 
//reg input_reg; 
reg output_reg;
//reg [2:0] state_reg;

 always @ (posedge clk ) 
 begin 
    if(reset) begin
    state_reg<=S0;
    output_reg<=0;
    output_reg<=0;
    end
    else
    begin
    case(state_reg)
    S0:
    begin 
        
        if( input_reg) 
        begin
        state_reg<= S1;
        output_reg<=0;
        end
        else
        begin
        state_reg<=S0;
        output_reg<= 0;
        end
    end
    S1:
    begin
    if (input_reg) begin
        state_reg<= S1;
        output_reg<=0;
    end
    else begin
        state_reg<=S2;
        output_reg<=0;
    end
    end
    S2:
    begin
        if ( input_reg)
        begin
            state_reg<= S3;
        output_reg<=0;
        end
        else 
        begin
            state_reg<=S0;
          /*  if(prev_state_reg==S4)
            output_reg<=1;
            else */
            output_reg<=0;
        end
    end
    S3: 
    begin
    if(input_reg) 
        begin 
            state_reg<=S4;
            output_reg<=0;
        end
        else 
        begin 
            state_reg<= S2;
            output_reg<=0;
        end
    end
    S4:
    begin
    if( input_reg)
        begin 
            state_reg<=S1;
            output_reg<=0;
        end
        else 
        begin
        state_reg<=S2;
        output_reg<=1;   // output will only be one when transitioning from S4 to S2 , sence scheduling the output to be one  if input=0 in S4
        end
    end
    endcase
    end
 end
 
endmodule 

/*
module testbench_fsm;

reg in_seq,clk,reset;
wire [2:0] state_reg;
wire detector_out;

state_machine uut ( .input_reg(in_seq), .clk(clk) , .reset(reset),.output_reg(detector_out),.state_reg(state_reg));
initial begin 
    clk=0;
end

always #5 clk=~clk;
initial
    $monitor(,$time, "input=%b,reset=%b,state=%b, output=%b",in_seq,reset,state_reg,detector_out);
initial begin 
    reset=1;
    #10 reset=0; in_seq=0;
    #10 in_seq=1;
    #10 in_seq=0;
    #10 in_seq=1;
    #10 in_seq=1;
    #10 in_seq=0;
    #10 in_seq=1;
    #10 in_seq=1;
    #10 in_seq=0;
    #10 in_seq=0;
    #10 in_seq=1;
    #10 in_seq=1;


    $finish;
end

endmodule
*/
