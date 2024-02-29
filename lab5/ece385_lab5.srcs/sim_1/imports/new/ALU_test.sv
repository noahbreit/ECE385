module ALU_test();



timeunit 10ns;  // This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
logic        clk;
logic [15:0] A;
logic [15:0] B;
logic [1:0] ALUK;

logic [15:0] ALU_out;
// DEBUG DEBUG



// Instantiating the DUT (Device Under Test)
// Make sure the module and signal names match with those in your design
//cpu test_cpu(.*);
ALU ALU_test(.*);


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
    A = 16'b1010101111001101;
    B = 16'b0001001000110100;
    ALUK = 2'b10;
    
    repeat (4) @(posedge clk)
    
	$finish(); //this task will end the simulation if the Vivado settings are properly configured

end
endmodule