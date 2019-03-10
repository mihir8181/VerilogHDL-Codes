//---------------------------------------------------
// Sequence detector FSM 
// Moore Finite State Machine.
// Overlapping sequence = '101'
//---------------------------------------------------

module moore_seq_detect (input x, 
                         input clk, 
                         input rst,  
                         output reg z);

//States are binary encoded 
parameter s0 = 2'b00, s1 = 2'b01, s2 = 2'b10, s3 = 2'b11;

  reg[1:0] current_state, next_state;   //state reg
  

    // Sequential logic

    always @(posedge clk or negedge rst)
    begin
      if(!rst)
         current_state <= s0;   // non- blocking procedural assignment
         else
         current_state <= next_state;
    end

    // Combinational Next state logic
   always@(*)
    begin
      case (current_state)
      s0 : begin
            if (x == 1)
                next_state = s1;  // blocking procedural assignment
                else
                next_state = s0;
            end
      s1 : begin
            if (x == 1)
                next_state = s1;
                else
                next_state = s2;
            end
      s2 : begin
            if (x == 1)
                next_state = s3;
                else
                next_state = s0;
            end
      s3 : begin
            if (x == 1)
                next_state = s1;
                else
                next_state = s2;
            end  
        default: next_state = s0;
      endcase  // current state
    end
   // outputlogic
    always@(*)
       if (current_state == s3)
           z = 1;         
       else
           z = 0;     
endmodule // moore_seq_detect