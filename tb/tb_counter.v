//===========================================================================//
// File name: tb_counter.v
// Author:    Cody Cziesler
//
// Description: A test bench for the counter module
//
//===========================================================================//

//===========================================================================//
// Define for size of counter
//===========================================================================//
`define WIDTH 'd4

module tb_counter ();

//===========================================================================//
// Inputs to UUT
//===========================================================================//
reg  clk;
reg  rst_n;
reg  up_count;

//===========================================================================//
// Outputs from UUT
//===========================================================================//
wire [`WIDTH-1:0] count;

//===========================================================================//
// A lcv signal
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
  $vcdpluson(tb_counter);
end

//===========================================================================//
// Initialize signals and perform test
//===========================================================================//
initial begin
  $display ("======================================");
  $display ("Starting tb_counter with WIDTH = %0d", `WIDTH);

  // Initialize signals
  clk       = 1'b0;
  rst_n     = 1'b0;
  up_count  = 1'b1;

  // Take UUT out of reset
  @(negedge clk)
    rst_n = 1'b1;

  // Compare count to expected count
  for (i = 32'd0; i < 2*(2**(`WIDTH)); i = i + 1) begin
    @(posedge clk)
      if (count[`WIDTH-1:0] !== i[`WIDTH-1:0]) begin
        $display ("ERROR - count [%0h] !== i [%0h] @ %0t", count, i[`WIDTH-1:0],
          $time);
      end
  end

  // Now, count down
  @(negedge clk)
    rst_n = 1'b0;
  @(negedge clk)
    rst_n = 1'b1;

  up_count = 1'b0;
  for (i = (2**(`WIDTH)); i >= 0; i = i - 1) begin
    @(posedge clk)
      if (count[`WIDTH-1:0] !== i[`WIDTH-1:0]) begin
        $display ("ERROR - count [%0h] !== i [%0h] @ %0t", count, i[`WIDTH-1:0],
          $time);
      end
  end

  $display ("======================================");
  $finish ();
end

//===========================================================================//
// UUT (counter.v)
//===========================================================================//
counter #(.WIDTH(`WIDTH)) counter_0 (
  .clk(clk),
  .rst_n(rst_n),
  .up_count(up_count),
  .count(count[`WIDTH-1:0])
);

endmodule
