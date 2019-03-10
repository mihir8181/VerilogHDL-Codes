//---------------------------------------------------
// Sequence detector FSM 
// Mealy Finite State Machine.
// Overlapping sequence = '101'
//---------------------------------------------------

module mealy_seq_detect (input x, 
                         input clk, 
                         input rst,  
                         output reg z);

//--------------------------------------------
//States are binary encoded
//--------------------------------------------
parameter s0 = 2'b00, s1 = 2'b01, s2 = 2'b10;

  reg[1:0] current_state, next_state;//state reg
  

//------------------------------------
//Sequential logic
//------------------------------------
    always @(posedge clk or negedge rst)
    begin
      if(!rst)
         current_state <= s0;   // non- blocking procedural assignment
         else
         current_state <= next_state;
    end

//----------------------------------
//Combinational Next state logic
//-----------------------------------
   always@(*)
    begin
      case (current_state)
      s0 : begin
            if (x == 1)
              begin
                z = 0;
                next_state = s1;  // blocking procedural assignment
                end
            else
              begin
                z = 0;
                next_state = s0;
                end
            end
      s1 : begin
            if (x == 0)
              begin
                z = 0;
                next_state = s2;
                end
            else
            begin
                z = 0;
                next_state = s1;
                end                
            end
      s2 : begin
            if (x == 1)
            begin
                z = 1;  // when state s2 gets 2nd required one and form a 101 sequence.
                next_state = s1;
            end    
                else
            begin
                z = 0;     
                next_state = s0;
            end      
            end
        default: begin 
        next_state = s0;  // default goes to s0 state
        z = 0; // default z = 0;
        end         
      endcase  // current state
    end    
endmodule // mealy_seq_detect