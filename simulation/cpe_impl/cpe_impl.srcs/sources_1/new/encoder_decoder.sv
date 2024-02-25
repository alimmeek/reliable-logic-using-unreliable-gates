module encoder_decoder # (
    parameter ERROR_PROBABILITY = 0
)(
    input clk,
    input reset_n,
    
    input [6:0] codeword,
    input e0,
    input e1,
    input e2,
    
    output [6:0] code_corrected
);

logic [6:0] code_nxt;
logic [6:0] code_q;
logic e0_comp;
logic e0_nxt;
logic e1_comp;
logic e1_nxt;
logic e2_comp;
logic e2_nxt;

always_comb begin
  code_nxt = codeword;
end

always_ff @(posedge clk) begin
    if (~reset_n) begin
        code_q <= 6'b0;
        e0_comp <= 1'b0;
        e1_comp <= 1'b0;
        e2_comp <= 1'b0;
        
    end else begin
        code_q <= code_nxt;  
        e0_comp <= e0_nxt;
        e1_comp <= e1_nxt;
        e2_comp <= e2_nxt;
        
        if (e0_comp != e0 && e1_comp == e1) begin // error in message bit 0
            code_q[2] <= ~code_q[2];
        end
        
        if (e1_comp != e1 && e2_comp == e2) begin // error in message bit 1
            code_q[4] = ~code_q[4];
        end
        
        if (e2_comp != e2 && e1_comp == e1) begin // error in message bit 3
            code_q[6] = ~code_q[6];
        end
        
        if (e2_comp != e2 && e1_comp != e1) begin // error in message bit 2
            code_q[5] = ~code_q[5];
        end
    end
end

assign code_corrected = code_q;

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_1 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(codeword[0]),
    .y_i(codeword[1]),
    .z_o(e0_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_2 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(codeword[1]),
    .y_i(codeword[2]),
    .z_o(e1_nxt)
);

erroneous_xor # (
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) gate_3 (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(codeword[2]),
    .y_i(codeword[3]),
    .z_o(e2_nxt)
);

endmodule
