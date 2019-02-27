// Bin to BCD conversion using double dabble alogorithm in verilog
module bin2bcd(input wire [3:0] VALUE, output reg [3:0] TENS, output reg [3:0] ONES);

integer i;

always @(VALUE)
begin
//define TENS and ONES to 0
  TENS = 4'd0;
  ONES = 4'd0;

  for (i=3; i>=0; i=i-1)
  begin
  // add 3 to colums if >= 5
    if (TENS >= 5)
       TENS = TENS + 3;
    if (ONES >= 5)
       ONES = ONES + 3;
// Shift bits left one
    TENS = TENS << 1;
    TENS[0] = ONES[3];
    ONES = ONES << 1;
    ONES[0] = VALUE[i];
    end
end
endmodule // bin2bcd