module Divide_by_9(clk,rst,clk9);
input clk, rst;
output clk9;

wire [0:3]q;
wire [0:3]qbar;
wire a;

and a1(a,q3,q0); 
wire r=(rst==1)?1:a;

D_FF U1(.clk(clk), .rst(r), .d(qbar0), .q(q0), .qbar(qbar0));
D_FF U2(.clk(qbar0), .rst(r), .d(qbar1), .q(q1), .qbar(qbar1));
D_FF U3(.clk(qbar1), .rst(r), .d(qbar2), .q(q2), .qbar(qbar2));
D_FF U4(.clk(qbar2), .rst(r), .d(qbar3), .q(clk9), .qbar(qbar3));

endmodule //