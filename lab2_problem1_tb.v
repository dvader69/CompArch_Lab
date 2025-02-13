`include "lab2_problem1.v"
module testbench_problem1 ;
reg A,B,C;
wire sum,cout;
full_adder uut ( .A(A) , .B(B), .C(C) , .sum(sum), .cout(cout));

// If you want to use gtkwave
 /*initial begin
        $dumpfile("waveform.vcd"); // File to store waveforms
        $dumpvars(0, testbench_problem1); // Dump all variables in the testbench
    end */
initial
 $monitor(,$time,"A=%b,B=%b,C=%b,sum=%b,cout=%b",A,B,C,sum,cout);
    initial begin 
        A=0; B=0;C=0;
        #2 A=0; B=0;C=1;
        #4 A=0; B=1;C=1;
        #6 A=0; B=0;C=1;
        #8 A=0; B=1;C=1;
        #10 A=1; B=0;C=1;
        #12 A=1; B=0;C=1;
        #14 A=1; B=0;C=1;
        #16 A=1; B=1;C=1;
        $finish;
    end 
endmodule 
