`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module control32(Opcode,Function_opcode,Alu_resultHigh,
Jrn,RegDST,ALUSrc,
MemorIOtoReg,
//MemtoReg,
RegWrite,
MemRead,
MemWrite,
IORead,IOWrite,
Branch,nBranch,Jmp,Jal,I_format,Sftmd,ALUOp);
    input[5:0]   Opcode;            // 来自取指单元instruction[31..26]
    input[5:0]   Function_opcode;  	// 来自取指单元r-类型 instructions[5..0]
    input[21:0] Alu_resultHigh; // 来自执行单元 Alu_Result[31..10] 
    output       MemorIOtoReg;  // 为 1 表明需要从存储器或 I/O 读数据到寄存器 
    output       Jrn;         	 // 为1表明当前指令是jr
    output       RegDST;          // 为1表明目的寄存器是rd，否则目的寄存器是rt
    output       ALUSrc;          // 为1表明第二个操作数是立即数（beq，bne除外）
    //output       MemtoReg;   	//  为1表明需要从存储器读数据到寄存器
    output       RegWrite;   	//  为1表明该指令需要写寄存器
    output       MemRead; // 为 1 表明是存储器读 
    output       MemWrite;   	//  为1表明该指令需要写存储器
    output       IORead; // 为 1 表明是 I/O 读 
    output       IOWrite; // 为 1 表明是 I/O 写 
    output       Branch;    	//  为1表明是Beq指令
    output       nBranch;   	//  为1表明是Bne指令
    output       Jmp;        	//  为1表明是J指令
    output       Jal;        	//  为1表明是Jal指令
    output       I_format;  	//  为1表明该指令是除beq，bne，LW，SW之外的其他I-类型指令
    output       Sftmd;     	//  为1表明是移位指令
    output[1:0]  ALUOp;	        //  是R-类型或I_format=1时位1为1, beq、bne指令则位0为1
   
    wire Jmp,I_format,Jal,Branch,nBranch;
    wire R_format;        // 为1表示是R-类型指令
    wire Lw;               // 为1表示是lw指令
    wire Sw;               // 为1表示是sw指令

    
   
    assign R_format = (Opcode==6'b000000)? 1'b1:1'b0;    	//--00h 
    assign RegDST = R_format && (~I_format && ~Lw);                          //说明目标是rd，否则是rt

   assign I_format = (Opcode[5:3] == 3'b001) ? 1'b1:1'b0;
   assign Lw = (Opcode==6'b100011)? 1'b1:1'b0;
   assign Jal = (Opcode==6'b000011)? 1'b1:1'b0;
   assign Jrn = (Opcode==6'b000000 && Function_opcode == 6'b001000)? 1'b1:1'b0;
   assign RegWrite = (I_format || Lw || Jal  || R_format) && ~Jrn;

   assign Sw = (Opcode == 6'b101011)?1'b1:1'b0;
   assign ALUSrc = (I_format || Lw || Sw);
   assign Branch =  (Opcode==6'b000100)? 1'b1:1'b0;
   assign nBranch =  (Opcode==6'b000101)? 1'b1:1'b0;
   assign Jmp=  (Opcode==6'b000010)? 1'b1:1'b0;
    
   assign MemWrite = (Sw  == 1'b1 && (Alu_resultHigh[21:0] != 22'b1111111111111111111111))?1'b1:1'b0;
   assign MemRead = (Lw  == 1'b1&& (Alu_resultHigh[21:0] != 22'b1111111111111111111111))?1'b1:1'b0;
   assign IORead = (Lw  == 1'b1&& (Alu_resultHigh[21:0] == 22'b1111111111111111111111))?1'b1:1'b0;
   assign IOWrite = (Sw  == 1'b1&& (Alu_resultHigh[21:0] == 22'b1111111111111111111111))?1'b1:1'b0;
   assign MemorIOtoReg = IORead || MemRead;
  // assign MemtoReg = Lw;
   assign Sftmd = (Opcode == 6'b000000 && Function_opcode[5:3] == 3'b000)? 1'b1:1'b0;
  
    assign ALUOp = {(R_format || I_format),(Branch || nBranch)}; 
     // 是R－type或需要立即数作32位扩展的指令1位为1,beq、bne指令则0位为1
endmodule