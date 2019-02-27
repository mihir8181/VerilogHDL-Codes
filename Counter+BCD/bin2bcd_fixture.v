// bin2bcd_fixture
// binary to bcd testbench

`include "bin2bcd.v"

module bin2bcd_fixture();
   reg [3:0]value;
   wire [3:0]tens;
   wire [3:0]ones;
S
 initial
    $vcdpluson;
 initial 
    $monitor($time, " value = %b value = %d tens = %b ones = %b", value[3:0],value[3:0],tens[3:0],ones[3:0]);
bin2bcd U2(.VALUE(value), .TENS(tens), .ONES(ones));
initial
begin
value <= 4'b0011;
#100 value <= 4'b1010;
#100 value <= 4'b1110;
#100 value <= 4'b1011;
end
// finish the simulation at time
initial
begin
  #400 $finish;
end
endmodule // bin2bcd_fixture