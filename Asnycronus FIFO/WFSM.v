module WFSM #(parameter addrbits = 8, depth= 128)
             (output reg                   full,wren,
              output     [addrbits-1:0] wraddr,
              output reg [addrbits  :0] wrptr,
              input      [addrbits  :0] sync_rdptr,
              input insert, flush, clk_in, rst);

reg [1:0] current_state, next_state;
reg  [addrbits:0] wbin;
wire [addrbits:0] wgraynext, wbinnext;
wire full_val;
//States are binary encoded 
localparam RESET = 2'b00, 
           INSERT= 2'b01, 
           IDEAL = 2'b10; 
        

assign wraddr = wbin[addrbits-1:0];
assign wbinnext  = wbin + (insert & ~full);
assign wgraynext = (wbinnext>>1) ^ wbinnext;
assign full_val  = (((wgraynext[addrbits-1]  !=sync_rdptr[addrbits-1]) &&
                   (wgraynext[addrbits-2:0]==sync_rdptr[addrbits-2:0]))||
                   (wbin[addrbits-1:0] >= depth[addrbits-1:0]-1)); 
 
always @(posedge clk_in , negedge rst)
begin
    if(!rst)
     begin
        current_state <= RESET; // non- blocking procedural assignment
        full <= 1'b0;
        wbin <= 0;   
        wrptr <= 0;
        wren <= 0;  
      end    
    else
      begin
        current_state <= next_state;
        case(next_state)
             RESET : begin
                       wren <= 0;
                       full  <= 0;
                       wbin <= 0;  
                       wrptr <= 0; 
                     end
             INSERT: begin
                       full <= full_val;
                       if(!full_val)
                       begin
                       wren <= 1;                
                       {wbin, wrptr} <= {wbinnext, wgraynext};
                       end
                       else
                       begin
                       wren <= 0;
                       {wbin, wrptr} <= {wbin, wrptr};
                       end
                     end
             IDEAL : begin
                       wren <= 0;
                       full <= full_val;
                     end             
            default: begin         
                     full  <= 1'b0;
                      wbin  <= 0;   
                      wrptr <= 0;
                      wren <= 0;
                     end
        endcase
      end   
end

always@(*)
begin
  next_state = RESET;
  case (current_state)
  RESET : begin
          if (flush)
            next_state = RESET;  // blocking procedural assignment
          else if (insert && !full)     
            next_state = INSERT;
          else
            next_state = IDEAL;   
          end

  INSERT : begin
           if (flush)
              next_state = RESET; 
           else if (insert && !full)
              next_state = INSERT;
           else
              next_state = IDEAL;   
           end

  IDEAL : begin
           if (flush)
              next_state = RESET;  
          else if (insert && !full)
              next_state = INSERT;
          else
              next_state = IDEAL;               
          end
    default: next_state = RESET;  
  endcase 
end

endmodule 