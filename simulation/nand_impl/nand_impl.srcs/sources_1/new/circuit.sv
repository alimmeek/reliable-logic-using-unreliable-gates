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
logic valid_q;
logic [(N-1):0] z_prev;
logic [(N-1):0] z_nxt;
logic [(N-1):0] z_q;
logic [1:0] counter;


always_ff @(posedge clk) begin
    if (~reset_n) begin
        z_q <= 'b0;
        z_prev <= 'b0;
        valid_q <= 1'b0;
        counter <= 2'b0;
    end else begin
        if (z_prev != z_q) begin
            if (counter < 2'd3) begin
                counter <= counter + 1'b1;
            end else begin
                counter <= 2'd3;
            end
        end
        z_prev <= z_q;
        z_q <= z_nxt;
        valid_q <= (counter >= 2'd3) ? 1'b1 : 1'b0;
    end
end

assign z_o = z_q;
assign valid_o = valid_q;

assign z_o = z_q;
assign valid_o = valid_q;

reliable_nand # (
    .N(N),
    .ERROR_PROBABILITY(ERROR_PROBABILITY)
) nand_gate (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(x_i),
    .y_i(y_i),
    .z_o(z_nxt)
);


endmodule