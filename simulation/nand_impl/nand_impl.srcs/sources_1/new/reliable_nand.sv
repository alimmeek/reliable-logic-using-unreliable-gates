module reliable_nand
# (
    parameter N = 10,
    parameter ERROR_PROBABILITY = 0
) (
    input  logic clk,
    input  logic reset_n,

    input  logic [(N-1):0] x_i,
    input  logic [(N-1):0] y_i,

    output logic [(N-1):0] z_o
);

logic [(N-1):0] interim1;
logic [(N-1):0] interim1_nxt;
logic [(N-1):0] interim2;
logic [(N-1):0] interim2_nxt;
logic [(N-1):0] out_q;
logic [(N-1):0] out_nxt;

always_ff @(posedge clk) begin
    if (~reset_n) begin
        out_q <= 'b0;
        interim1 <= 'b0;
        interim2 <= 'b0;
    end else begin
        out_q <= out_nxt;
        interim1 <= interim1_nxt;
        interim2 <= interim2_nxt;
    end
end

assign z_o = out_q;

multiplexing_unit # (
    .N(N),
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) executive (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(x_i),
    .y_i(y_i),
    .z_o(interim1_nxt)
);

multiplexing_unit # (
    .N(N),
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) restorative1 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim1),
    .y_i(interim1),
    .z_o(interim2_nxt)
);

multiplexing_unit # (
    .N(N),
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) restorative2 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim2),
    .y_i(interim2),
    .z_o(out_nxt)
);


endmodule