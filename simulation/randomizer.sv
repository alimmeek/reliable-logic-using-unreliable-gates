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

class heads_tails;

    rand int toss;
    constraint flip_dont_flip_ratio {
        toss dist {
            1 := 50,
            0 := 50
        };
    }

    function automatic new ();
        if (!this.randomize()) $error("Randomisation failed");
    endfunction
endclass

logic tmp;
logic [(N-1):0] x_nxt;
logic [(N-1):0] x_q;
logic count = 'b0;
logic valid_q;

heads_tails coin = new();

for (genvar I = 0; I < N; I = I + 1) begin
    if (coin.toss == 1 && I < N-1) begin
        tmp = x_i[I];
        x_i[I] = x_i[I+1];
        x_i[I+1] = tmp;
    end
    
    x_nxt[I] = x_i[I];
    coin.randomize();
    count = count + 1;
end

always_ff @(posedge clk) begin
    if (~reset_n) begin
        x_q <= 'b0;
        valid_q <= 1'b0;
    end else begin
        valid_q <= 1'b0;
        if (count == N) begin
            x_q <= x_nxt;
            valid_q <= 1'b1;
        end 
    end
end

assign x_o = x_q;
assign valid_o = valid_q
    
endmodule