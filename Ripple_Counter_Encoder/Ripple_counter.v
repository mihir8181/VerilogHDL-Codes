module Ripple_counter(CLK, Q);
   input CLK;
   output [0:13] Q;

   reg [0:13] Q;      // flipflops


   always @(CLK) begin
      Q[0] <= Q[13];   // at posedge clk event
      Q[1] <= Q[0];   // <= is concurrent transfer
      Q[2] <= Q[1];   // right side of <= is current
      Q[3] <= Q[2];   // left side of <= is future
      Q[4] <= Q[3];
      Q[5] <= Q[4];
      Q[6] <= Q[5];
      Q[7] <= Q[6];
      Q[8] <= Q[7];
      Q[9] <= Q[8];
      Q[10] <= Q[9];
      Q[11] <= Q[10];
	  Q[12] <= Q[11];
	  Q[13] <= Q[12];
   end

   initial Q = 14'b10000000000000;
endmodule
