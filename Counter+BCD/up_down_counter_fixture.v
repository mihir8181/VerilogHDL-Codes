// up_down_counter_fixture using verilog


//`include "up_down_counter.v"  //
// declare variable for stimulation input
module up_down_counter_fixture();
  reg clk, en, updn, rst;
  wire [3:0]value;
  //initial value = 4'b0000;
  //initial
     //   $vcdpluson;
  initial
        $monitor($time, " Value = %b value = %d rst = %b en = %b updn = %b", value[3:0],value[3:0],rst, en, updn);      
//instantiation
up_down_counter U1(.CLK(clk), .ENABLE(en), .UPDN(updn), .RST(rst), .VALUE(value));
// intiate all signals
initial
begin
clk = 0;
en = 1;
updn = 1;
rst = 1;
end
// stimulate the clock signal 
initial
begin
  forever #10 clk =~clk;
end
//stimulate the Enable signal
initial
begin
     en = 1'b1;
    #120 en = 1'b0;
    #100 en = 1'b1; 
end
// stimulate the UPDN signal
initial
begin
     updn = 1'b1;
    #200 updn = 1'b0;
    #250 updn = 1'b1;
end
// stimulate the reset signal 
initial
begin
    #5 rst = 1'b0;
    #260 rst = 1'b1;
    #200 rst = 1'b0;
end

// finish the simulation at time
initial
begin
  #1000 $finish;
end
endmodule // 