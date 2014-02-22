module regfile_tb();
// Declare inputs as regs and outputs as wires
reg clk, reset_b;
wire [4:0] rd_reg1, rd_reg2, wr_reg;
wire [31:0] rd_data1, rd_data2;
reg [4:0] rd_reg1_reg, rd_reg2_reg,	wr_reg_reg;
reg [31:0] wr_data;
reg reg_write;
// Connect DUT to test begin
	register_file reg_file1(
	rd_reg1, 
	rd_reg2, 
	wr_reg, 
	wr_data, 
	reg_write, 
	rd_data1, 
	rd_data2, 
	clk, 
	reset_b );
// Initialize all variables
initial begin        
	clk = 'd1;      				// initial value of clock
	reset_b = 'd1;       			// initial value of reset 
	rd_reg1_reg = 'd0;
	rd_reg2_reg = 'd1;
	wr_reg_reg = 'd2;
//	#5  reset_b = 1;    			// Assert the reset
//	#20 reset_b = 0;
// 	#5  reset_b = 1; 
	#70 reg_write = 'd1;
	#120 reset_b = 'd0;
		reg_write = 'd0;
	#3 reset_b = 'd1;
	rd_reg1_reg = 'd0;
	rd_reg2_reg = 'd1;
	wr_reg_reg = 'd2; 
	#70 reg_write = 'd1;
	#120 $finish;       			// Terminate simulation
	
end

// Clock generator
always begin
  #5 clk = ~clk; // Toggle clock every 5 ticks
end

always @(posedge clk)
	begin  
	rd_reg1_reg = rd_reg1_reg + 1;
	rd_reg2_reg = rd_reg2_reg + 1;
	wr_reg_reg = wr_reg_reg + 1;   
	wr_data = 10;
	end

assign rd_reg1 = rd_reg1_reg;
assign rd_reg2 = rd_reg2_reg;
assign wr_reg = wr_reg_reg;



endmodule