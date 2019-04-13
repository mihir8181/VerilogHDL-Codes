// ----- D_FF TestBench --------
`include "D_FlipFlop.v"
module D_FlipFlop_fixture();
reg d, clk, rst;
wire q, qbar;
// Instantiation ------------------
D_FlipFlop dff1 (.d(d), .clk(clk), .rst(rst), .q(q), .qbar(qbar));

initial
begin
$vcdpluson;
end

initial
begin
  d = 1'b0;
  rst = 1'b1;
end

initial
begin
clk = 0;
forever #10 clk =~ clk;
end

always
fork
  #5 rst = 1'b0;
  #5  d = 1'b1;
  #40 d = 1'b0;
  #80 d = 1'b1;
  #85 rst = 1'b1;
  #105 rst = 1'b0;
  #95 d = 1'b0;
  #110 d = 1'b1;
  #130 d = 1'b0;
join

initial
begin
$monitor("%04t %b %b %b %b", $time, rst, d, q, qbar);
end

initial
begin
#200 $finish;
end
endmodule
