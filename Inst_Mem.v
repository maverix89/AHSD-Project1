//////////////////////////////////////////////////////////////////////////////////
// Company: Arizona State University
// Engineer: <your name>
//
// Create Date: 01/17/2014
// Design Name: Instruction memory
// Module Name: inst_mem
// Project Name: MIPS Processor
// Target Devices: Xilinx Spartan 6 (XC6SLX16-3CSG324)
// Tool versions: Xilinx ISE 14.6
// Description: Stores the Program (Collection of instructions)
// RAM Size = 1024 x 32
// Dependencies:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
	module inst_mem #(parameter DATA_DEPTH = 1024, ADDR_WIDTH = 10, DATA_WIDTH = 32)
	(	read_addr,
		read_data,
		reset_b,
		clk
	);
	input wire [ADDR_WIDTH - 1:00] read_addr;
	output reg [DATA_WIDTH - 1:00] read_data;
	input wire clk;
	input wire reset_b;
	reg [DATA_WIDTH - 1:00] i_memory [DATA_DEPTH - 1:00];
	reg [31:0] i;

	initial		
		$readmemh("Instr_mem.txt",i_memory);
		/*
		//R-type Instructions
	i_memory[1] = {6'b000000,5'b00000,5'b00000,5'b00000,5'b00000,6'b100011};
	i_memory[2] = {6'b000000,5'b00000,5'b00000,5'b00000,5'b00000,6'b100001};
	i_memory[3] = {6'b000000,5'b00000,5'b00000,5'b00000,5'b00000,6'b100111};
	i_memory[4] = {6'b000000,5'b00000,5'b00000,5'b00000,5'b00000,6'b101010};
	i_memory[5] = {6'b000000,5'b00000,5'b00000,5'b00000,5'b00000,6'b000000};
	i_memory[6] = {6'b000000,5'b00000,5'b00000,5'b00000,5'b00000,6'b000010};

	//I-type Instructions
   	i_memory[7] = {6'b001001,5'b00000,5'b00000,16'b0000000000000000};
	i_memory[8] = {6'b001100,5'b00000,5'b00000,16'b0000000000000000};
	i_memory[9] = {6'b001101,5'b00000,5'b00000,16'b0000000000000000};
	i_memory[10] = {6'b000100,5'b00000,5'b00000,16'b0000000000000000};
	i_memory[11] = {6'b000101,5'b00000,5'b00000,16'b0000000000000000};
	i_memory[12] = {6'b100011,5'b00000,5'b00000,16'b0000000000000000};
	i_memory[13] = {6'b101011,5'b00000,5'b00000,16'b0000000000000000};
	
	//J-type Instructions
	i_memory[14] = {6'b000010,26'b00000000000000000000000000};
	*/
	
// Write the wrapper for the memory and initialize it	 

always @(read_addr, negedge reset_b)
	begin
		if (~reset_b) 
			for (i = 0;i < (DATA_DEPTH - 1);i = i + 1)
				i_memory[i] <= 'd0;	
		else
			read_data = i_memory[read_addr];
				
	end
	
endmodule