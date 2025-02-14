// Note: You can also initialize stuff using the initial statement, I am avoiding that though as we can't synthesize the "initial" statement in verilog
module serial_adder (
    input data_in1,data_in2, clk,shift_control,reset,
    output reg sum,cout
);
wire [1:0] shift_regout;
reg prev_carry_out;
shift_reg_4bit i1 ( .data_in(data_in1),.clk(clk),.enable(shift_control),.reset(reset),.data_out(shift_regout[1]));
shift_reg_4bit i2 ( .data_in(data_in2),.clk(clk),.enable(shift_control),.reset(reset),.data_out(shift_regout[0]));
always @ (*)
begin     
    if (reset) begin 
        prev_carry_out<=0;
        sum<=0;
        cout<=0;
    end
    else begin
sum <=shift_regout[1] ^ shift_regout[0] ^ prev_carry_out ;
cout <= (shift_regout[1] & shift_regout[0]) || ((prev_carry_out&(shift_regout[1]^shift_regout[0])));
    end
end
always @ (posedge clk)
begin
if(shift_control)
prev_carry_out <= cout;
end

endmodule 

// We have been asked to use this module as an intermediate module in the implementation
module shift_reg_4bit ( 
    input data_in,clk,reset,enable,
    output reg data_out
);

reg [3:0] shifter;

always @ (posedge clk || reset) begin 
   if(reset) begin
   shifter<= 0;
   data_out<=0;
   end
   else begin 
    if( enable ) begin 
        shifter<= {data_in,shifter[3:1]} ;
        data_out<=shifter[0];
    end
    else begin
    shifter<= shifter;
    data_out<= shifter[0];
    end
   end
end
endmodule 
/*
// the testbench for the main module 
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
*/

/*
//this is the testbench code for the shifter module
module testbench_shiftreg ;
reg data_in,clk,reset,enable;
wire data_out;

shift_reg_4bit uut( .data_in(data_in),.clk(clk),.reset(reset),.enable(enable),.data_out(data_out));

initial begin 
    clk=0;
end
always #5 clk=~clk;

initial begin 
    
    reset=1;
    enable=0;
    #5 reset=0; enable=1; data_in=0;
    $monitor($time,"data_in=%b|reset=%b|state=%b|enable=%b|data_out=%b",data_in,reset,uut.shifter,enable,data_out);
    #10 data_in=1;
    $monitor($time,"data_in=%b|reset=%b|state=%b|enable=%b|data_out=%b",data_in,reset,uut.shifter,enable,data_out);
    #10 data_in=0;
    $monitor($time,"data_in=%b|reset=%b|state=%b|enable=%b|data_out=%b",data_in,reset,uut.shifter,enable,data_out);
    #10 data_in=1;
    $monitor($time,"data_in=%b|reset=%b|state=%b|enable=%b|data_out=%b",data_in,reset,uut.shifter,enable,data_out);
    #10 data_in=0;
    $monitor($time,"data_in=%b|reset=%b|state=%b|enable=%b|data_out=%b",data_in,reset,uut.shifter,enable,data_out);
    #10 data_in=1;
    $monitor($time,"data_in=%b|reset=%b|state=%b|enable=%b|data_out=%b",data_in,reset,uut.shifter,enable,data_out);
    #10 data_in=0;
    $monitor($time,"data_in=%b|reset=%b|state=%b|enable=%b|data_out=%b",data_in,reset,uut.shifter,enable,data_out);
    #10 data_in=1;
    $monitor($time,"data_in=%b|reset=%b|state=%b|enable=%b|data_out=%b",data_in,reset,uut.shifter,enable,data_out);
    $finish;
end
endmodule 

*/