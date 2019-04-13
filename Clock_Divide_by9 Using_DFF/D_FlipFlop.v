//-----------------------------//
//        D Flip Flop          //
//-----------------------------//
module D_FlipFlop(input d,clk,rst, 
                    output reg q,qbar); 
always @(posedge clk , posedge rst) 
begin
 if(rst==1'b1)
 begin
  q <= 1'b0;
  qbar <= 1'b1;
  end
 else
 begin
  q <= d;
  qbar <= ~q; 
  end
end 
endmodule
