module nand_top # (
  parameter ERROR_PROBABILITY = 0
)(
  input clk,
  input reset_n,
  
  input  [14:0] x_i,
  input  [14:0] y_i,
  
  output [14:0] z_o
);

logic [10:0] x_decoded;
logic [10:0] x_decoded_nxt;
logic [10:0] y_decoded;
logic [10:0] y_decoded_nxt;
logic [10:0] result;
logic [14:0] encoded;
logic [14:0] encoded_nxt;

always_ff @(posedge clk) begin
  if (~reset_n) begin
    x_decoded <= 10'b0;
    y_decoded <= 10'b0;
    result <= 10'b0;
    encoded <= 14'b0;
  end else begin
    x_decoded <= x_decoded_nxt;
    y_decoded <= y_decoded_nxt;
    result <= ~(x_decoded & y_decoded);
    encoded <= encoded_nxt;
  end
end

assign z_o = encoded;

decoder # (
  .ERROR_PROBABILITY(ERROR_PROBABILITY)
) d_x (
  .clk(clk),
  .reset_n(reset_n),
  
  .codeword(x_i),
  
  .msg(x_decoded_nxt)
);

decoder # (
  .ERROR_PROBABILITY(ERROR_PROBABILITY)
) d_y (
  .clk(clk),
  .reset_n(reset_n),
  
  .codeword(y_i),
  
  .msg(y_decoded_nxt)
);

encoder # (
  .ERROR_PROBABILITY(ERROR_PROBABILITY)
) e (
  .clk(clk),
  .reset_n(reset_n),
  
  .msg(result),
  .codeword(encoded_nxt)
);

endmodule
