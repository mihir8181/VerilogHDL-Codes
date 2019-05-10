
module read_sync #(parameter addrbits=8)
                  (input clk_out, rst, sync_flush,
                   input [addrbits:0] rdptr,
                   output reg [addrbits:0] sync_rdptr);

reg [addrbits:0] r0;

always @(posedge clk_out , negedge rst) 
begin
 if(!rst)
 begin
  r0 <= 0;
  sync_rdptr <= 0;
  end
     else if(sync_flush) 
     begin
       r0 <= 0;
       sync_rdptr <= 0;
     end
 else
  begin
    r0 <= rdptr;
    sync_rdptr <= r0;
  end
end 
endmodule