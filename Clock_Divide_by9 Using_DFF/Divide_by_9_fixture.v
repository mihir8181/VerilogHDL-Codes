//-------------------------//
//  Divide by 9 Testbench  //
//------------------------//
`timescale 1ns/1ps
`include "Divide_by_9.v"
`include "D_FlipFlop.v"
module Divide_by_9_fixture();
reg clk,rst;
wire clk9;

initial
$vcdpluson;

Divide_by_9 dut_1(.clk(clk), .rst(rst), .clk9(clk9));

initial
begin
$display("Time \trst \tclk \tq0 \tq1 \tq2 \tq3 \tclk9\n");
$monitor("%04t \t%b \t%b \t%b \t%b \t%b \t%b \t%b", $time, rst, clk, dut_1.q0, dut_1.q1, dut_1.q2, dut_1.q3, clk9);
end

initial
begin
  clk = 0;
  forever#5 clk =~ clk;
end

initial
begin
  rst=1;
  #5 rst=0;
end

initial
#500 $finish;
endmodule
