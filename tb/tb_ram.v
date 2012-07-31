//===========================================================================//
// File name: tb_ram.v
// Author:    Cody Cziesler
//
// Description: A test bench for the counter module
//
//===========================================================================//

//===========================================================================//
// Define for size of counter
//===========================================================================//
`define AWIDTH 'd4
`define DWIDTH 'd8

module tb_ram ();

//===========================================================================//
// Inputs to UUT
//===========================================================================//
reg  clk;
reg  rst_n;
reg  we;
reg  re;
reg  [`AWIDTH-1:0] raddr;
reg  [`AWIDTH-1:0] waddr;
reg  [`DWIDTH-1:0] wdata;

//===========================================================================//
// Outputs from UUT
//===========================================================================//
wire [`DWIDTH-1:0] rdata;

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
  $vcdpluson(tb_ram);
end

//===========================================================================//
// Initialize signals and perform test
//===========================================================================//
initial begin
  $display ("======================================");
  $display ("Starting tb_ram with AWIDTH = %0d, DWIDTH = %0d", `AWIDTH,
    `DWIDTH);

  // Initialize signals
  clk       = 1'b0;
  rst_n     = 1'b0;
  raddr     = {`AWIDTH{1'b0}};
  waddr     = {`AWIDTH{1'b0}};
  wdata     = {`DWIDTH{1'b0}};
  re        = 1'b0;
  we        = 1'b0;

  // Take UUT out of reset
  @(negedge clk)
    rst_n = 1'b1;

  // Write the memory
  for (i = 32'd0; i < (2**`AWIDTH); i = i + 1) begin
    write (i[`AWIDTH-1:0], i[`DWIDTH-1:0]);
  end

  // Read the memory
  for (i = 32'd0; i < (2**`AWIDTH); i = i + 1) begin
    read(i[`AWIDTH-1:0], i[`DWIDTH-1:0]);
  end

  $display ("======================================");
  $finish ();
end

//===========================================================================//
// Write task
//
// Sets waddr, wdata, we so that the write occurs on the ram module
//
// @param address - the address to write
// @param data    - the data to write
//===========================================================================//
task write;
  input [`AWIDTH-1:0] address;
  input [`DWIDTH-1:0] data;
begin

  @(negedge clk);
    waddr = address;
    wdata = data;
    we    = 1'b1;

  @(negedge clk);
    we    = 1'b0;

end
endtask

//===========================================================================//
// Read task
//
// Sets raddr and re so that the read data occurs on rdata from the ram
// module
//
// @param address - the address to write
// @param data    - the data to write
//===========================================================================//
task read;
  input [`AWIDTH-1:0] address;
  input [`DWIDTH-1:0] data;
begin

  @(negedge clk);
    raddr = address;
    re    = 1'b1;

  @(negedge clk);
    re    = 1'b0;

  if (rdata !== data) begin
    $display ("ERROR (read): rdata [%0X] !== data [%0X] (%X) @ %0t",
      rdata, data, address, $time);
  end

end
endtask

//===========================================================================//
// UUT (ram.v)
//===========================================================================//
ram #(.AWIDTH(`AWIDTH), .DWIDTH(`DWIDTH)) ram_0 (
  .clk(clk),
  .rst_n(rst_n),
  .re(re),
  .raddr(raddr),
  .rdata(rdata),
  .we(we),
  .waddr(waddr),
  .wdata(wdata)
);

endmodule
