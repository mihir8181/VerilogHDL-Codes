module RFSM #(parameter addrbits = 8, depth =128)
             (output reg                   empty,rden,
              output     [addrbits-1:0] rdaddr,
              output reg [addrbits  :0] rdptr,
              input      [addrbits  :0] sync_wrptr,
              input remove, clk_out, rst, sync_flush);

reg [1:0] current_state, next_state;
reg  [addrbits:0] rbin;
wire [addrbits:0] rgraynext, rbinnext;
wire empty_val;
//States are binary encoded 
localparam RESET  = 2'b00, 
           REMOVE = 2'b01, 
           IDEAL  = 2'b10; 
        

assign rdaddr = rbin[addrbits-1:0];
assign rbinnext  = rbin + (remove & ~empty);
assign rgraynext = (rbinnext>>1) ^ rbinnext;
assign empty_val = ((rgraynext == sync_wrptr)||(rbin[addrbits-1:0] >= depth[addrbits-1:0]-1));

always @(posedge clk_out , negedge rst)
begin
    if(!rst)
     begin
       current_state <= RESET; // non- blocking procedural assignment
       empty <= 1;
       rbin <= 0;   
       rdptr <= 0;
       rden <= 0;
      end    
    else
      begin
        current_state <= next_state;
        case(next_state)
             RESET : begin
                       rden <= 0;
                       empty <= 1;
                       rbin <= 0;  
                       rdptr <= 0;
                     end
             REMOVE: begin
                       empty <= empty_val;
                       if(!empty)
                       begin
                       rden <= 1;
                       {rbin, rdptr} <= {rbinnext, rgraynext};
                       end
                       else
                       begin        
                       rden <= 0; 
                       {rbin, rdptr} <= {rbin, rdptr};
                       end
                     end
             IDEAL : begin
                       rden <= 0;
                       empty <= empty_val;
                       {rbin, rdptr} <= {rbin, rdptr};
                     end             
            default: begin 
                      empty  <= 1;
                      rbin   <= 0;   
                      rdptr  <= 0;
                      rden   <= 0;
                     end
        endcase
      end   
end

always@(*)
begin
  next_state = RESET;
  case (current_state)
  RESET : begin
          if (sync_flush)
            next_state = RESET;  // blocking procedural assignment
          else                      
            next_state = IDEAL;          
          end

  REMOVE : begin
           if (sync_flush)
              next_state = RESET;             
           else if (remove && !empty)
               next_state = REMOVE; 
           else
              next_state = IDEAL;    
           end

  IDEAL : begin
           if (sync_flush)
              next_state = RESET;             
          else if (remove && !empty)
              next_state = REMOVE;
          else
              next_state = IDEAL;          
          end

    default: next_state = RESET;
      
  endcase 
end
endmodule 