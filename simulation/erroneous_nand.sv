`timescale 1ns / 1ps

module erroneous_nand 
# (
    parameter ERROR_PROBABILITY = 7'b0
) (
    input  logic clk,
    input  logic reset_n,

    input  logic x_i,
    input  logic y_i,

    output logic z_o
);

//class bit_flip;

//    rand int decision;
//    constraint flip_dont_flip_ratio {
//        decision dist {
//            1 := ERROR_PROBABILITY,
//            0 := 100 - ERROR_PROBABILITY
//        };
//    }

//    function automatic new ();
//        if (!this.randomize()) $error("Randomisation failed");
//    endfunction
//endclass

logic z_nxt;
logic z_q;

// bit_flip flip = new();

integer flip, seed;
logic decision;

always_comb begin
    flip = $dist_uniform(seed, 1, 100);
    decision = (flip < (ERROR_PROBABILITY + 1)) ? 1'b1: 1'b0;
    z_nxt = ~(x_i && y_i);
    if (decision == 1'b1) begin
        z_nxt = ~z_nxt;
    end
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