//---------------------------------------------
// mealy sequence detect test bench using TASK
//---------------------------------------------

`include "mealy_seq_detect.v" // include main dut

module mealy_seq_detect_fixture(); 

reg x, clk, rst;
wire z;

//-------------------------------------------------------- 
//Instantiation of device under test
//--------------------------------------------------------
mealy_seq_detect U1 (.x(x), .clk(clk), .rst(rst), .z(z));

//--------------------------------------------------------------------------------
//Monitor Simulation
//-------------------------------------------------------------------------------- 
initial 
begin
  $display("\n\n---------------------------------");
  $display("Mihir Mahajan\nEEE 273 Assignment 3\nMealy '101' Sequence Detector using TASK");
  $display("---------------------------------");
  $display("TIME\tRST  current_state  x  z\n");
  $monitor("%4t \t%b \t\t%d   %b  %b",$time, rst, U1.current_state, x, z);
end

//-------------------------
// Initialize reg
//-------------------------
initial
begin
  x = 1'b0;
  rst = 1'b0;
end

//-------------------------
// Stimulus clk signal
//-------------------------
initial  
begin
  clk = 0;
  forever #10 clk = ~clk;
end

//-------------------------
// Test vectors using Task
//------------------------- 
always @(clk)
begin
  x = 1'b0;
  reset;  // Invoke the 'reset' Task to rst
  x = 1'b0;
  #5 
  testseq0; // Invoke the 'testseq0' for sequence 000
  testseq1; // Invoke the 'testseq1' for sequence 001
  testseq2; // Invoke the 'testseq2' for sequence 010
  testseq6; // Invoke the 'testseq6' for sequence 101
  reset;    // Invoke the 'reset' Task to rst
  testseq5; // Invoke the 'testseq5' for sequence 110
  testseq4; // Invoke the 'testseq4' for sequence 011
  testseq2; // Invoke the 'testseq2' for sequence 010
  testseq1; // Invoke the 'testseq1' for sequence 001
  testseq4; // Invoke the 'testseq4' for sequence 011
  testseq6; // Invoke the 'testseq6' for sequence 101
  testseq4; // Invoke the 'testseq4' for sequence 011
  testseq5; // Invoke the 'testseq5' for sequence 110
end 

//---------------------------------------
// Task to reset
//---------------------------------------
task reset;  
begin
rst = 1'b0;
#5 rst = 1'b1;
end
endtask // end reset task---------------- 

//---------------------------------------
// Task to generate sequence 000
//---------------------------------------
task testseq0; 
begin
   @(posedge clk) x = 1'b0;
   @(posedge clk) x = 1'b0;
   @(posedge clk) x = 1'b0;
  #10;
end
endtask // end testseq0 task-------------

//---------------------------------------
// Task to generate sequence 001
//---------------------------------------
task testseq1; 
begin
   @(posedge clk) x = 1'b0;
   @(posedge clk) x = 1'b0;
   @(posedge clk) x = 1'b1;
  #10;
end
endtask // end testseq1 task ------------


//---------------------------------------
// Task to generate sequence 010
//---------------------------------------
task testseq2; 
begin
   @(posedge clk) x = 1'b0;
   @(posedge clk) x = 1'b1;
   @(posedge clk) x = 1'b0;
  #10;
end
endtask // end testseq2 task ------------

//---------------------------------------
// Task to generate sequence 100
//---------------------------------------
task testseq3; 
begin
   @(posedge clk) x = 1'b1;
   @(posedge clk) x = 1'b0;
   @(posedge clk) x = 1'b0;
  #10;
end
endtask // end testseq3 task ------------

//------------------------------------- 
// Task to generate sequence 011
//-------------------------------------
task testseq4;
begin
   @(posedge clk)x = 1'b0;
   @(posedge clk) x = 1'b1;
   @(posedge clk) x = 1'b1;
  #10;
end
endtask 
//end testseq4 task--------------------

//------------------------------------- 
// Task to generate sequence 110
//-------------------------------------
task testseq5;
begin
   @(posedge clk)x = 1'b1;
   @(posedge clk) x = 1'b1;
   @(posedge clk) x = 1'b0;
  #10;
end
endtask 
//end testseq5 task--------------------

//---------------------------------------------------
// Task to generate sequence 101
//---------------------------------------------------
task testseq6; 
begin
   @(posedge clk) x = 1'b1;
   @(posedge clk) x = 1'b0;
   @(posedge clk) x = 1'b1;
  #10;
end
endtask // end testseq6 task--------------------------

initial
begin
#1000 $finish; // Finish simulation
end 

endmodule // mealy_seq_detect_fixture-----------
