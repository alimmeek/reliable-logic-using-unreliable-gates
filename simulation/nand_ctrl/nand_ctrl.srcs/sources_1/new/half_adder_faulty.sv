module half_adder_faulty
# (
    parameter ERROR_PROBABILITY = 0
) (
    input  logic clk,
    input  logic reset_n,

    input  logic x_i,
    input  logic y_i,

    output logic sum_o,
    output logic carry_o,
    output logic valid_o
);

logic interim1;
logic interim1_nxt;
logic interim2;
logic interim2_nxt;
logic interim3;
logic interim3_nxt;
logic interim4;
logic interim4_nxt;
logic interim5;
logic interim5_nxt;;
logic carry_q;
logic carry_nxt;
logic sum_q;
logic sum_nxt;

always_ff @(posedge clk) begin
    if (~reset_n) begin
        interim1 <= '0;
        interim2 <= '0;
        interim3 <= '0;
        interim4 <= '0;
        interim5 <= '0;
        carry_q <= '0;
        sum_q <= '0;
    end else begin
        interim1 <= interim1_nxt;
        interim2 <= interim2_nxt;
        interim3 <= interim3_nxt;
        interim4 <= interim4_nxt;
        interim5 <= interim5_nxt;
        carry_q <= carry_nxt;
        sum_q <= sum_nxt;
    end
end 

assign carry_o = carry_q;
assign sum_o = sum_q;
assign valid_o = 1'b0;

erroneous_nand # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) nand_gate_1 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(x_i),
    .y_i(x_i),
    .z_o(interim1_nxt)
);

erroneous_nand # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) nand_gate_2 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(y_i),
    .y_i(y_i),
    .z_o(interim2_nxt)
);

erroneous_nand # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) nand_gate_3 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(x_i),
    .y_i(y_i),
    .z_o(interim3_nxt)
);

erroneous_nand # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) nand_gate_4 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim1),
    .y_i(interim2),
    .z_o(interim4_nxt)
);

erroneous_nand # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) nand_gate_5 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim4),
    .y_i(interim3),
    .z_o(interim5_nxt)
);

erroneous_nand # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) nand_gate_6 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim5),
    .y_i(interim5),
    .z_o(sum_nxt)
);

erroneous_nand # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) nand_gate_7 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim3),
    .y_i(interim3),
    .z_o(carry_nxt)
);

endmodule
