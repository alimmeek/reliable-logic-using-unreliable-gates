module reliable_nand
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

logic [(N-1):0] interim1;
logic [(N-1):0] interim2;
logic [(N-1):0] out_q;

logic valid1;
logic valid2;
logic valid3;

always_ff @(posedge clk) begin
    if (~reset_n) begin
        out_q <= 'b0;
    end else begin
        multiplexing_unit # (
            .N(N),
            .ERROR_PROBABILITY(ERROR_PROBABILITY)
        ) executive (
            .clk(clk),
            .reset_n(reset_n),
            .x_i(x_i),
            .y_i(y_i),
            .z_o(interim1)
            .valid_o(valid1)
        );

        multiplexing_unit # (
            .N(N),
            .ERROR_PROBABILITY(ERROR_PROBABILITY)
        ) restorative1 (
            .clk(clk),
            .reset_n(reset_n),
            .x_i(interim1),
            .y_i(interim1),
            .z_o(interim2)
            .valid_o(valid2)
        );

        multiplexing_unit # (
            .N(N),
            .ERROR_PROBABILITY(ERROR_PROBABILITY)
        ) restorative2 (
            .clk(clk),
            .reset_n(reset_n),
            .x_i(interim2),
            .y_i(interim2),
            .z_o(out_q)
            .valid_o(valid3)
        );
    end
end

assign z_o = out_q;
assign valid_o = valid1 && valid2 && valid3;

endmodule