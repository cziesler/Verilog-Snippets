//===========================================================================//
// File name: tb_sync.v
// Author:    Cody Cziesler
//
// Description: Test bench for testing sync.v
//
//===========================================================================//

//===========================================================================//
// Parameter for number of flip flops to us in UUT
//===========================================================================//
`define NUM_FFS 'd2

module tb_sync ();

//===========================================================================//
// Inputs to UUT
//===========================================================================//
reg  clk;
reg  rst_n;
reg  async_sig;

//===========================================================================//
// Outputs from UUT
//===========================================================================//
wire sync_sig;

//===========================================================================//
// A lcv for counting clocks
//===========================================================================//
integer i;

//===========================================================================//
// Create the clock @ 50 MHz (20 ns)
//===========================================================================//
always #20 clk = ~clk;

//===========================================================================//
// Create the vpd file
//===========================================================================//
initial begin
  $vcdpluson(tb_sync);
end

//===========================================================================//
// Initialize signals and perform test
//===========================================================================//
initial begin
  $display ("======================================");
  $display ("Starting tb_sync with NUM_FFS = %0d", `NUM_FFS);

  // Initialize signals
  clk       = 1'b0;
  rst_n     = 1'b0;
  async_sig = 1'b0;

  // Take UUT out of reset
  @(negedge clk)
    rst_n = 1'b1;

  // Set async_sig to 1'b1
  @(negedge clk)
    async_sig = 1'b1;

  // Verify that after NUM_FFS clocks, the async_sig appears at sync_sig
  for (i = 32'd0; i < `NUM_FFS; i = i + 32'd1) begin
    @(posedge clk);
  end

  // Check sync_sig
  @(negedge clk)
    if (sync_sig !== 1'b1) begin
      $display ("ERROR - expected 1'b1 on sync_sig, received %b @ %0t", sync_sig, $time);
    end

  // Set async_sig to 1'b0
  @(negedge clk)
    async_sig = 1'b0;

  // Verify that after NUM_FFS clock, the async_sig appears at sync_sig
  for (i = 32'd0; i < `NUM_FFS; i = i + 32'd1) begin
    @(posedge clk);
  end

  // Check sync_sig
  @(negedge clk)
    if (sync_sig !== 1'b0) begin
      $display ("ERROR - expected 1'b0 on sync_sig, received %b @ %0t", sync_sig, $time);
    end

  $display ("======================================");
  $finish ();
end

//===========================================================================//
// UUT (sync.v)
//===========================================================================//
sync #(.NUM_FFS(`NUM_FFS)) sync_0 (
  .clk(clk),
  .rst_n(rst_n),
  .async_sig(async_sig),
  .sync_sig(sync_sig)
);

endmodule
