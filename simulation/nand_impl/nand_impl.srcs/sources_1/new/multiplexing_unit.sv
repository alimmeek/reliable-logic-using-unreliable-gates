module multiplexing_unit
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

logic [(N-1):0] x_rand;
logic [(N-1):0] y_rand;
logic [(N-1):0] z_q;
logic [(N-1):0] z_nxt;

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
    end else begin
        z_q <= z_nxt;
    end
end

assign z_o = z_q;

randomizer # (
    .N(N)
) rand_x (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(x_i),
    .x_o(x_rand)
);

randomizer # (
    .N(N)
) rand_y (
    .clk(clk),
    .reset_n(reset_n),
    .x_i(y_i),
    .x_o(y_rand)
);
    
endmodule