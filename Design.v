`timescale 1ns / 1ps

module jCounter(
input clk_i, 
input ori_i, //overriding input(s) [used for Reset in this design]
output reg [3:0]dout_o
);

always@(posedge clk_i) begin
   if(ori_i) begin
      dout_o <= 4'b0000;
   end
   else begin
      dout_o <= {~dout_o[0], dout_o[3:1]};
   end
end

endmodule
