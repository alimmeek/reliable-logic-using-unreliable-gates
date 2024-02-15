module decoder # (
    parameter ERROR_PROBABILITY = 0
)(
  input clk,
  input reset_n,
  
  input [14:0] codeword,
  
  output [10:0] msg
);
    
integer parity;

logic [14:0] code_nxt;
logic [14:0] code_q;

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
logic interim7;
logic interim7_nxt;
logic interim8;
logic interim8_nxt;
logic interim9;
logic interim9_nxt;
logic interim10;
logic interim10_nxt;
logic interim11;
logic interim11_nxt;
logic interim12;
logic interim12_nxt;
logic interim13;
logic interim13_nxt;
logic interim14;
logic interim14_nxt;
logic interim15;
logic interim15_nxt;
logic interim16;
logic interim16_nxt;
logic interim17;
logic interim17_nxt;
logic interim18;
logic interim18_nxt;
logic interim19;
logic interim19_nxt;
logic interim20;
logic interim20_nxt;
logic interim21;
logic interim21_nxt;
logic interim22;
logic interim22_nxt;
logic interim23;
logic interim23_nxt;
logic interim24;
logic interim24_nxt;

logic p0;
logic p0_nxt;
logic p1;
logic p1_nxt;
logic p2;
logic p2_nxt;
logic p3;
logic p3_nxt;

always_comb begin
  code_nxt = codeword;
end

always_ff @(posedge clk) begin
  if (~reset_n) begin
    code_q <= '0;
  end else begin
    code_q <= code_nxt;
    parity = {p3, p2, p1, p0};
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
        interim7 <= 1'b0;
        interim8 <= 1'b0;
        interim9 <= 1'b0;
        interim10 <= 1'b0;
        interim11 <= 1'b0;
        interim12 <= 1'b0;
        interim13 <= 1'b0;
        interim14 <= 1'b0;
        interim15 <= 1'b0;
        interim16 <= 1'b0;
        interim17 <= 1'b0;
        interim18 <= 1'b0;
        interim19 <= 1'b0;
        interim20 <= 1'b0;
        interim21 <= 1'b0;
        interim22 <= 1'b0;
        interim23 <= 1'b0;
        interim24 <= 1'b0;
        
        p0 <= 1'b0;
        p1 <= 1'b0;
        p2 <= 1'b0;
        p3 <= 1'b0;
        
    end else begin
        interim1 <= interim1_nxt;
        interim2 <= interim2_nxt;
        interim3 <= interim3_nxt;
        interim4 <= interim4_nxt;
        interim5 <= interim5_nxt;
        interim6 <= interim6_nxt;
        interim7 <= interim7_nxt;
        interim8 <= interim8_nxt;
        interim9 <= interim9_nxt;
        interim10 <= interim10_nxt;
        interim11 <= interim11_nxt;
        interim12 <= interim12_nxt;
        interim13 <= interim13_nxt;
        interim14 <= interim14_nxt;
        interim15 <= interim15_nxt;
        interim16 <= interim16_nxt;
        interim17 <= interim17_nxt;
        interim18 <= interim18_nxt;
        interim19 <= interim19_nxt;
        interim20 <= interim20_nxt;
        interim21 <= interim21_nxt;
        interim22 <= interim22_nxt;
        interim23 <= interim23_nxt;
        interim24 <= interim24_nxt;
        
        p0 <= p0_nxt;
        p1 <= p1_nxt;
        p2 <= p2_nxt;
        p3 <= p3_nxt;
    end
end

assign msg = {code_q[14], code_q[13], code_q[12], code_q[11], code_q[10], code_q[9], code_q[8], code_q[6], code_q[5], code_q[4], code_q[2]};

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
    .x_i(codeword[8]),
    .y_i(codeword[10]),
    .z_o(interim3_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_4 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(codeword[12]),
    .y_i(codeword[14]),
    .z_o(interim4_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_5 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim1),
    .y_i(interim2),
    .z_o(interim5_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_6 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim3),
    .y_i(interim4),
    .z_o(interim6_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_7 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim5),
    .y_i(interim6),
    .z_o(p0_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_8 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(codeword[1]),
    .y_i(codeword[2]),
    .z_o(interim7_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_9 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(codeword[5]),
    .y_i(codeword[6]),
    .z_o(interim8_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_10 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(codeword[9]),
    .y_i(codeword[10]),
    .z_o(interim9_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_11 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(codeword[13]),
    .y_i(codeword[14]),
    .z_o(interim10_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_12 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim7),
    .y_i(interim8),
    .z_o(interim11_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_13 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim9),
    .y_i(interim10),
    .z_o(interim12_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_14 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim11),
    .y_i(interim12),
    .z_o(p1_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_15 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(codeword[3]),
    .y_i(codeword[4]),
    .z_o(interim13_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_16 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(codeword[5]),
    .y_i(codeword[6]),
    .z_o(interim14_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_17 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(codeword[11]),
    .y_i(codeword[12]),
    .z_o(interim15_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_18 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(codeword[13]),
    .y_i(codeword[14]),
    .z_o(interim16_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_19 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim13),
    .y_i(interim14),
    .z_o(interim17_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_20 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim15),
    .y_i(interim16),
    .z_o(interim18_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_21 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim17),
    .y_i(interim18),
    .z_o(p2_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_22 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(codeword[7]),
    .y_i(codeword[8]),
    .z_o(interim19_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_23 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(codeword[9]),
    .y_i(codeword[10]),
    .z_o(interim20_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_24 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(codeword[11]),
    .y_i(codeword[12]),
    .z_o(interim21_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_25 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(codeword[13]),
    .y_i(codeword[14]),
    .z_o(interim22_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_26 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim19),
    .y_i(interim20),
    .z_o(interim23_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_27 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim21),
    .y_i(interim22),
    .z_o(interim24_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_28 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim23),
    .y_i(interim24),
    .z_o(p3_nxt)
);

endmodule