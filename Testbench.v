`timescale 1ns / 1ps

module tb_jCounter();
reg clk_ti;
reg ori_ti; 
wire [3:0]dout_to;

//instantiation
jCounter DUT(.clk_i(clk_ti), 
   .ori_i(ori_ti), 
   .dout_o(dout_to));

//clock
initial begin
   clk_ti = 1'b0;
   forever
      #5 clk_ti = ~clk_ti;
end

//feeding
initial begin
ori_ti = 1'b1;
#10 ori_ti = 1'b0;
#180 ori_ti = 1'b1;
#25 ori_ti = 1'b0;
#10 $finish;
end

//capture
initial begin
$monitor("Time: %0t | ORI: %b, Clk: %b | Count: %b", $time, ori_ti, clk_ti, dout_to);
$dumpfile("jCounter.vcd");
$dumpvars(0, tb_jCounter);
end

endmodule
