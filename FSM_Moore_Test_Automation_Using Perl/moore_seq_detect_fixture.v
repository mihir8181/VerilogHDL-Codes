//---------------------------------------------
// Moore sequence detect test bench using TASK
//---------------------------------------------

`include "moore_seq_detect.v" // include main dut

module moore_seq_detect_fixture(); 

reg x, clk, rst;
wire z;

//----------------------------------- 
//Instantiation of device under test
//-----------------------------------
moore_seq_detect U1 (.x(x), .clk(clk), .rst(rst), .z(z));


//------- Veriables--------//
reg data_bit_rst;
reg data_bit_x;
reg data_bit_z;
reg [0:2] data [0:31];
reg [0:2] data_bit_reg;
integer i;

//-----------------------
// System File Handling
//------------------------
initial
begin
  $readmemb ("moore_seq_datafile.txt", data); //------ read file data
end

//------------------------
//Display Information
//------------------------
initial 
begin
  $display("\n\n---------------------------------------------");
  $display("Mihir Mahajan\nEEE 273\nMoore '101' Sequence Detector Automated Test");
  $display("-------------------------------------------------");
  $display("TIME\tRST  current_state  x z z_reg\n");
end

//-------------------------
// Initialize 
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
    #20;
    rst = data_bit_reg[0]; //--- extract rst data and send to DUT.
    x = data_bit_reg[1];  // --- extract x data and send to DUT.
    data_bit_z = data_bit_reg[2]; // ---- extract expected z data to compare with DUT output z.
 
    //--------Output Compare-----------//
     if(z == data_bit_z)
        begin
        $display ("%4t\t %b\t %d\t    %b %b %b\t Test = pass ", $time, rst, U1.current_state, x, z, data_bit_z);
        end
     else
        begin
        $display ("%4t\t %b\t %d\t    %b %b %b\t Test = Fail ", $time, rst, U1.current_state, x, z, data_bit_z);
        end
  end
end

//-----------------------------
// Finish simulation
//-----------------------------
initial
begin
#600 $finish;  
end 

endmodule // end moore_seq_detect_fixture