//===========================================================================//
// File name: tb_sync.v
// Author:    Cody Cziesler
//
// Description: Test bench for testing sync.v
//
//===========================================================================//

module tb_full_adder ();

//---------------------------------------------------------------------------//
// Inputs to UUT
//---------------------------------------------------------------------------//
reg a;
reg b;
reg c_in;

//---------------------------------------------------------------------------//
// Outputs from UUT
//---------------------------------------------------------------------------//
wire sum;
wire c_out;

//---------------------------------------------------------------------------//
// A lcv
//---------------------------------------------------------------------------//
integer i;

//---------------------------------------------------------------------------//
// Create the vpd file
//---------------------------------------------------------------------------//
initial begin
  $vcdpluson(tb_full_adder);
end

//---------------------------------------------------------------------------//
// Initialize signals and perform test
//---------------------------------------------------------------------------//
initial begin
  $display ("======================================");
  $display ("Starting tb_full_adder");

  for (i = 32'd0; i < 32'h8; i = i + 1) begin
    {c_in, a, b} = i;
    #1;
    if ( {c_out, sum} !== add (a, b, c_in) ) begin
      $display("ERROR - a[%b] + b[%b] + c_in[%b] !== c_out[%b], sum[%b] @ %0t",
        a, b, c_in, c_out, sum, $time);
    end
  end

  $display ("======================================");
  $finish ();
end

//---------------------------------------------------------------------------//
// UUT (full_adder.v)
//---------------------------------------------------------------------------//
full_adder full_adder_0 (
  .a(a),
  .b(b),
  .c_in(c_in),
  .sum(sum),
  .c_out(c_out)
);

//---------------------------------------------------------------------------//
// Add three numbers
//---------------------------------------------------------------------------//
function [1:0] add;
  input a;
  input b;
  input c;
begin
  add[1:0] = a + b + c;
end
endfunction

endmodule
