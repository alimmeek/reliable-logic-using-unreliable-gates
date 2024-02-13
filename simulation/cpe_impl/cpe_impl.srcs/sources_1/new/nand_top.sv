module nand_top (
  input clk,
  input reset_n,
  
  input  [10:0] msg,
  
  output [14:0] codeword
);


encoder e (
  .clk(clk),
  .reset_n(reset_n),
  
  .msg(msg),
  .codeword(codeword)
);

endmodule
