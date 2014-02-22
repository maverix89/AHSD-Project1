`timescale 1ns / 1ps 
////////////////////////////////////////////////////////////////////////////////// 
//Company: Arizona State University 
// Engineer: <your name> 
// 
// Create Date: 01/17/2014 
// Design Name: Data memory 
// Module Name: Sequential Logic 
// Project Name: MIPS Processor 
// Target Devices: Xilinx Spartan 6 (XC6SLX16-3CSG324) 
// Tool versions: Xilinx ISE 14.6 
// Description: Stores the Data 
// RAM Size = 1024 x 32 
// Dependencies: 
// Revision 0.01 - File Created 
// Additional Comments: 
// 
////////////////////////////////////////////////////////////////////////////////// 
module SequentialLogic #(parameter ADDR_WIDTH = 10, DATA_WIDTH = 32)
	(clk, reset_b, 
	WriteRegister, 
	O, nextPC, 
	MemToReg, 
	RegWrite, 
	MemWrite, 
	Instruction, PC, ReadData1, ReadData2); 

	input wire clk; 
	input wire reset_b; 
	input wire [04:00] WriteRegister; 
	input wire [31:00] O; 
	input wire [31:00] nextPC; 
	input wire MemToReg; 
	input wire RegWrite; 
	input wire MemWrite; 		 
	
	output wire [31:00] Instruction; 
	output reg [31:00] PC; 
	output wire [31:00] ReadData1; 
	output wire [31:00] ReadData2; 
	
	reg [ADDR_WIDTH - 1:00] read_addr;
	//reg [DATA_WIDTH - 1:00] read_addr_dm;
	wire [DATA_WIDTH - 1:00] read_data;	  
	wire [DATA_WIDTH - 1:00] wr_data;
	// Instantiate the modules and wire it up using the Block Diagram as a guide.
	
	inst_mem i_inst_mem ( .read_addr (read_addr), .read_data (Instruction), .reset_b (reset_b));
	
	data_mem i_data_mem ( .read_addr (O), .write_addr (O), .write_en (MemWrite), .write_data (ReadData2),
	.read_data (read_data), .reset_b (reset_b));
	
	register_file i_register_file (.rd_reg1 (Instruction[25:21]), .rd_reg2 (Instruction[20:16]), .wr_reg (WriteRegister),
	.wr_data (wr_data), .reg_write (RegWrite), .rd_data1 (ReadData1), .rd_data2 (ReadData2), .clk (clk), .reset_b (reset_b));
	
	always @ (posedge clk)
		begin
			read_addr <= (nextPC >> 2); 
			PC <= nextPC;
		end
		
	assign wr_data = (Instruction [31:26] == 11'b001111) ? (Instruction [31:0] << 16) : MemToReg ? O : read_data;		
endmodule