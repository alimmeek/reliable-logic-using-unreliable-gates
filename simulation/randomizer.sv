module randomizer
# (
    parameter N = 10
) (
    input  logic clk,
    input  logic reset_n,

    input  logic [(N-1):0] x_i,

    output logic [(N-1):0] x_o,
    output logic           valid_o
);

//class heads_tails;

//    rand int toss;
//    constraint flip_dont_flip_ratio {
//        toss dist {
//            1 := 50,
//            0 := 50
//        };
//    }

//    function automatic new ();
//        if (!this.randomize()) $error("Randomisation failed");
//    endfunction
//endclass

logic tmp;
logic [(N-1):0] x_nxt;
logic [(N-1):0] x_q;
logic valid_q;

integer seed;


// heads_tails coin = new();

genvar I;
for (I = 0; I < N; I = I + 1) begin
    integer toss = $dist_uniform(seed, 1, 100);
    logic decision = (toss < 50) ? 1'b1: 1'b0;
    if (I >>> 1 == 1'b1) begin
        if (I < N) begin
            swapper tmp (
                .x_i(x_i[I]),
                .y_i(x_i[I+1]),
                .swap(decision),
                .x_o(x_nxt[I]),
                .y_o(x_nxt[I+1])
            );
        end
    end
    if (I == N) begin
        cursed_fix i_hate_my_life (
            .x_i(x_i[I]),
            .y_o(x_nxt[I])
        );
   end
end

always_ff @(posedge clk) begin
    if (~reset_n) begin
        x_q <= 'b0;
        valid_q <= 1'b0;
    end else begin
        x_q <= x_nxt;
        valid_q <= 1'b1;
    end
end

assign x_o = x_q;
assign valid_o = valid_q;
    
endmodule