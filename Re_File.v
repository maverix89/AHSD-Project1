`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////// 
// Company: Arizona State University 
// Engineer: <your name> // 
// Create Date: 01/17/2014 
// Design Name: Registers 
// Module Name: register_file 
// Project Name: MIPS Processor 
// Target Devices: Xilinx Spartan 6 (XC6SLX16-3CSG324) 
// Tool versions: Xilinx ISE 14.6 
// Description: Register set of the CPU: R1, R2 and RD. 
// 
// Dependencies: 
// 
// Revision: 
// Revision 0.01 - File Created 
// Additional Comments: 
// ////////////////////////////////////////////////////////////////////////////////// 
module register_file #(parameter REGISTER_DEPTH = 32, ADDR_WIDTH = 5, DATA_WIDTH = 32) 
	(rd_reg1, 
	rd_reg2, 
	wr_reg, 
	wr_data, 
	reg_write, 
	rd_data1, 
	rd_data2, 
	clk, 
	reset_b ); 
	input wire  [ADDR_WIDTH - 1:00] rd_reg1; 
	input wire  [ADDR_WIDTH - 1:00] rd_reg2; 
	input wire  [ADDR_WIDTH - 1:00] wr_reg; 
	input wire  [DATA_WIDTH - 1:00] wr_data; 
	input wire  reg_write;
	output wire [DATA_WIDTH - 1:00] rd_data1; 
	output wire [DATA_WIDTH - 1:00] rd_data2; 
	input wire  clk; 
	input wire  reset_b;
	
	// Declaration of Register_file
	reg [DATA_WIDTH - 1:00] r_file [REGISTER_DEPTH - 1:00];
	reg [31:0] i; //counter
	
	//	Initializing Register file
	initial
		$readmemh("regis.txt", r_file);
	
/*	always @(rd_reg1,reset_b,rd_reg2)
		begin
		rd_data1_reg <= r_file[rd_reg1];
		rd_data2_reg <= r_file[rd_reg2];
		end
*/

	//	Reading from Register file: Asynchronous operation - independent of clock
	assign rd_data1 = r_file[rd_reg1];
	assign rd_data2 = r_file[rd_reg2];

	//	Write to Register file: Synchronous operation - dependent on clock and reg_write signal
	always @(posedge clk)
		if(reg_write) r_file[wr_reg] <= wr_data;
	
	//	Reset_b signal:	Asynchronous operation - Will set all register locations to zero
	always @(negedge reset_b)
		begin
		if (~reset_b)
			begin
			for (i = 0;i < (REGISTER_DEPTH - 1);i = i + 1)
				r_file[i] <= 'd0; 
			end
		end
			
endmodule