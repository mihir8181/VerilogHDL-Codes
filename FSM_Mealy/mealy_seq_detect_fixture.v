//------------------------------------------
// mealy sequence detect test bench
//-------------------------------------------

`include "mealy_seq_detect.v" // include main dut

module mealy_seq_detect_fixture(); 

reg x, clk, rst;
wire z;
// Instantiation of device under test
mealy_seq_detect U1 (.x(x), .clk(clk), .rst(rst), .z(z));

//Monitor Simulation 
initial 
begin
  $display("\n\n---------------------------------");
  $display("Mihir Mahajan\nEEE 273 Assignment 3\nMealy '101' Sequence Detector");
  $display("---------------------------------");
  $display("TIME\tRST  current_state  x  z\n");
  $monitor("%4t \t%b \t\t%d   %b  %b",$time, rst, U1.current_state, x, z);
end

// Stimulus clk signal
initial  
begin
  clk = 0;
  forever #10 clk = ~clk;
end

//Test vector 
initial
begin
  rst = 0; x = 1'b0;
  
  #05; 
  rst = 1;
  @(posedge clk) x = 1'b0;
  @(posedge clk) x = 1'b1;
  @(posedge clk) x = 1'b0;
  @(posedge clk) x = 1'b1;
  @(posedge clk) x = 1'b0;
  @(posedge clk) x = 1'b1;
  @(posedge clk) x = 1'b1;
  @(posedge clk) x = 1'b0;
  @(posedge clk) x = 1'b1;
  @(posedge clk) x = 1'b1;
  @(posedge clk) x = 1'b1;
  @(posedge clk) x = 1'b0;
  @(posedge clk) x = 1'b1;
  @(posedge clk) x = 1'b0;
  @(posedge clk) x = 1'b1;
  #5;  
  rst = 0; x = 1'b1;
  #5; 
  rst = 1; x = 1'b1;
  @(posedge clk) x = 1'b1;
  @(posedge clk) x = 1'b0;
  @(posedge clk) x = 1'b1;
  @(posedge clk) x = 1'b0;
  @(posedge clk) x = 1'b0;
  @(posedge clk) x = 1'b1;
  @(posedge clk) x = 1'b1;
  @(posedge clk) x = 1'b0;
  @(posedge clk) x = 1'b0;
  @(posedge clk) x = 1'b1;
  @(posedge clk) x = 1'b1;
  @(posedge clk) x = 1'b0;
  @(posedge clk) x = 1'b0;
end

initial
begin
#1000 $finish;
end 

endmodule // mealy_seq_detect_fixture