//===========================================================================//
// File name: full_adder.v
// Author:    Cody Cziesler
//
// Description: Adds a, b, c_in and outputs the two bit value {c_out, sum}
//
// Truth table:
//
//  c_in  a   b   | c_out  sum
// ----------------------------
//    0   0   0   |   0     0
//    0   0   1   |   0     1
//    0   1   0   |   0     1
//    0   1   1   |   1     0
//    1   0   0   |   0     1
//    1   0   1   |   1     0
//    1   1   0   |   1     0
//    1   1   1   |   1     1
//
//===========================================================================//

module full_adder (
  input   wire   a,
  input   wire   b,
  input   wire   c_in,
  output  wire   sum,
  output  wire   c_out
);

assign {c_out, sum} = a + b + c_in;

endmodule
