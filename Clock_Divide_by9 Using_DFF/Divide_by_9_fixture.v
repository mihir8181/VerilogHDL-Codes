`timescale 1ns/1ps
`include "Divide_by_9.v"
`include "D_FF.v"
module Divide_by_9_fixture();

reg clk;
reg rst;
wire clk9;

initial
begin
$vcdpluson;
end

Divide_by_9 DUT(.clk(clk), .rst(rst), .clk9(clk9));

initial
begin
$display("Time \trst \tclk \tclk9\n");
$monitor("%04t \t%b \t%b \t%b", $time, rst, clk, clk9);
end

initial
begin
  clk = 0;
  forever#5 clk =~ clk;
end

initial
begin
  rst=1;
  #15
  rst=0;
end

initial
#500 $finish;
endmodule