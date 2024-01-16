`timescale 1ns / 1ps

module swapper (
    input logic x_i,
    input logic y_i,
    input logic swap,
    
    output logic x_o,
    output logic y_o
    
);

assign x_o = (swap == 1'b1) ? y_i : x_i;
assign y_o = (swap == 1'b1) ? x_i : y_i;

endmodule
