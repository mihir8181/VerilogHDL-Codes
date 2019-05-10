
module write_sync #(parameter addrbits=8)
            (input clk_in, rst, flush,
             input [addrbits:0] wrptr,
             output reg [addrbits:0] sync_wrptr);
          
reg [addrbits:0] w0;

always @(posedge clk_in , negedge rst) 
begin
 if(!rst)
 begin
   w0 <= 0;
   sync_wrptr <= 0;
  end
   else if(flush) 
     begin
       w0 <= 0;
       sync_wrptr <= 0;
     end
 else
 begin
    w0 <= wrptr;
    sync_wrptr <= w0;
  end
end 
endmodule