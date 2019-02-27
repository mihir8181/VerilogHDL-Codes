//-----------------------
//Binary  counter
//----------------------
module counter(Q , clock, clear);

// I/O ports
output [3:0] Q;
input clock, clear;
//output defined as register
reg [3:0] Q;

always @( posedge clear  or negedge clock)
begin
       if (clear)
          Q = 4'd0;
       else
          Q = (Q + 1) ;
end
endmodule // counter
