//===========================================================================//
// File name: half_adder.v
// Author:    Cody Cziesler
//
// Description: Adds a, b and outputs the two bit value {c_out, sum}
//
// Truth table:
//
//   a   b   | c_out  sum
// -----------------------
//   0   0   |   0     0
//   0   1   |   0     1
//   1   0   |   0     1
//   1   1   |   1     0
//
//===========================================================================//

module half_adder (
  input   wire   a,
  input   wire   b,
  output  wire   c_out,
  output  wire   sum
);

assign {c_out, sum} = a + b;

endmodule
