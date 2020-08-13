`timescale 1ns / 1ps

module cpu_sim();
reg clk = 0;
reg rst = 1;
reg  [23:0] switch2N4 = 8'b10101010;
wire [23:0]led2N4;

cpu test(
.clk(clk),
.rst(rst),
.switch2N4(switch2N4),
.led2N4(led2N4)
);
initial begin
#7000
rst = 0;
switch2N4 = 24'b00100000_1110_1110_1101_0000;

end
always #10 clk = ~clk;
endmodule