module encoder # (
    parameter ERROR_PROBABILITY = 0
)(
  input clk,
  input reset_n,
  
  input [3:0] msg,
  
  output [6:0] codeword
);
    
logic interim1;
logic interim1_nxt;
logic interim2;
logic interim2_nxt;
logic interim3;
logic interim3_nxt;

logic p0;
logic p0_nxt;
logic p1;
logic p1_nxt;
logic p2;
logic p2_nxt;

logic e0;
logic e0_nxt;
logic e1;
logic e1_nxt;
logic e2;
logic e2_nxt;

logic [6:0] code_q;
logic [6:0] code_corrected_nxt;
logic [6:0] code_err;

always_ff @(posedge clk) begin
    if (~reset_n) begin
        interim1 <= 1'b0;
        interim2 <= 1'b0;
        interim3 <= 1'b0;
        
        p0 <= 1'b0;
        p1 <= 1'b0;
        p2 <= 1'b0;
        
        e0 <= 1'b0;
        e1 <= 1'b0;
        e2 <= 1'b0;
        
    end else begin
        interim1 <= interim1_nxt;
        interim2 <= interim2_nxt;
        interim3 <= interim3_nxt;
        
        p0 <= p0_nxt;
        p1 <= p1_nxt;
        p2 <= p2_nxt;
        
        e0 <= e0_nxt;
        e1 <= e1_nxt;
        e2 <= e2_nxt;
        
        code_err <= {msg[3], msg[2], msg[1], p2, msg[0], p1, p0};
        code_q <= code_corrected_nxt;
    end
end


assign codeword = code_q;


erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_1 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(msg[0]),
    .y_i(msg[1]),
    .z_o(interim1_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_2 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(msg[3]),
    .y_i(interim1),
    .z_o(p0_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_3 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(msg[0]),
    .y_i(msg[2]),
    .z_o(interim2_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_4 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(msg[3]),
    .y_i(interim2),
    .z_o(p1_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_5 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(msg[1]),
    .y_i(msg[2]),
    .z_o(interim3_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_6 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(interim3),
    .y_i(msg[3]),
    .z_o(p2_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_7 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(msg[0]),
    .y_i(msg[1]),
    .z_o(e0_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_8 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(msg[1]),
    .y_i(msg[2]),
    .z_o(e1_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_9 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(msg[2]),
    .y_i(msg[3]),
    .z_o(e2_nxt)
);

encoder_decoder # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) enc_dec (
    .clk(clk),
    .reset_n(reset_n),
    
    .codeword(code_err),
    .e0(e0),
    .e1(e1),
    .e2(e2),
    
    .code_corrected(code_corrected_nxt)
);

endmodule