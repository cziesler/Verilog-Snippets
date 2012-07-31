//===========================================================================//
// File name: ram.v
// Author:    Cody Cziesler
//
// Description: A ram model with synchronous write, asynchronous read, write
// enable, read enable, asynchronous reset. The width and depth are
// parameterized.
//
//===========================================================================//

module ram
  #(parameter AWIDTH = 4, // The width of the address
              DWIDTH = 8) // The width of the data
(
  input   wire                  clk,    // Clock for writing
  input   wire                  rst_n,  // Active low asynch reset

  // Write ports
  input   wire                  we,     // Active high write enable
  input   wire   [AWIDTH-1:0]   waddr,  // Write address
  input   wire   [DWIDTH-1:0]   wdata,  // Write data

  // Read ports
  input   wire                  re,     // Active high read enable
  input   wire   [AWIDTH-1:0]   raddr,  // Read address
  output  wire   [DWIDTH-1:0]   rdata   // Read data
);

//---------------------------------------------------------------------------//
// The depth of the memory (2^(AWIDTH))
//---------------------------------------------------------------------------//
parameter SIZE = 2**AWIDTH;

//---------------------------------------------------------------------------//
// The memory (DWIDTH wide, SIZE deep)
//---------------------------------------------------------------------------//
reg [DWIDTH-1:0] mem [SIZE-1:0];

//---------------------------------------------------------------------------//
// A lcv for reseting memory
//---------------------------------------------------------------------------//
integer i;

//---------------------------------------------------------------------------//
// Assign the read data when re is high
//---------------------------------------------------------------------------//
assign rdata[DWIDTH-1:0] = (re == 1'b1) ? mem[raddr] : {DWIDTH{1'b0}};

//---------------------------------------------------------------------------//
// The synchronous write block with asynchronous reset and synchronous
// enable
//---------------------------------------------------------------------------//
always @(posedge clk or negedge rst_n) begin
  if (~rst_n) begin
    for (i = 32'd0; i < SIZE; i = i + 32'd1) begin
      mem[i] <= {DWIDTH{1'b0}};
    end
  end else begin
    if (we == 1'b1) begin
      mem[waddr] <= wdata;
    end
  end
end

endmodule
