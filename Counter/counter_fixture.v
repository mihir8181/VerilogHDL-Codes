//-----------------------------
//Top level stimulus module
//-----------------------------

`include "counter.v"

module counter_fixture;

// Declare variables for stimulating input
reg CLOCK, CLEAR;
wire [3:0] Q;

initial
        $vcdpluson;

initial
       $monitor($time, " Count Q = %b Clear= %b",  Q[3:0],CLEAR);
// Instantiate the design block counter
counter c1(Q, CLOCK, CLEAR);

// Stimulate the Clear Signal
initial
begin
       CLEAR = 1'b1;
       #34 CLEAR = 1'b0;
       #200 CLEAR = 1'b1;
       #50 CLEAR = 1'b0;
end

// Setup the clock to toggle every 10 time units
initial
begin
       CLOCK = 1'b0;
       forever #10 CLOCK = ~CLOCK;
end

// Finish the simulation at time 200
initial
begin
       #400 $finish;
end

endmodule // counter_fixture
