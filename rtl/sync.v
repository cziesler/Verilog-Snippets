//===========================================================================//
// File name: sync.v
// Author:    Cody Cziesler
//
// Description: A synchronizer for crossing clock domains
//
//===========================================================================//

module sync (
  input   wire   clk,
  input   wire   rst_n,
  input   wire   async_sig,
  output  wire   sync_sig
);

parameter NUM_FFS = 'd2;

// Registers to synchronize the incoming signal
reg [NUM_FFS-1:0] ffs;

// sync_sig is the last ff in the chain
assign sync_sig = ffs[NUM_FFS-1];

// At each rising edge, shift the async_sig in
always @(posedge clk or negedge rst_n) begin
  if (~rst_n) begin
    ffs <= {NUM_FFS-1{1'b0}};
  end else begin
    ffs <= {ffs[NUM_FFS-2:0],async_sig};
  end
end 

endmodule
