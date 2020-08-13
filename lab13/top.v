`timescale 1ns / 1ps

module top(
address,Memwrite,clock,

caddress,address,memread,ioread,iowrite,
ioread_data,wdata,rdata,

reset,ior,ioread_data,ioread_data_switch,

led_clk,ledrst,ledwrite,ledaddr,ledwdata, ledout,

switclk, switrst, switchread, switchcs,switchaddr, switchrdata, switch_i
    );
//input[31:0] address;   // 来自 memorio模块，源头是来自执行单元的输出 alu_result 
//input[31:0] write_data;  // 来自译码单元的 read_data2 
input Memwrite; // 来自控制单元 
input clock; // 时钟信号
//output[31:0] read_data;// 从存储器读出的数据 就是mread_data

    input[31:0] caddress;       // from alu_result in executs32
    input memread;				// read memory, from control32
//    input Memwrite;				// write memory, from control32
    input ioread;				// read IO, from control32
    input iowrite;				// write IO, from control32
//  input[31:0] mread_data;		// data from memory
    input[15:0] ioread_data;	// data from io,16 bits
    input[31:0] wdata;			// the data from idecode32,that want to write memory or io
    output[31:0] rdata;			// data from memory or IO that want to read into register
//   output[31:0] write_data;    // data to memory or I/O
//  output[31:0] address;       // address to mAddress and I/O
//    output LEDCtrl;				// LED CS
//    output SwitchCtrl;      

    input reset;			// 复位信号 
    input ior;              //  从控制器来的I/O读，
//    input SwitchCtrl;		//  从memorio经过地址高端线获得的拨码开关模块片选
    input[15:0] ioread_data_switch;  //从外设来的读数据，此处来自拨码开关
    output[15:0] ioread_data;	// 将外设来的数据送给memorio

    input led_clk;    		    // 时钟信号
    input ledrst; 		        // 复位信号
    input ledwrite;		       // 写信号
 // input LEDCtrl;		      // 从memorio来的，由低至高位形成的LED片选信号   !!!!!!!!!!!!!!!!!
    input[1:0] ledaddr;	        //  到LED模块的地址低端  !!!!!!!!!!!!!!!!!!!!
    input[15:0] ledwdata;	  //  写到LED模块的数据，注意数据线只有16根
    output[23:0] ledout;	//  向板子上输出的24位LED信号

    input switclk;			       //  时钟信号
    input switrst;			       //  复位信号
    input switchcs;			      //从memorio来的，由低至高位形成的switch片选信号  !!!!!!!!!!!!!!!!!
    input[1:0] switchaddr;		    //  到switch模块的地址低端  !!!!!!!!!!!!!!!
    input switchread;			    //  读信号
    output [15:0] switchrdata;	     //  送到CPU的拨码开关值注意数据总线只有16根
    input [23:0] switch_i;		    //  从板上读的24位开关数据

wire SwitchCtrl;
wire LEDCtrl;
wire [31:0] write_data;
wire [31:0] address;
wire [31:0]mread_data;

dmomory32 gate001(
    .mread_data(read_data),
    .address(address),
    .write_data(write_data),
    .Memwrite(Memwrite),
    .clock(clock)
);
memorio gate010(
    .caddress(caddress),
    .address(address),
    .memread(memread),
    .Memwrite(memwrite),
    .ioread(ioread),
    .iowrite(iowrite),
    .mread_data(mread_data),
    .ioread_data(ioread_data),
    .wdata(wdata),
    .rdata(rdata),
    .write_data(write_data),
    .LEDCtrl(LEDCtrl),
    .SwitchCtrl(SwitchCtrl)
);
ioread gate011(
    .reset(reset),
    .ior(ior),
    .SwitchCtrl(switchctrl),
    .ioread_data(ioread_data),
    .ioread_data_switch(ioread_data_switch)
);
leds gate100(
    .led_clk(led_clk),
    .ledrst(ledrst),
    .ledwrite(ledwrite),
    .LEDCtrl(ledcs),
    .ledaddr(ledaddr),
    .ledwdata(ledwdata),
    .ledout(ledout)
);
switchs gate101(
    .switclk(switclk),
    .switrst(switrst),
    .switchcs(switchcs),
    .switchaddr(switchaddr),
    .switchread(switchread),
    .switchrdata(switchrdata),
    .switch_i(switch_i)

);
endmodule