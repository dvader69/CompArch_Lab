`include "lab3_problem3.v"
module testbench_serialadder; 
reg data_in1, data_in2,reset,clk,shift_control;
wire sum,cout;

serial_adder uut (.data_in1(data_in1),.data_in2(data_in2),.clk(clk),.reset(reset),.shift_control(shift_control),.sum(sum),.cout(cout));
initial begin 
    clk=0;
end
always #5 clk=~clk;

initial begin 
    
    reset=1;shift_control=0;
    #5 reset=0; shift_control=1; data_in1=0; data_in2=0;
    #10 data_in1=1; data_in2=1;
    $monitor($time,"data_in1=%b|data_in2=%b|reset=%b|shift_enable=%b|sum=%b|cout=%b",data_in1,data_in2,reset,shift_control,sum,cout);
    #10 data_in1=1; data_in2=0;
    $monitor($time,"data_in1=%b|data_in2=%b|reset=%b|shift_enable=%b|sum=%b|cout=%b",data_in1,data_in2,reset,shift_control,sum,cout);
    #10 data_in1=1; data_in2=1;
    $monitor($time,"data_in1=%b|data_in2=%b|reset=%b|shift_enable=%b|sum=%b|cout=%b",data_in1,data_in2,reset,shift_control,sum,cout);
    #10 data_in1=1; data_in2=1;
    $monitor($time,"data_in1=%b|data_in2=%b|reset=%b|shift_enable=%b|sum=%b|cout=%b",data_in1,data_in2,reset,shift_control,sum,cout);
    #10 data_in1=1; data_in2=1;
    $monitor($time,"data_in1=%b|data_in2=%b|reset=%b|shift_enable=%b|sum=%b|cout=%b",data_in1,data_in2,reset,shift_control,sum,cout);
    #10 data_in1=0; data_in2=0;
    $monitor($time,"data_in1=%b|data_in2=%b|reset=%b|shift_enable=%b|sum=%b|cout=%b",data_in1,data_in2,reset,shift_control,sum,cout);
       #10 data_in1=1; data_in2=1;
    $monitor($time,"data_in1=%b|data_in2=%b|reset=%b|shift_enable=%b|sum=%b|cout=%b",data_in1,data_in2,reset,shift_control,sum,cout);
    #10 data_in1=0; data_in2=0;
    $monitor($time,"data_in1=%b|data_in2=%b|reset=%b|shift_enable=%b|sum=%b|cout=%b",data_in1,data_in2,reset,shift_control,sum,cout);
    #10 data_in1=0; data_in2=1;
    $monitor($time,"data_in1=%b|data_in2=%b|reset=%b|shift_enable=%b|sum=%b|cout=%b",data_in1,data_in2,reset,shift_control,sum,cout);
    #10 data_in1=0; data_in2=0;
    $monitor($time,"data_in1=%b|data_in2=%b|reset=%b|shift_enable=%b|sum=%b|cout=%b",data_in1,data_in2,reset,shift_control,sum,cout);
    $finish;
end
endmodule 