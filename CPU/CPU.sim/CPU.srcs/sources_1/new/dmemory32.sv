`timescale 1ns / 1ps
module dmemory32(read_data,address,write_data,Memwrite,clock); 

output[31:0] read_data;// 从存储器读出的数据 
input[31:0] address;// 来自 memorio模块，源头是来自执行单元的输出 alu_result 
input[31:0] write_data;   // 来自译码单元的 read_data2 
input Memwrite; // 来自控制单元 
input clock;// 时钟信号 
wire clk;
assign clk = !clock; 
RAM ram ( .clka(clk), // input wire clka 
.wea(Memwrite), // input wire [0 : 0] wea 
.addra(address[15:2]), // input wire [13 : 0] addra
.dina(write_data), // input wire [31 : 0] dina 
.douta(read_data) // output wire [31 : 0] douta
 );

endmodule