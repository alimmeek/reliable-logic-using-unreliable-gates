module tb();

    localparam ERROR_PROBABILITY = 100;

    logic TBCLK;
    logic nTBRST;

    logic x_i;
    logic y_i;
    logic sum_q;
    logic carry_q;
    logic valid_q;

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
        x_i = 1'b0;
        y_i = 1'b1;
    end

    half_adder_faulty # (
        .ERROR_PROBABILITY(ERROR_PROBABILITY)
    ) uut (
        .clk(TBCLK),
        .reset_n(nTBRST),

        .x_i(x_i),
        .y_i(y_i),

        .sum_o(sum_q),
        .carry_o(carry_q),
        .valid_o(valid_q)
    );
endmodule