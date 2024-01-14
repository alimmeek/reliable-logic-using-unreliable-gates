module circuit
# (
    parameter N = 10,
    parameter ERROR_PROBABILITY = 0
) (
    input  logic clk,
    input  logic reset_n,

    input  logic [(N-1):0] x_i,
    input  logic [(N-1):0] y_i,

    output logic [(N-1):0] z_o,
    output logic           valid_o
);


logic valid_nxt;
logic [(N-1):0] z_nxt;
logic [(N-1):0] z_q;

always_ff @(posedge clk) begin
    if (~reset_n) begin
        z_q <= 'b0;
        valid_q <= 1'b0;
    end else begin
        if (valid_nxt) begin
            z_q <= z_nxt;
        end
        valid_q <= valid_nxt;
    end
end

reliable_nand # (
    .N(N),
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) nand (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(x_i),
    .y_i(y_i),
    .z_o(z_nxt),
    .valid_o(valid_nxt)
);

endmodule