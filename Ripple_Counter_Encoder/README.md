# Sequential Logic: Sequence Generator

* The use of memory constitutes a sequential-logic circuit.
The memory in Verilog programming is the use of reg to declare bit storage which can contain a state of the electronics, 
and can be used as part of the input to generate the next state in time driven by clock cycles. 
Example of sequential circuits are counter, sequence generator, and sequence recognizer.

* In this assignment we will program a sequential circuit in Verilog code as a sequence generator that generates, 
instead of binary counts, the letters in your full name (given name and family name combined), character by character. 
Display the sequence for at least two cycles (run the demo to match how it runs with your code).

* The ripple counter is an example that illustrate the sequential nature of the circuit: the value 1 is passed among several bit registers, 
and the collective output is a unary pattern which is then encoded into the binary format by way of an encoder 
(which does the inverse function of a decoder). See the diagram below. 

![picture alt](https://github.com/mihir8181/VerilogHDL-Codes/blob/master/Ripple_Counter_Encoder/Block%20Diagram.png  "Sequential Logic: Sequence Generator")


* Suppose the output of the ripple generator is an arrray of Q. Then, the truth table of encoding is:
![picture alt](https://github.com/mihir8181/VerilogHDL-Codes/blob/master/Ripple_Counter_Encoder/TT.png  "Sequential Logic: Sequence Generator")

*There are Other Types of Counters like [Inverse counter](https://github.com/mihir8181/VerilogHDL-Codes/blob/master/Ripple_Counter_Encoder/InverseCounter.png "Inverse counter")
& [Modulo4counter](https://github.com/mihir8181/VerilogHDL-Codes/blob/master/Ripple_Counter_Encoder/Modulo4Counter.jpg "Modulo4counter")
which you can use instead of ripple counter.

*The supposed [Runtime Output.](https://github.com/mihir8181/VerilogHDL-Codes/blob/master/Ripple_Counter_Encoder/Simulation_result.pdf "Runtime Output")
![picture alt](https://github.com/mihir8181/VerilogHDL-Codes/blob/master/Ripple_Counter_Encoder/Result.png "Result log")


