//--------------------------------//
//   Divide by 9 DUT              //
//-------------------------------//
module Divide_by_9(input clk, rst,
                   output clk9);
wire q0,q1,q2,q3;  //wire
wire qbar0,qbar1,qbar2,qbar3,a;
and a1(a,q3,q0);  

wire r=(rst==1)?1:a;
and (a,q3,q0); 

D_FlipFlop dut1(.clk(clk), .rst(r), .d(~q0), .q(q0), .qbar(qbar0));
D_FlipFlop dut2(.clk(~q0), .rst(r), .d(~q1), .q(q1), .qbar(qbar1));
D_FlipFlop dut3(.clk(~q1), .rst(r), .d(~q2), .q(q2), .qbar(qbar2));
D_FlipFlop dut4(.clk(~q2), .rst(r), .d(~q3), .q(q3), .qbar(qbar3));

assign clk9 = q3;
endmodule //



set list hello
concat $list $list
set a {a b c}
llength $a
set b {d e f}
llength $b
set listA [list "$a" "$b"]
set listB [list "$b" "$a"]   
set c [concat $listA $listB]
llength $c
lindex $c 0
lindex $c 1
lindex $c 3

set sample "Where there is a will, There is a way."
set result [regexp {[A-Za-z]+} $sample match]
puts "Result: $result match: $match"
set result [regexp {([A-Za-z]+) +([a-z]+)} $sample match sub1 sub2 ]
puts "Result: $result Match: $match 1: $sub1 2: $sub2"
set totalnumber [regexp -all {[^ ]+} $sample]
puts "Number of words: $totalnumber"

set result [regexp {^i+} $sample match]