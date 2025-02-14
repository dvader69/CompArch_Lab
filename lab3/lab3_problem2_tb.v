`include "lab3_problem2.v"
module testbench_fsm;

reg in_seq,clk,reset;
wire [2:0] state_reg;
wire detector_out;

state_machine uut ( .input_reg(in_seq), .clk(clk) , .reset(reset),.state_reg(state_reg),.output_reg(detector_out));
initial begin 
    clk=0;
end

always #5 clk=~clk;
//initial
 //   $monitor(,$time, "input=%b,reset=%b,state=%b, output=%b",in_seq,reset,state_reg,detector_out);
initial begin 
    reset=1;
    #5 reset=0; in_seq=0;
    $monitor(,$time, "input=%b,reset=%b,state=%b, output=%b",in_seq,reset,state_reg,detector_out);
    #10 in_seq=1;
    $monitor(,$time, "input=%b,reset=%b,state=%b, output=%b",in_seq,reset,state_reg,detector_out);
    #10 in_seq=0;
    $monitor(,$time, "input=%b,reset=%b,state=%b, output=%b",in_seq,reset,state_reg,detector_out);
    #10 in_seq=1;
    $monitor(,$time, "input=%b,reset=%b,state=%b, output=%b",in_seq,reset,state_reg,detector_out);
    #10 in_seq=1;
    $monitor(,$time, "input=%b,reset=%b,state=%b, output=%b",in_seq,reset,state_reg,detector_out);
    #10 in_seq=0;
    $monitor(,$time, "input=%b,reset=%b,state=%b, output=%b",in_seq,reset,state_reg,detector_out);
    #10 in_seq=1;
    $monitor(,$time, "input=%b,reset=%b,state=%b, output=%b",in_seq,reset,state_reg,detector_out);
    #10 in_seq=1;
    $monitor(,$time, "input=%b,reset=%b,state=%b, output=%b",in_seq,reset,state_reg,detector_out);
    #10 in_seq=0;
    $monitor(,$time, "input=%b,reset=%b,state=%b, output=%b",in_seq,reset,state_reg,detector_out);
    #10 in_seq=0;
    $monitor(,$time, "input=%b,reset=%b,state=%b, output=%b",in_seq,reset,state_reg,detector_out);
    #10 in_seq=1;
    $monitor(,$time, "input=%b,reset=%b,state=%b, output=%b",in_seq,reset,state_reg,detector_out);
    #10 in_seq=1;
    $monitor(,$time, "input=%b,reset=%b,state=%b, output=%b",in_seq,reset,state_reg,detector_out);
    #10 in_seq=0;
    $monitor(,$time, "input=%b,reset=%b,state=%b, output=%b",in_seq,reset,state_reg,detector_out);
    #10 in_seq=1;
    $monitor(,$time, "input=%b,reset=%b,state=%b, output=%b",in_seq,reset,state_reg,detector_out);
    #10 in_seq=1;
    $monitor(,$time, "input=%b,reset=%b,state=%b, output=%b",in_seq,reset,state_reg,detector_out);
    #10 in_seq=0;
    $monitor(,$time, "input=%b,reset=%b,state=%b, output=%b",in_seq,reset,state_reg,detector_out);
    #10 in_seq=1;
    $monitor(,$time, "input=%b,reset=%b,state=%b, output=%b",in_seq,reset,state_reg,detector_out);
    #10 in_seq=1;
    $monitor(,$time, "input=%b,reset=%b,state=%b, output=%b",in_seq,reset,state_reg,detector_out);

    $finish;
end

endmodule
