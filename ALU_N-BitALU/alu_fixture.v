//-------------------------------
// alu testbench using verilog
//-------------------------------

`include "alu_dut.v" // dut module declaration

module alu_fixture();
// Interface to communicate with the DUT
    parameter data_width = 32;  // parameter
    reg [data_width-1:0] a, b;
	reg [1:0] ctrl;
	wire [data_width-1:0] out;
	wire ov;
	wire sign;
	wire zero;
    
   // Device under test instantiation
    alu_dut #(data_width) U1 (.A(a), .B(b), .control(ctrl), .R(out), .ovflag(ov), .signflag(sign), .zeroflag(zero));

    initial begin   // Initialize inputs and control signal
      ctrl = 2'b00;
      a = 0;
      b = 0;
    end

    initial begin   // test cases for stimulus 
    $monitor($time, "   %b %h %h %h %b %b %b\n", ctrl, a, b, out, sign, ov, zero); // Monitor the simulation
    $display ("\n\t\t\t\tAddition\n");
    $display ("\t\t|time|ctrl|   A   |   B    |   R    |N|O|Z|"); // Display simulation header
    ctrl = 2'b00;  //--------------------- Addition
    #0 a = 32'hFFFFF000; b = 32'hFFFFFFFF;
    #5 a = 32'hFFFFFFFF; b = 32'h000F00F0; 
    #5 a = 32'h67676767; b = 32'h12431243;
    #5 a = 32'hAAAAAAAA; b = 32'hEFABCD19;
    #5 a = 32'hFFFFFFFF; b = 32'h00000001;
    #5 a = 32'hFFFFFFFF; b = 32'hFFFFFFFF;
    #5 a = 32'hFFFFFFFC; b = 32'hFFFFFFFC;
    #5 a = 32'hFFFF0000; b = 32'h00001342;
    #5 a = 32'h01234567; b = 32'h00080808;
    #5
    $display ("\n\t\t\t\tSubtraction\n");
    $display ("\t\t|time|ctrl|   A   |   B    |   R    |N|O|Z|");
    ctrl = 2'b01;   //------------------- Subtraction
    a = 32'hFFFFF000; b = 32'hFFFFFFFF;
    #5 a = 32'hFFFFFFFF; b = 32'h000F00F0; 
    #5 a = 32'h67676767; b = 32'h12431243;
    #5 a = 32'hAAAAAAAA; b = 32'hEFABCD19;
    #5 a = 32'hFFFFFFFF; b = 32'h00000001;
    #5 a = 32'hFFFFFFFF; b = 32'hFFFFFFFF;
    #5 a = 32'hFFFFFFFC; b = 32'hFFFFFFFC;
    #5 a = 32'hFFFF0000; b = 32'h00001342;
    #5 a = 32'h01234567; b = 32'h00080808;
    #5
    $display ("\n\t\t\t\tBitwise And\n");
    $display ("\t\t|time|ctrl|   A   |   B    |   R    |N|O|Z|");
    ctrl = 2'b10; //-------------------- bitwise And
     a = 32'hFFFFFFFF; b = 32'h0A0AB0B0;
    #5 a = 32'hABCD4545; b = 32'h12383588;
    #5 a = 32'hF0F0F0F0; b = 32'hCFCFCFCF;
    #5 a = 32'h00000000; b = 32'h11000001;
    #5
    $display ("\n\t\t\t\tBitwise Or\n");
    $display ("\t\t|time|ctrl|   A   |   B    |   R    |N|O|Z|");
    ctrl = 2'b11; //---------------------- bitwise Or
     a = 32'hFFFFFFFF; b = 32'h0A0AB0B0;
    #5 a = 32'hABCD4545; b = 32'h12383588;
    #5 a = 32'hF0F0F0F0; b = 32'hCFCFCFCF;
    #5 a = 32'h00000000; b = 32'h11000001;
    #10
    $finish;  // Finish simulation
    end
endmodule // alu_fixture