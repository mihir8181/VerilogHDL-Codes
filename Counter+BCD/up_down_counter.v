//up_down_counter module using Verilog

module up_down_counter(input CLK, ENABLE, UPDN, RST, output wire[3:0] VALUE); 
reg [3:0] counter;   // reg

always @ (posedge CLK or posedge RST)
  begin
   if (RST == 1'b1)
   begin 
   counter <= 4'b0000;
   end      // if RST occur it will reset counter
   else 
   if(ENABLE == 1'b1 && UPDN == 1'b1)   // If ENABLE = 1 and UPDN = 1 condition.
      begin
        if (counter == 4'hF)
          begin
           counter <= 4'hF;
          end
        else
         counter <= counter + 1'b1;             // The counter counts up incrementing VALUE on every clock cycle.
       end 
   else if (ENABLE == 1'b1 && UPDN == 1'b0) // If ENABLE = 1 and UPDN = 0 condition. 
       begin
        if (counter == 4'h0)
          begin
           counter <= 4'h0;
          end
        else
         counter <= counter - 1'b1;// The counter counts down decrementing VALUE on every clock cycle.
        end 
        else if (ENABLE == 1'b0 && (UPDN == 1'b0 || 1'b1))
        begin
        counter <= counter;
        end
   else if(ENABLE == 1'b0)
     counter <= counter;  // Else counter remains at the present value
   else if (counter == 15)
    counter <= 4'hF;
   else if (counter == 0)
    counter <= 4'h0;
  end
 assign VALUE = counter;
endmodule 