`include "read_sync.v"
`include "write_sync.v"
`include "flush_sync.v"
`include "WFSM.v"
`include "RFSM.v"
`include "memory.v"
module fifo #(parameter datasize = 32,
                     parameter addrbits = 8,
                     parameter depth = 128)
             (output [datasize-1:0] dataOut,
              output           full,
              output           empty,
              input  [datasize-1:0] dataIn,
              input insert, flush, clk_in, rst, 
              input remove, clk_out);

wire   [addrbits-1:0] wraddr, rdaddr;
wire   [addrbits:0]   wrptr, rdptr, sync_rdptr, sync_wrptr;
wire sync_flush, wren, rden;

read_sync #(addrbits) r2w_uut (.sync_rdptr(sync_rdptr), .rdptr(rdptr),
                               .clk_out(clk_out), .rst(rst), .sync_flush(sync_flush));

write_sync #(addrbits) w2r_uut (.sync_wrptr(sync_wrptr), .wrptr(wrptr),
                                .clk_in(clk_in), .rst(rst), .flush(flush));
                                

flush_sync flush_uut (.sync_flush(sync_flush), .flush(flush),
                                .clk_in(clk_in), .rst(rst));

memory #(datasize, addrbits, depth) mem_uut (.dataOut(dataOut), .dataIn(dataIn),
                                             .wraddr(wraddr), .rdaddr(rdaddr),
                                             .rst(rst), .clk_in(clk_in), .flush(flush), 
                                             .clk_out(clk_out), .wren(wren), .rden(rden),
                                             .sync_flush(sync_flush));
                                                                
RFSM #(addrbits, depth) read_uut (.empty(empty), .rdaddr(rdaddr),
                           .rdptr(rdptr), .sync_wrptr(sync_wrptr), 
                           .remove(remove), .clk_out(clk_out),
                           .rst(rst), .sync_flush(sync_flush), .rden(rden));

WFSM  #(addrbits, depth) write_uut (.full(full), .wraddr(wraddr),
                             .wrptr(wrptr), .sync_rdptr(sync_rdptr),
                             .insert(insert), .flush(flush),
                             .clk_in(clk_in), .rst(rst), .wren(wren));


endmodule