module multiplexing_unit
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

logic [(N-1):0] x_rand;
logic [(N-1):0] y_rand;
logic [(N-1):0] z_q;
logic [(N-1):0] z_nxt;
logic valid_q;
logic x_ready;
logic y_ready;

for (genvar I = 0; I < 10; I = I + 1) begin
    erroneous_nand # (
        .ERROR_PROBABILITY(ERROR_PROBABILITY)
    ) gate (
        .clk(clk),
        .reset_n(reset_n),
        .x_i(x_rand[I]),
        .y_i(y_rand[I]),
        .z_o(z_nxt[I])
    );
end


always_ff @(posedge clk) begin
    if (~reset_n) begin
        z_q <= 'b0;
        valid_q <= 1'b0;
    end else begin
        z_q <= z_nxt;
        valid_q <= 1'b1;
    end
end

assign z_o = z_q;
assign valid_o = valid_q;

randomizer # (
    .N(N)
) rand_x (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(x_i),
    .x_o(x_rand),
    .valid_o(x_ready)
);

randomizer # (
    .N(N)
) rand_y (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(y_i),
    .x_o(y_rand),
    .valid_o(y_ready)
);
    
endmodule