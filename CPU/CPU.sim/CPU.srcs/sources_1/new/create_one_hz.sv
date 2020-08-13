`timescale 1ns / 1ps
module create_one_hz(
input clk,
input reset,
output reg clkout1
);
reg [25:0] cnt1;
parameter cnts1 = 100000;
//为什么能拓展成4倍,第一只对上升沿敏感,第二就是由两种状态,2×2 = 4
//100000000 10^8 放慢4倍(偶数)之后仍是整数,就说明是偶数倍.-总是要保证最后得到的是整数
always @(posedge clk,posedge reset)
begin
    if(reset)
    begin
        cnt1 <= 0;
        clkout1<= 0;
    end
    else if(cnt1 == (cnts1>>1)-1)
    begin
        cnt1 <= 0;
        clkout1 <= ~clkout1;
    end
    else
    begin
    cnt1 <= cnt1+1;
    end
end 
endmodule