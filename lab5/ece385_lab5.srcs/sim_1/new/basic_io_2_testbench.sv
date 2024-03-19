module basic_io_2_testbench(); //even though the testbench doesn't create any hardware, it still needs to be a module

timeunit 10ns;  // This is the amount of time represented by #1 
timeprecision 1ns;

`define LOOP_NUM 2
`define LED_A   (16'h1818)
`define LED_B   (16'h8181)
`define PAUSE_STATE (16'h0007)

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
logic        clk;
logic        reset;

logic        run_i;
logic        continue_i;
logic [15:0] sw_i;

// DEBUG DEBUG
//logic [4:0]  state_out;
//logic [3:0]  ctrl_out;
logic [15:0] pc_out;
//logic [15:0] ir_out;
logic [15:0] data_bus_out;
//logic [15:0] marmux_out;
//logic [15:0] sr1_out;
//logic        addr1mux;
//logic [1:0]  addr2mux;
    
logic [15:0] sram_rdata;
logic [15:0] sram_wdata;
logic [15:0] sram_addr;
logic sram_mem_ena;
logic sram_wr_ena;
// DEBUG DEBUG

logic [15:0] led_o;
logic [7:0]  hex_seg_left;
logic [3:0]  hex_grid_left;
logic [7:0]  hex_seg_right;
logic [3:0]  hex_grid_right;

// Instantiating the DUT (Device Under Test)
// Make sure the module and signal names match with those in your design
//cpu test_cpu(.*);
processor_top test_processor(.*);


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
    var i;
    reset = 0;
    run_i = 0;
    continue_i = 0;
    sw_i = 16'h0006;       // BASIC_IO_1 INPUT IS PC <= 0x0003
    
    repeat (4) @(posedge clk);
    
    reset <= 1;
    
    repeat (4) @(posedge clk);
    
    reset <= 0;
    
    repeat (4) @(posedge clk);
    
    run_i <= 1;
    
    repeat (32) @(posedge clk); // WAIT FOR BASIC_IO_TEST_1 TO BE FETCHED
    
    run_i <= 0;
    
    wait (pc_out == `PAUSE_STATE);
    
    repeat (32) @(posedge clk);
    
    continue_i <= 1;
    
    repeat (32) @(posedge clk);  // WAIT FOR CONTINUE TO RESOLVE...
    
    continue_i <= 0;
    
    repeat (32) @(posedge clk);  // BEGIN BASIC_IO_TEST_1 
    
    sw_i <= `LED_A;
         
    repeat (32) @(posedge clk);
    
    continue_i <= 1;
    
    repeat (32) @(posedge clk);  // WAIT FOR CONTINUE TO RESOLVE...
    
    continue_i <= 0;
    
    repeat (32) @(posedge clk);
    
    sw_i <= `LED_B;
    
    repeat (128) @(posedge clk); // NEW SWITCH INPUT SHOULD NOT CHANGE HEX_DISPLAY...
    
	$finish(); //this task will end the simulation if the Vivado settings are properly configured

end
endmodule
