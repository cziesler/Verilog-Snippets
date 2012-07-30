//===========================================================================//
// File name: tb_dff.v
// Author:    Cody Cziesler
//
// Description: Test bench for testing dff.v
//
//===========================================================================//

module tb_dff ();

//---------------------------------------------------------------------------//
// Inputs to UUT
//---------------------------------------------------------------------------//
reg  clk;
reg  rst_n;
reg  d;

//---------------------------------------------------------------------------//
// Outputs from UUT
//---------------------------------------------------------------------------//
wire q;

//---------------------------------------------------------------------------//
// Create a 50 MHz clock (20 ns)
//---------------------------------------------------------------------------//
always #20 clk = ~clk;

//---------------------------------------------------------------------------//
// Create the vpd file
//---------------------------------------------------------------------------//
initial begin
  $vcdpluson(tb_dff);
end

//---------------------------------------------------------------------------//
// Initialize signals and perform test
//---------------------------------------------------------------------------//
initial begin
  $display ("======================================");
  $display ("Starting tb_dff");

  // Initialize variables
  clk   = 1'b0;
  rst_n = 1'b0;
  d     = 1'b0;

  // Reset the dff
  @(negedge clk)
    rst_n = 1'b1;

  // Check that output is 0
  @(negedge clk)
    if (q !== 1'b0) begin
      $display ("ERROR - expected q[%b] to be 1'b0 @ %0t", q, $time);
    end
  


  $display ("======================================");
  $finish ();
end

//---------------------------------------------------------------------------//
// UUT (dff.v)
//---------------------------------------------------------------------------//
dff dff_0 (
  .clk(clk),
  .rst_n(rst_n),
  .d(d),
  .q(q)
);

endmodule