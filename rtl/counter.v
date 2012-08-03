//===========================================================================//
// File name: counter.v
// Author:    Cody Cziesler
//
// Description: An n-bit counter with asynchronous active-low reset. The
// counter will reset to 0 on an overflow (count < 2^(WIDTH))
//
//===========================================================================//

module counter 
  #(parameter WIDTH = 4)
(
  input   wire                 clk,
  input   wire                 rst_n,
  input   wire                 up_count, // When 1, count up; when 0, count down
  output  wire   [WIDTH-1:0]   count
);

// Flip flops to hold the count
reg  [WIDTH-1:0]  q_count;

// Assign the output count to q_count
assign count = q_count;

// Reset when rst_n is low. Otherwise, count at rising edge of clock
always @(posedge clk or negedge rst_n) begin
  if (~rst_n) begin
    q_count <= {WIDTH{1'b0}};
  end else begin
    if (up_count) begin
      q_count <= q_count + 1'b1;
    end else begin
      q_count <= q_count - 1'b1;
    end
  end
end

endmodule
