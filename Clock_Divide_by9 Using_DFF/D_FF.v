//--- D Flip Flop--------

module D_FF (clk,rst,d,q,qbar);

input clk,rst,d;
output reg q,qbar;

always @(posedge clk, posedge rst)
begin
  if (rst)
  begin
    q <= 0;
    qbar <= 0;
  end
  else
  begin
    q <= d;
    qbar <= ~q;  
  end    
end    
endmodule;