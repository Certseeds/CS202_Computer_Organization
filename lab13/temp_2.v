`timescale 1ns / 1ps
module top_sim();
reg Memwrite; // 来自控制单元 
reg clock; // 时钟信号
//wire[31:0] read_data;// 从存储器读出的数据 就是mread_data

    reg[31:0] caddress;       // from alu_result in executs32
    reg memread;				// read memory, from control32
    reg ioread;				// read IO, from control32
    reg iowrite;				// write IO, from control32
    reg[31:0] wdata;			// the data from idecode32,that want to write memory or io
    wire[31:0] rdata;			// data from memory or IO that want to read into register
    

    reg reset;			// 复位信号 
    reg ior;              //  从控制器来的I/O读，
    reg[15:0] ioread_data_switch;  //从外设来的读数据，此处来自拨码开关

    reg led_clk;    		    // 时钟信号
    reg ledrst; 		        // 复位信号
    reg ledwrite;		       // 写信号
    reg[1:0] ledaddr;	        //  到LED模块的地址低端  !!!!!!!!!!!!!!!!!!!!
    reg[15:0] ledwdata;	  //  写到LED模块的数据，注意数据线只有16根
    wire[23:0] ledout;	//  向板子上输出的24位LED信号

    reg switclk;			       //  时钟信号
    reg switrst;			       //  复位信号
    reg switchcs;			      //从memorio来的，由低至高位形成的switch片选信号  !!!!!!!!!!!!!!!!!
    reg[1:0] switchaddr;		    //  到switch模块的地址低端  !!!!!!!!!!!!!!!
    reg switchread;			    //  读信号
    wire [15:0] switchrdata;	     //  送到CPU的拨码开关值注意数据总线只有16根
    reg [23:0] switch_i;		    //  从板上读的24位开关数据

    wire[31:0] read_data_1;               // 输出的第一操作数
    wire[31:0] read_data_2;               // 输出的第二操作数
    reg[31:0]  Instruction;               // 取指单元来的指令
  //  input[31:0]  read_data;  //又名rdata			//  从DATA RAM or I/O port取出的数据
    reg[31:0]  ALU_result;   				// 从执行单元来的运算的结果，需要扩展立即数到32位
    reg        Jal;                               //  来自控制单元，说明是JAL指令 
    reg        RegWrite;                  // 来自控制单元
    reg       MemtoReg;              // 来自控制单元
    reg        RegDst;                    //  来自控制单元
    wire[31:0] Sign_extend;               // 译码单元输出的扩展后的32位立即数
//   input		 clock,reset;                // 时钟和复位
    reg[31:0]  opcplus4;                 // 来自取指单元，JAL中用
    wire [31:0] register[0:31];


top gate111(
    .Memwrite(Memwrite),.clock(clock),
    
    .caddress(caddress),.memread(memread),
    .ioread(ioread),.iowrite(iowrite),
    .wdata(wdata),.rdata(rdata),
    
    .reset(reset),.ior(ior),.ioread_data_switch(ioread_data_switch),
    
    .led_clk(led_clk),.ledrst(ledrst),.ledwrite(ledwrite),.ledaddr(ledaddr),
    .ledwdata(ledwdata),.ledout(ledout),
    
    .switclk(switclk), .switrst(switrst), .switchread(switchread),
    .switchcs(switchcs),.switchaddr(switchaddr), .switchrdata(switchrdata), 
    .switch_i(switch_i)

    .read_data_1(read_data_1),.read_data_2(read_data_2),.Instruction(Instruction),
    .ALU_result(ALU_result),Jal(Jal),.RegWrite(RegWrite),.MemtoReg(MemtoReg)
    ,.RegDst(RegDst),.Sign_extend(Sign_extend),.opcplus4(opcplus4),
    .register(register)
    );    
    initial 
    begin
          Memwrite = 0; // 来自控制单元 
    clock = 0; // 时钟信号
  //wire[31:0] read_data;// 从存储器读出的数据 就是mread_data
  
        caddress = 0;       // from alu_result in executs32
        memread= 0;                   // read memory, from control32
  //      Memwrite;                // write memory, from control32
        ioread= 0;                   // read IO, from control32
        iowrite= 0;                    // write IO, from control32
  //   [31:0] mread_data;        // data from memory
  //     [15:0] ioread_data;    // data from io,16 bits
        wdata= 0;                // the data from idecode32,that want to write memory or io
    //   wire[31:0] write_data;    // data to memory or I/O
  //  wire[31:0] address;       // address to mAddress and I/O
  //    wire LEDCtrl;                // LED CS
  //    wire SwitchCtrl;      
  
        reset= 1;                // 复位信号 
        ior= 0;                  //  从控制器来的I/O读，
  //      SwitchCtrl;        //  从memorio经过地址高端线获得的拨码开关模块片选
       ioread_data_switch= 0;      //从外设来的读数据，此处来自拨码开关
  //    wire[15:0] ioread_data;    // 将外设来的数据送给memorio
  
        led_clk= 0;                    // 时钟信号
        ledrst= 1;                     // 复位信号
        ledwrite= 0;                   // 写信号
   //   LEDCtrl;              // 从memorio来的，由低至高位形成的LED片选信号   !!!!!!!!!!!!!!!!!
       ledaddr= 0;                //  到LED模块的地址低端  !!!!!!!!!!!!!!!!!!!!
       ledwdata= 0;          //  写到LED模块的数据，注意数据线只有16根
  
        switclk= 0;                      //  时钟信号
        switrst= 1;                       //  复位信号
        switchcs= 0;                      //从memorio来的，由低至高位形成的switch片选信号  !!!!!!!!!!!!!!!!!
      switchaddr= 0;               //  到switch模块的地址低端  !!!!!!!!!!!!!!!
      switchread= 0;                    //  读信号
      switch_i= 0;        
      Instruction = 0;
      ALU_result = 0;
      Jal = 0;
      RegWrite = 0;
      MemtoReg = 0;
      RegDst = 0;
      opcplus4 = 0;
    #50
    reset = 0;
    ledrst = 0;
    switrst = 0;
    #150
    switch_i = 24'b111100001100001100001111;
    ioread = 1;
    switchread = 1;
    Memwrite = 1;
    caddress = 1;
    ALU_result = 1;
    #400
    
    end
    always #50 clock = ~clock;         
    
endmodule