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

//------- Veriables--------//
reg data_bit_rst;
reg data_bit_x;
reg data_bit_z;
reg [0:2] data [0:31];
reg [0:2] data_bit_reg;
integer i;
reg test_flag;

//-----------------------
// System File Handling
//------------------------
initial
begin
  $readmemb ("mealy_seq_datafile.txt", data); //------ read file data
end

//--------------------------------------------------------------------------------
//Monitor Simulation
//-------------------------------------------------------------------------------- 
initial 
begin
  $display("\n\n-------------------------------------------------------");
  $display("Mihir Mahajan\nEEE 273 Assignment 3\nMealy '101' Sequence Detector Automated Test using Perl Script");
  $display("-----------------------------------------------------------");
  $display("TIME\tRST  current_state  x z z_reg\n");
  //$monitor("%4t\t %b\t %d\t    %b %b %b\t Test =  ", $time, rst, U1.current_state, x, z, data_bit_z);
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

//--------------------------------------------
// Data extraction from mem and automate test
//--------------------------------------------
initial
begin
  for (i=0;i<=32; i=i+1)
  begin
    data_bit_reg = data[i]; //--- extract data from mem and store in reg
    #10;
    data_bit_z = data_bit_reg[2];
    rst = data_bit_reg[0]; //--- extract rst data and send to DUT.
    x = data_bit_reg[1];  // --- extract x data and send to DUT.
     // ---- extract expected z data to compare with DUT output z.
    #10;
 
//--------Output Compare-----------//
     if(z == data_bit_z)
       begin
          $display("%4t\t %b\t %d\t    %b %b %b\t Test = Pass ",$time, rst, U1.current_state, x, z, data_bit_z);
        end
     else
        begin
          $display("%4t\t %b\t %d\t    %b %b %b\t Test = Fail ",$time, rst, U1.current_state, x, z, data_bit_z);
        end
  end
end

//-----------------------//
// Finish simulation
//-----------------------//
initial
begin
#650 $finish;
end 
endmodule // mealy_seq_detect_fixture-----------
