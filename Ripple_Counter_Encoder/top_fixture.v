`include "Encoder.v"
`include "Ripple_counter.v"

module top_fixture;
   reg clk;
   wire [0:13] q;
   wire [6:0] ascii;

   initial begin
      #1;
      forever begin // this is clock wave
         clk = 0;  // 0 for half cycle (#1)
         #1;
         clk = 1;  // 1 for half cycle (#1)
         #1;
      end
   end

   Ripple_counter my_ripple_counter(clk, q);
   Encoder my_encoder(q, ascii);

   initial #28 $finish;

   initial begin
      $display("Time  CLK   Q            Name");
      $monitor("%4d   %b    %b   %c", $time, clk, q, ascii);
   end
endmodule