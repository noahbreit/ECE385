module testbench(); //even though the testbench doesn't create any hardware, it still needs to be a module

timeunit 10ns;  // This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
logic 		clk;
logic		reset;
logic 		run_i; // _i stands for input
logic [15:0] sw_i;

// DEBUG DEBUG
logic [15:0] out_val;
// DEBUG DEBUG

logic 		sign_led;
logic [7:0]  hex_seg_a;
logic [3:0]  hex_grid_a;
logic [7:0]  hex_seg_b;
logic [3:0]  hex_grid_b;


// To store expected results
logic [15:0] ans_0;
logic [15:0] ans_1;
logic [15:0] ans_2;

// Instantiating the DUT (Device Under Test)
// Make sure the module and signal names match with those in your design
adder_toplevel adder_toplevel (.*);


initial begin: CLOCK_INITIALIZATION
	clk = 1'b1;
end 

// Toggle the clock
// #1 means wait for a delay of 1 timeunit, so simulation clock is 50 MHz technically 
// half of what it is on the FPGA board 

// Note: Since we do mostly behavioral simulations, timing is not accounted for in simulation, however
// this is important because we need to know what the time scale is for how long to run
// the simulation
always begin : CLOCK_GENERATION
	#1 clk = ~clk;
end

// Testing begins here
// The initial block is not synthesizable on an FPGA
// Everything happens sequentially inside an initial block
// as in a software program

// Note: Even though the testbench happens sequentially,
// it is recommended to use non-blocking assignments for most assignments because
// we do not want any dependencies to arise between different assignments in the 
// same simulation timestep. The exception is for reset, which we want to make sure
// happens first. 
initial begin: TEST_VECTORS
    ans_1 = (16'h2 + 16'h2); // Expected result of 1st cycle
	reset = 1;		// Toggle Reset (use blocking operator), because we want to have this happen 'first'
	
	run_i <= 0;     
	
	sw_i <= 16'h0002;          // LOAD INITIAL VALUE

	repeat (4) @(posedge clk); //each @(posedge Clk) here means to wait for 1 clock edge, so this waits for 3 clock edges

	reset <= 0;

	@(posedge clk);
	
	run_i <= 1;	// Toggle run_i

	repeat (4) @(posedge clk); // Wait 4 cycles to let debouncer detect button
	
	run_i <= 0;
	
	repeat (4) @(posedge clk); // Wait 4 cycles
	
	run_i <= 1; // Toggle run_i

	repeat (4) @(posedge clk);
	
	run_i <= 0; // Toggle run_i;
	
	repeat (12) @(posedge clk);
	
	assert (out_val == ans_0) else $display("1st cycle A ERROR: out_val is %h", out_val);
	
	// reset = 1
	
	ans_1 = (16'h4 + 16'hFFFB); // Expected result of 1st cycle
	
	run_i <= 0;     
	
	sw_i <= 16'hFFFB;          // LOAD INITIAL VALUE

	repeat (4) @(posedge clk); //each @(posedge Clk) here means to wait for 1 clock edge, so this waits for 3 clock edges

	// reset <= 0;

	@(posedge clk);
	
	run_i <= 1;	// Toggle run_i

	repeat (4) @(posedge clk); // Wait 4 cycles to let debouncer detect button
	
	run_i <= 0;
	
	repeat (4) @(posedge clk); // Wait 4 cycles
	
	run_i <= 1; // Toggle run_i

	repeat (4) @(posedge clk);
	
	run_i <= 0; // Toggle run_i;
	
	repeat (12) @(posedge clk);
		
	//These are called 'immediate' assertions, because they assert if a condition is true
	//at the time of execution.
	
	assert (out_val == ans) else $display("1st cycle A ERROR: out_val is %h", out_val);
	assert (out_val == ans) else $display("1st cycle A ERROR: out_val is %h", out_val);
	
	$finish(); //this task will end the simulation if the Vivado settings are properly configured

end
endmodule
