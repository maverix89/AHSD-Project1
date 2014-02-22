module Data_Mem_tb();
// Declare inputs as regs and outputs as wires		  

reg 	[31:0] read_addr_reg, write_addr_reg;
reg		write_en_reg;
reg		[31:0] write_data_reg;
reg 	clk, reset_b;
wire [31:0] read_addr;
wire [31:0] write_addr;
wire [31:0] read_data;
wire [31:0]	write_data;
//reg [32 - 1:00] d_memory [1024- 1:00];

// Initialize all variables
initial begin        
	clk = 1;      				// initial value of clock
	reset_b = 1;       			// initial value of reset
//	#5  reset_b = 1;    			// Assert the reset
//	#20 reset_b = 0;
// 	#5  reset_b = 1;
	#120 $finish;      			// Terminate simulation
end

// Clock generator
initial forever 
  #5 clk = ~clk; // Toggle clock every 5 tick

	initial begin
		#20
		read_addr_reg = 32'b1;
		write_addr_reg = 32'b1;
		write_en_reg = 1'b0;
		write_data_reg = 32'b11111111111111111111111111111110;	  
		$display("mem: %32b", read_data);
		
		#17
		read_addr_reg = 32'b101;
		#3
		
		write_addr_reg = 32'b1;
		write_en_reg = 'b1;
		write_data_reg = 32'b11111111111111111111111111111101;
		$display("mem: %32b", read_data);
		
		#20
		read_addr_reg = 'd2;
		write_addr_reg = 'd2;
		write_en_reg = 'b0;
		write_data_reg = 32'b11111111111111111111111111111011;
	
		#20 
		read_addr_reg = 'b1;
		write_addr_reg = 'b1;
		write_en_reg = 'b0;
		write_data_reg = 32'b11111111111111111111111111111110;
		
		#20
		read_addr_reg = 'b1;
		write_addr_reg = 'd2;
		write_en_reg = 'b1;
		write_data_reg = 32'b11111111111111111111111111111101;
	
		#20
		read_addr_reg = 'd2;
		write_addr_reg = 'd2;
		write_en_reg = 'b0;
		write_data_reg = 32'b11111111111111111111111111111011;
		
	end

	assign	read_addr = read_addr_reg;
	assign	write_addr = write_addr_reg;
	assign	write_en = write_en_reg;
	assign	write_data = write_data_reg;
	

data_mem dmem_1 (
		.read_addr (read_addr), 
		.write_addr (write_addr), 
		.write_en (write_en), 
		.write_data (write_data), 
		.read_data (read_data), 
		.clk (clk), 
		.reset_b(reset_b)
);

endmodule