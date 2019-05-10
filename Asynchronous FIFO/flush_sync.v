
module flush_sync (input clk_in, rst, flush,
                   output reg sync_flush);
            
reg f0;

always @(posedge clk_in , negedge rst) 
begin
 if(!rst)
 begin
   f0 <= 1'b0;
   sync_flush <= 1'b0;
  end
   else
     begin
    f0 <= flush;
    sync_flush <= f0;
     end
end
endmodule