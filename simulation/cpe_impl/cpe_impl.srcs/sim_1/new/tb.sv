module tb();

    localparam ERROR_PROBABILITY = 0;

    logic TBCLK;
    logic nTBRST;

    logic [10:0] x_i;
    logic [14:0] codeword;

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
    end

    nand_top # (
        .ERROR_PROBABILITY(ERROR_PROBABILITY)
    ) uut (
        .clk(TBCLK),
        .reset_n(nTBRST),

        .msg(x_i),
        
        .codeword(codeword)
    );
endmodule