module testbench(); //even though the testbench doesn't create any hardware, it still needs to be a module

timeunit 10ns;  // This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
    logic clk;
    
    logic gate_pc;
    logic gate_mdr;
    logic gate_alu; 
    logic gate_marmux;
    logic [3:0] ctrl;
    
    logic [15:0] pc_in;
    logic [15:0] mdr_in;
    logic [15:0] alu_in;
    logic [15:0] marmux_in;
    
    logic [15:0] out;
    logic [3:0] ctrl_out;


// Instantiating the DUT (Device Under Test)
// Make sure the module and signal names match with those in your design
    cpu_bus test_bus(.*);	

//logic       ans_1x;
//logic [7:0] ans_1a;
//logic [7:0] ans_1b;

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

    gate_pc = 1;
    gate_mdr = 0;
    gate_alu = 0;
    gate_marmux = 0;
    
    pc_in = 16'b0000000000000001;
    mdr_in = 16'b0000000000000010;
    alu_in = 16'b0000000000000011;
    marmux_in = 16'b0000000000000100;
    
    repeat (4) @(posedge clk);
    
	$finish(); //this task will end the simulation if the Vivado settings are properly configured

end
endmodule