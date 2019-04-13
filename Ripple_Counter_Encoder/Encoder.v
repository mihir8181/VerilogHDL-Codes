module Encoder(q, ascii); // reverse 2x4 decoder
   input [0:13] q;           // input unary bits
   output [6:0] ascii;       // coded bits

//    q[i] ASCII 654 3210  Hex
//               vvv vvvv
//    q[0]   M   100 1101  4d
//    q[1]   i   110 1001  69
//    q[2]   h   110 1000  68
//    q[3]   i   110 1001  69
//    q[4]   r   111 0010  72
//    q[5]       001 0000  20
//    q[6]   M   100 1101  4d
//    q[7]   a   110 0001  61
//    q[8]   h   110 1000  68
//    q[9]   a   110 0001  61
//    q[10]  j   110 1010  6a
//    q[11]  a   110 0001  61
//    q[12]  n   110 1110  6e
//    q[13]      001 0000  20  

   or(ascii[0], q[0], q[1], q[3], q[6], q[7], q[9], q[11]);
   or(ascii[1], q[4], q[10], q[12]);
   or(ascii[2], q[0], q[6], q[12]);
   or(ascii[3], q[0], q[1],q[2], q[3], q[6], q[8], q[10], q[12]);
   or(ascii[4], q[4], q[5],q[13]);
   nor(ascii[5], q[0],q[5], q[6],q[13]);
   nor(ascii[6], q[5] ,q[13]);
endmodule