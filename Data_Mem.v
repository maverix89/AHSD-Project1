`timescale 1ns / 1ps 
////////////////////////////////////////////////////////////////////////////////// 
// Company: Arizona State University 
// Engineer: <your name> 
// 
// Create Date: 01/17/2014 
// Design Name: Data memory 
// Module Name: data_mem 
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
	module data_mem #(parameter MEM_DEPTH = 1024, WIDTH = 32)
		(read_addr, 
		write_addr, 
		write_en, 
		write_data, 
		read_data, 
		clk, 
		reset_b ); 
	input wire  [WIDTH - 1:00] read_addr; 
	input wire  [WIDTH - 1:00] write_addr; 
	input wire  write_en;
	input wire  [WIDTH - 1:00] write_data; 
	output wire [WIDTH - 1:00] read_data; 
	input wire  clk; 
	input wire  reset_b; 			  
	
	// Declaration of Data_memory	
	reg [WIDTH - 1:00] d_memory [MEM_DEPTH - 1:00]; 
	reg [31:0] i;

 	//	Initializing Data memory
	initial	
		begin
		$readmemh("d_memory.txt", d_memory);
		$display("mem11: %32b", d_memory[5]);
		end
	//	Reading from Data memory: Asynchronous operation - independent of clock
	assign read_data = d_memory[read_addr];	 
	
	//	Writing to Data memory: Synchronous operation - dependent on clk and write_en
	always @(posedge clk)
		if (write_en) d_memory[write_addr] <= write_data;
	
	//	Reset operation: Asynchronous - resets all data memory locations to zero
	always @(negedge reset_b)
			if (~reset_b) 
			begin
				for (i = 0;i < (MEM_DEPTH - 1);i = i + 1)
					d_memory[i] <= 'd0;
			end	
		
endmodule