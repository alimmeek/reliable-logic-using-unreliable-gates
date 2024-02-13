module erroneous_xor
# (
    parameter ERROR_PROBABILITY = 0
) (
    input  logic clk,
    input  logic reset_n,

    input  logic x_i,
    input  logic y_i,

    output logic z_o
);


logic z_nxt;
logic z_q;
integer flip, seed;
logic decision;

always_comb begin
    flip = $dist_uniform(seed, 1, 100);
    decision = (flip < (ERROR_PROBABILITY + 1)) ? 1'b1: 1'b0;
    z_nxt = x_i ^ y_i ^ decision;
end


always_ff @(posedge clk) begin
    if (~reset_n) begin
        z_q <= 1'b0;
    end else begin
        z_q <= z_nxt;
    end
end

assign z_o = z_q;
    
endmodule