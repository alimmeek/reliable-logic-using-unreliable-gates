module half_adder
# (
    parameter ERROR_PROBABILITY = 0
) (
    input  logic clk,
    input  logic reset_n,

    input  logic [3:0] x_i,
    input  logic [3:0] y_i,

    output logic [3:0] sum_o,
    output logic [3:0] carry_o
);

logic [6:0] interim1;
logic [6:0] interim1_nxt;
logic [6:0] interim2;
logic [6:0] interim2_nxt;
logic [6:0] interim3;
logic [6:0] interim3_nxt;
logic [6:0] interim4;
logic [6:0] interim4_nxt;
logic [6:0] interim5;
logic [6:0] interim5_nxt;

logic [6:0] x_encoded;
logic [6:0] x_encoded_nxt;
logic [6:0] y_encoded;
logic [6:0] y_encoded_nxt;
logic [3:0] carry_q;
logic [3:0] carry_nxt;
logic [6:0] carry_encoded_q;
logic [6:0] carry_encoded_nxt;
logic [3:0] sum_q;
logic [3:0] sum_nxt;
logic [6:0] sum_encoded_q;
logic [6:0] sum_encoded_nxt;

always_ff @(posedge clk) begin
    if (~reset_n) begin
        interim1 <= '0;
        interim2 <= '0;
        interim3 <= '0;
        interim4 <= '0;
        interim5 <= '0;
        
        x_encoded <= '0;
        y_encoded <= '0;
        carry_q <= '0;
        sum_q <= '0;
        carry_encoded_q <= '0;
        sum_encoded_q <= '0;
    end else begin
        interim1 <= interim1_nxt;
        interim2 <= interim2_nxt;
        interim3 <= interim3_nxt;
        interim4 <= interim4_nxt;
        interim5 <= interim5_nxt;
        
        x_encoded <= x_encoded_nxt;
        y_encoded <= y_encoded_nxt;
        carry_q <= carry_nxt;
        sum_q <= sum_nxt;
        carry_encoded_q <= carry_encoded_nxt;
        sum_encoded_q <= sum_encoded_nxt;
    end
end 

assign carry_o = carry_q;
assign sum_o = sum_q;

encoder # (
  .ERROR_PROBABILITY(ERROR_PROBABILITY)
) e_x (
  .clk(clk),
  .reset_n(reset_n),
  
  .msg(x_i),
  .codeword(x_encoded_nxt)
);

encoder # (
  .ERROR_PROBABILITY(ERROR_PROBABILITY)
) e_y (
  .clk(clk),
  .reset_n(reset_n),
  
  .msg(y_i),
  .codeword(y_encoded_nxt)
);

nand_top # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) nand_gate_1 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(x_encoded),
    .y_i(x_encoded),
    .z_o(interim1_nxt)
);

nand_top # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) nand_gate_2 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(y_encoded),
    .y_i(y_encoded),
    .z_o(interim2_nxt)
);

nand_top # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) nand_gate_3 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(x_encoded),
    .y_i(y_encoded),
    .z_o(interim3_nxt)
);

nand_top # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) nand_gate_4 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim1),
    .y_i(interim2),
    .z_o(interim4_nxt)
);

nand_top # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) nand_gate_5 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim4),
    .y_i(interim3),
    .z_o(interim5_nxt)
);

nand_top # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) nand_gate_6 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim5),
    .y_i(interim5),
    .z_o(sum_encoded_nxt)
);

nand_top # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) nand_gate_7 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim3),
    .y_i(interim3),
    .z_o(carry_encoded_nxt)
);

decoder # (
  .ERROR_PROBABILITY(ERROR_PROBABILITY)
) d_sum (
  .clk(clk),
  .reset_n(reset_n),
  
  .codeword(sum_encoded_q),
  
  .msg(sum_nxt)
);

decoder # (
  .ERROR_PROBABILITY(ERROR_PROBABILITY)
) d_carry (
  .clk(clk),
  .reset_n(reset_n),
  
  .codeword(carry_encoded_q),
  
  .msg(carry_nxt)
);

endmodule