# Asyncronus FIFO #

### Objective ###
The objective of this project is to design, validate and synthesize a parameterized first-in first-out (FIFO) buffer in Verilog.   The default depth of the **_FIFO is 128 32-bit_** words. It supports flush, insert, and remove operations.    During the insert operation, a new word is added to the tail (end) of the buffer and an internal write pointer is incremented on positive edge of **_clk_in_** clock.   The data at the head of the FIFO is read during the remove operation, and an internal read pointer is incremented on positive edge **_clk_out_** clock.  A flush clears all words in the buffer.  The buffer is considered empty after a flush. Here are the ports for the FIFO:

1-bit input **_reset_**: An asynchronous global system reset. Every sequential element in the system goes through a reset when this signal is asserted.   The content of the FIFO is cleared.  The status of the FIFO will be empty after a reset.

1-bit input   **_flush_**:   When asserted, the FIFO is cleared, and the read/write pointers are reset on positive edge of clock **_clk_in_**.  The FIFO status is **_empty_**.  

1-bit input **_insert_**:    When asserted, data on data_in port is stored at the tail of  the FIFO on positive edge of clock **_clk_in_**

1-bit input **_remove_**:  When asserted, data at the head of the FIFO is removed from the FIFO and is placed on the on the data_out   output port on positive edge of **_clk_out_**

32-bit input **_data_in_**:  input data port

32-bit output **_data_out_**: output data port

1-bit output **_full_**: asserted on the positive edge of  **_clk_in_** clock when the buffer is full and there is no more room for data

1-bit output **_empty_**: asserted on the positive edge of **_clk_out_** clock when the buffer is empty (no data in the buffer)
 
**_Full_** and **_empty_** flags are used by the external environment for proper use of the FIFO.


## Block Diagram ###
![](https://github.com/mihir8181/VerilogHDL-Codes/blob/master/Asynchronous%20FIFO/Doc/Block%20DIagram.jpg)

## Finite State Machine
![](https://github.com/mihir8181/VerilogHDL-Codes/blob/master/Asynchronous%20FIFO/Doc/FSM.png)

## Verification/Testbench
![](https://github.com/mihir8181/VerilogHDL-Codes/blob/master/Asynchronous%20FIFO/Doc/Testbench.png)

## Schematic
![](https://github.com/mihir8181/VerilogHDL-Codes/blob/master/Asynchronous%20FIFO/Doc/schematic.png)

## Code Coverage
![](https://github.com/mihir8181/VerilogHDL-Codes/blob/master/Asynchronous%20FIFO/Doc/Code%20Coverage%201.png)

![](https://github.com/mihir8181/VerilogHDL-Codes/blob/master/Asynchronous%20FIFO/Doc/Code%20Coverage%202.png)

## DVE waveform
![](https://github.com/mihir8181/VerilogHDL-Codes/blob/master/Asynchronous%20FIFO/Doc/Waveform.png)
![](https://github.com/mihir8181/VerilogHDL-Codes/blob/master/Asynchronous%20FIFO/Doc/Full.png)
![](https://github.com/mihir8181/VerilogHDL-Codes/blob/master/Asynchronous%20FIFO/Doc/Empty.png)
