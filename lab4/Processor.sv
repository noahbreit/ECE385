//4-bit logic processor top level module
//for use with ECE 385 Fall 2023
//last modified by Satvik Yellanki


//Always use input/output logic types when possible, prevents issues with tools that have strict type enforcement

module Processor (
	input  logic        Clk,     // Internal
	input  logic        Reset_Load_Clear,
	input  logic        Run,
	input  logic [7:0]  SW,       
	
	output logic        Xval,    // DEBUG
	output logic [7:0]  Aval,    // DEBUG
	output logic [7:0]  Bval,    // DEBUG
	output logic [7:0]  hex_seg, // Hex display control
	output logic [3:0]  hex_grid // Hex display control
); 

    //// local logic variables go here
    // DEBOUNCED INPUT
	logic Reset_Load_Clear_S;
	logic Run_S;
	logic [7:0] SW_S;
	
	// CONTROL UNIT
	logic Shift;
	logic Clr_Ld;
	logic Add;
	logic Sub;
	
	// REGISTER UNIT
	logic       M;
    logic       X;  
	logic [7:0] A; 
	logic [7:0] B; 
	logic       D_X;
	logic [7:0] D_A;
	logic [7:0] D_B;
	
	// ADDER UNIT
	logic [8:0] Adder_Ain;
	logic [8:0] Adder_SWin;
	logic [8:0] Adder_out;
	 
	 
//We can use the "assign" statement to do simple combinational logic
	// CONTROL UNIT
	
	// REGISTER UNIT
	assign M = B[0];
	
	// ADDER UNIT
    assign Adder_Ain  = {A[7], A};
    assign Adder_SWin = {SW_S[7], SW_S};
    assign Adder_out  = {D_X, D_A};
    
    // HEX DISPLAY
	assign Aval  = A;
	assign Bval  = B;

//Instantiation of modules here
	register_unit reg_unit (
	    .Reset_Load_Clear  (Reset_Load_Clear_S),
		.Clk          (Clk),
		.Shift        (Shift),
		.M            (M),
		
		.D_X          (D_X),
		.D_A          (D_A),
		.D_B          (SW_S),
		
		.X            (X),
		.A            (A),
		.B            (B)
	);
                    
    adder_unit adder_unit (
        .Sub        (Sub),
        .a          (Adder_Ain),
        .b          (Adder_SWin),
        .s          (Adder_out)
	);

	control control_unit (
	    .Reset_Load_Clear  (Reset_Load_Clear_S),
		.Run        (Run_S),
		.Clk        (Clk),
		.M          (M),
		
		.Clr_Ld     (Clr_Ld),
		.Shift      (Shift),
		.Add        (Add),
		.Sub        (Sub)
	);
                    
//When you extend to 8-bits, you will need more HEX drivers to view upper nibble of registers, for now set to 0
	HexDriver HexA (
		.clk        (Clk),
		.reset      (Reset_Load_Clear_S),

		.in         ({A[7:4], A[3:0], B[7:4], B[3:0]}),
		.hex_seg    (hex_seg),
		.hex_grid   (hex_grid)
	);
                            
//Input synchronizers required for asynchronous inputs (in this case, from the switches)
//These are array module instantiations
//Note: S stands for SYNCHRONIZED, H stands for active HIGH, in addition in synthesis they are also debounced

	sync_debounce button_sync [1:0] (
		.Clk  (Clk),

		.d    ({Reset_Load_Clear, Run}),
		.q    ({Reset_Load_Clear_S, Run_S})
	);

	sync_debounce SW_sync [7:0] (
		.Clk  (Clk), 

		.d    (SW), 
		.q    (SW_S)
	);
	  
endmodule
