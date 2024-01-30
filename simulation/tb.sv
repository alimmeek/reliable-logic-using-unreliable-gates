module tb();

    localparam ERROR_PROBABILITY = 0;
    localparam N = 10;

    logic TBCLK;
    logic nTBRST;

    logic [(N-1):0] x_i;
    logic [(N-1):0] y_i;
    logic [(N-1):0] z_q;
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
        x_i = '0;
        y_i = '0;

//            integer x_seed, y_seed;
//            integer x_decision;
//            integer y_decision;
//            x_decision = $dist_uniform(x_seed, 1, 100);
//            y_decision = $dist_uniform(y_seed, 1, 100);
            
//            x_i = (x_decision < 50) ? 'b1 : 'b0;
//            y_i = (y_decision < 50) ? 'b1 : 'b0;
            
//            wait (valid_q == 1'b1);
//            @ (posedge TBCLK);
    end

    circuit # (
        .N(N),
        .ERROR_PROBABILITY(ERROR_PROBABILITY)
    ) uut (
        .clk(TBCLK),
        .reset_n(nTBRST),

        .x_i(x_i),
        .y_i(y_i),

        .z_o(z_q),
        .valid_o(valid_q)
    );
endmodule