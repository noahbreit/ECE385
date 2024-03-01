`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/29/2024 11:49:36 PM
// Design Name: 
// Module Name: testbench_reg_file
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench_reg_file();

timeunit 10ns;  // This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
logic           clk;
logic           reset;

logic [15:0]    din;
    
logic [2:0]     dr;
logic           load;
logic [2:0]     sr2_in;
logic [2:0]     sr1_in;

logic [15:0]    sr2_out;    // OUTPUT
logic [15:0]    sr1_out;    // OUTPUT

////////////////////////////////////////////////////////////////////////

lc3_reg_file test_reg_file (.*);

initial begin: CLOCK_INITIALIZATION
	clk = 1'b1;
end 

always begin : CLOCK_GENERATION
	#1 clk = ~clk;
end

////////////////////////////////////////////////////////////////////////

initial begin: TEST_VECTORS
reset = 1;
din = 0;
dr = 'x;
load = 0;
sr2_in = 'x;
sr1_in = 'x;

repeat (4) @(posedge clk)

reset <= 0;

repeat (4) @(posedge clk)

// LOAD R0 with #0
dr <= 0;
din <= 0;
load <= 1;
// SCOPE R0
sr2_in <= 0;
sr1_in <= 0;

repeat (4) @(posedge clk)

load <= 0;
sr2_in <= 'x;
sr1_in <= 'x;

repeat (4) @(posedge clk)

// LOAD R1 with xFFFF
dr <= 1;
din <= 16'hFFFF;
load <= 1;
// SCOPE R1
sr2_in <= 3'b001;
sr1_in <= 3'b001;

repeat (4) @(posedge clk)

load <= 0;
sr2_in <= 'x;
sr1_in <= 'x;

repeat (4) @(posedge clk)

$finish();
end
endmodule
