// This example is given in the labsheet , I am trying my own implementation , but it will just turn out to be very similar to that off the labsheet 
module mealy
    #(
        parameter S0=2'b00,
        parameter S1=2'b01,
        parameter S2=2'b10
    )
     ( 
    input input_seq,clk,reset,
    output reg [1:0] state_reg,
    output reg output_reg
);
always @(posedge clk || reset)
begin 
if (reset) 
begin
    state_reg<= S0;
    output_reg=0;
end
else 
begin
    case(state_reg)

    S0: begin 
        if ( input_seq)
        begin 
            state_reg<=S2;
            output_reg<=0;
        end
        else begin
            state_reg<= S1;
            output_reg<= 1;
        end
    end
    S1: begin
        if( input_seq) 
        begin
            state_reg<=S0;
            output_reg<= 1;
        end
        else begin 
            state_reg<= S2;
            output_reg<= 0;
        end
    end
    S2: begin
        if( input_seq) begin
            state_reg<=S2;
            output_reg<=0; // They havent specified what should be the output for an input of 1 in S2, so assuming it to be 1
        end
        else begin 
            state_reg<=S1;
            output_reg<= 1;
        end
        
    end
    default: begin 
        state_reg<=S0;
        output_reg<=0;
    end
    endcase
end
end


endmodule 

// Now writing the testbench module 
module testbench_melaymachine;

reg input_seq,clk,reset;
wire output_reg;
wire [1:0] state_reg;

mealy uut ( .input_seq(input_seq), .clk(clk), .reset(reset),.output_reg(output_reg),.state_reg(state_reg));

initial begin 
    clk=0;
end
always #5 clk=~clk;
//initial 
//$monitor($time,"input=%b | state=%b | reset=%b|output=%b",input_seq,state_reg,reset,output_reg);
initial begin 
    reset=1;
    #5 reset=0; input_seq=1;
    $monitor($time,"input=%b | state=%b | reset=%b|output=%b",input_seq,state_reg,reset,output_reg);
    #10 input_seq=1;
    $monitor($time,"input=%b | state=%b | reset=%b|output=%b",input_seq,state_reg,reset,output_reg);
    #10 input_seq=0;
    $monitor($time,"input=%b | state=%b | reset=%b|output=%b",input_seq,state_reg,reset,output_reg);
    #10 input_seq=0;
    $monitor($time,"input=%b | state=%b | reset=%b|output=%b",input_seq,state_reg,reset,output_reg);
    #10 input_seq=1;
    $monitor($time,"input=%b | state=%b | reset=%b|output=%b",input_seq,state_reg,reset,output_reg);
    #10 input_seq=0;
    $monitor($time,"input=%b | state=%b | reset=%b|output=%b",input_seq,state_reg,reset,output_reg);
    #10 input_seq=0;
    $monitor($time,"input=%b | state=%b | reset=%b|output=%b",input_seq,state_reg,reset,output_reg);
    #10 input_seq=1;
    $monitor($time,"input=%b | state=%b | reset=%b|output=%b",input_seq,state_reg,reset,output_reg);
    #10 input_seq=1;
    $monitor($time,"input=%b | state=%b | reset=%b|output=%b",input_seq,state_reg,reset,output_reg);
    $finish;
end
endmodule 
