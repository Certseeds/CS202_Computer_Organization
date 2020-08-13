`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module memorio(caddress,address,memread,memwrite,ioread,iowrite,mread_data,ioread_data,wdata,rdata,write_data,LEDCtrl,SwitchCtrl);
    input[31:0] caddress;       // from alu_result in executs32
    input memread;				// read memory, from control32
    input memwrite;				// write memory, from control32
    input ioread;				// read IO, from control32
    input iowrite;				// write IO, from control32
    input[31:0] mread_data;		// data from memory
    input[15:0] ioread_data;	// data from io,16 bits
    input[31:0] wdata;			// the data from idecode32,that want to write memory or io
    output[31:0] rdata;			// data from memory or IO that want to read into register
    output[31:0] write_data;    // data to memory or I/O
    output[31:0] address;       // address to mAddress and I/O
	
    output LEDCtrl;				// LED CS
    output SwitchCtrl;          // Switch CS
    
   reg[31:0] write_data; 
   wire iorw;
assign address = caddress; 
assign rdata = (memread == 1'b1&&ioread == 1'b0)?mread_data:((memread == 1'b0 && ioread == 1'b1)?{16{1'b0},ioread_data[15:0]}:32'b0); // 可能是从memory读出，也可能自io读出，自io读取的数据是rdata的低16bit 
assign iorw = (iowrite||ioread);
assign LEDCtrl= (iowrite == 1'b1)?1'b1:1'b0; // led 模块的片选信号，高电平有效; 
assign SwitchCtrl= (ioread == 1'b1)?1'b1:1'b0; //switch 模块的片选信号，高电平有效;
always @* 
begin 
    if((memwrite==1)||(iowrite==1)) 
    begin 
    write_data = ((memwrite == 1'b1)?wdata:{16{1'b0},wdata[15:0]});
       //向io的写操作数据写入write_data的低16bit，高16bit为0 
    end 
    else begin 
    write_data = 32'hZZZZZZZZ; 
    end 
end 
endmodule