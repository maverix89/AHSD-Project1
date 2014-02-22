module imem_tb();
// Declare inputs as regs and outputs as wires
reg clk, reset_b;
wire [9:0] read_addr;
reg [9:0] read_addr_reg;
wire [31:0] read_data;

// Initialize all variables
initial begin        
	$display ("clk reset counter");	
	$monitor ("%b   %b     %32b", clk, reset_b, read_data);
	clk = 1;      				// initial value of clock
	reset_b = 0;       			// initial value of reset
	read_addr_reg = 'b0;
	#5 reset_b = 1;    			// Assert the reset
	#20 reset_b = 0;
 	#5 reset_b = 1;
	read_addr_reg = 'b0;
	#50 $finish;      			// Terminate simulation
end

// Clock generator
always begin
  #5 clk = ~clk; // Toggle clock every 5 ticks
end

always @(posedge clk)
	read_addr_reg = read_addr_reg + 1;

assign read_addr = read_addr_reg;

// Connect DUT to test begin
inst_mem imem_1 (
read_addr,
read_data,
reset_b,
clk
);

endmodule