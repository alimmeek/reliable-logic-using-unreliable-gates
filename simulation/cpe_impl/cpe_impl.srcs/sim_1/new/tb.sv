module tb();

    localparam ERROR_PROBABILITY = 0;

    logic TBCLK;
    logic nTBRST;

    logic [10:0] x_i;
    logic [10:0] y_i;
    logic [10:0] sum_q;
    logic [10:0] carry_q;

    initial begin
        TBCLK = 1'b0;
        forever #5 TBCLK = ~TBCLK;
    end

    initial begin
        nTBRST = 1'b0;
        #100
        nTBRST = 1'b1;           
    end
    
    
    initial begin
        x_i = '1;
        y_i = '1;
    end

    half_adder # (
        .ERROR_PROBABILITY(ERROR_PROBABILITY)
    ) uut (
        .clk(TBCLK),
        .reset_n(nTBRST),

        .x_i(x_i),
        .y_i(y_i),

        .sum_o(sum_q),
        .carry_o(carry_q)
    );
endmodule