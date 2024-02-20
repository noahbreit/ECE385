module testbench(); //even though the testbench doesn't create any hardware, it still needs to be a module

timeunit 10ns;  // This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
logic        Reset_Load_Clear;
logic        Run;
logic [7:0]  SW;

// DEBUG DEBUG
logic [4:0]  State_val;
logic        Clr_Ld_val;
logic        Shift_val;
logic        Add_val;
logic        Sub_val;
logic        Load_val;
// DEBUG DEBUG
	
logic        Mval;    // DEBUG
logic        Xval;    // DEBUG
logic [8:0]  Adder_out_val;
logic [7:0]  Aval;    // DEBUG
logic [7:0]  Bval;    // DEBUG
logic        Clk;     // Internal
logic [7:0]  hex_seg; // Hex display control
logic [3:0]  hex_grid; // Hex display control


// Instantiating the DUT (Device Under Test)
// Make sure the module and signal names match with those in your design
Processor processor0 (.*);	

//logic       ans_1x;
//logic [7:0] ans_1a;
//logic [7:0] ans_1b;

initial begin: CLOCK_INITIALIZATION
	Clk = 1'b1;
end 

// Toggle the clock
// #1 means wait for a delay of 1 timeunit, so simulation clock is 50 MHz technically 
// half of what it is on the FPGA board 

// Note: Since we do mostly behavioral simulations, timing is not accounted for in simulation, however
// this is important because we need to know what the time scale is for how long to run
// the simulation
always begin : CLOCK_GENERATION
	#1 Clk = ~Clk;
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
    Run = 0;
    SW = 8'hC5;               // LOAD INIT B VAL -59
//    SW = 8'h3B;             // LOAD INIT B VAL +59
    
    repeat (3) @(posedge Clk); //each @(posedge Clk) here means to wait for 1 clock edge, so this waits for 3 clock edges

	Reset_Load_Clear = 1;		// Toggle Reset (use blocking operator), because we want to have this happen 'first'

	repeat (3) @(posedge Clk); //each @(posedge Clk) here means to wait for 1 clock edge, so this waits for 3 clock edges

	Reset_Load_Clear <= 0;

	@(posedge Clk);
	
//	SW <= 8'h07;      // LOAD INIT A VAL 7
	SW <= 8'hF9;            // LOAD INIT A VAL -7

	repeat (3) @(posedge Clk); // Wait 4 cycles to let debouncer detect button

    Run <= 1;
    
	@(posedge Clk);
	
	repeat (3) @(posedge Clk);
	
	Run <= 0;

	repeat (4) @(posedge Clk);
	
	repeat (4) @(posedge Clk);

	repeat (4) @(posedge Clk);
	
	repeat (4) @(posedge Clk);
		
	repeat (4) @(posedge Clk);
			
    repeat (4) @(posedge Clk);
				
	repeat (4) @(posedge Clk);

    repeat (4) @(posedge Clk);
			
    repeat (4) @(posedge Clk);
				
	repeat (4) @(posedge Clk);

    //ans_1x = (1'b0 ^ 1'b1);
	//ans_1a = ((8'h07 * 8'hC5) & 8'hF0); // Expected result of 1st Operation
    //ans_1b = ((8'h07 * 8'hC5) & 8'h0F); 
	//These are called 'immediate' assertions, because they assert if a condition is true
	//at the time of execution.
	//assert (Xval == ans_1x) else $display("1st cycle X ERROR: Xval is %h", Xval);
	//assert (Aval == ans_1a) else $display("1st cycle A ERROR: Aval is %h", Aval);
	//assert (Bval == ans_1b) else $display("1st cycle B ERROR: Bval is %h", Bval);

	$finish(); //this task will end the simulation if the Vivado settings are properly configured

end
endmodule
