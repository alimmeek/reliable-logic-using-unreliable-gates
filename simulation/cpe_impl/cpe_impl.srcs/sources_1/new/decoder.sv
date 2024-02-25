module decoder # (
    parameter ERROR_PROBABILITY = 0
)(
  input clk,
  input reset_n,
  
  input [6:0] codeword,
  
  output [3:0] msg
);
    
integer parity;

logic [6:0] code_nxt;
logic [6:0] code_q;

logic interim1;
logic interim1_nxt;
logic interim2;
logic interim2_nxt;
logic interim3;
logic interim3_nxt;
logic interim4;
logic interim4_nxt;
logic interim5;
logic interim5_nxt;
logic interim6;
logic interim6_nxt;

logic p0;
logic p0_nxt;
logic p1;
logic p1_nxt;
logic p2;
logic p2_nxt;

always_comb begin
  code_nxt = codeword;
end

always_ff @(posedge clk) begin
  if (~reset_n) begin
    code_q <= '0;
  end else begin
    code_q <= code_nxt;
    parity = {p2, p1, p0};
    if (parity != 0) begin
      code_q[parity-1] <= ~code_q[parity-1];
    end
  end
end

always_ff @(posedge clk) begin
    if (~reset_n) begin
        
        interim1 <= 1'b0;
        interim2 <= 1'b0;
        interim3 <= 1'b0;
        interim4 <= 1'b0;
        interim5 <= 1'b0;
        interim6 <= 1'b0;
        
        p0 <= 1'b0;
        p1 <= 1'b0;
        p2 <= 1'b0;
        
    end else begin
        interim1 <= interim1_nxt;
        interim2 <= interim2_nxt;
        interim3 <= interim3_nxt;
        interim4 <= interim4_nxt;
        interim5 <= interim5_nxt;
        interim6 <= interim6_nxt;
        
        p0 <= p0_nxt;
        p1 <= p1_nxt;
        p2 <= p2_nxt;
    end
end

assign msg = {code_q[6], code_q[5], code_q[4], code_q[2]};

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_1 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(codeword[0]),
    .y_i(codeword[2]),
    .z_o(interim1_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_2 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(codeword[4]),
    .y_i(codeword[6]),
    .z_o(interim2_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_3 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim1),
    .y_i(interim2),
    .z_o(p0_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_4 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(codeword[1]),
    .y_i(codeword[2]),
    .z_o(interim3_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_5 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(codeword[5]),
    .y_i(codeword[6]),
    .z_o(interim4_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_6 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim3),
    .y_i(interim4),
    .z_o(p1_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_7 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(codeword[3]),
    .y_i(codeword[4]),
    .z_o(interim5_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_8 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(codeword[5]),
    .y_i(codeword[6]),
    .z_o(interim6_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_9 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim5),
    .y_i(interim6),
    .z_o(p2_nxt)
);

endmodule