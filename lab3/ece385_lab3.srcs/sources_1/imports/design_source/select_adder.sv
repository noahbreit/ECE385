module select_adder (
	input  logic  [15:0] a, 
    input  logic  [15:0] b,
	input  logic         cin,
	
	output logic  [15:0] s,
	output logic         cout
);

	/* TODO
		*
		* Insert code here to implement a CSA adder.
		* Your code should be completly combinational (don't use always_ff or always_latch).
		* Feel free to create sub-modules or other files. */
	
	/*
     * MODULE_A --> [3:0]
     * MODULE_B --> [7:4]
     * MODULE_C --> [11:8]
     * MODULE_D --> [15:12] 
     */
    logic cout_a, cout_b, cout_c;
//    logic cout_d;
    
	// MODULE_A
	ripple_adder4 module_a (
	   .a(a[3:0]),
	   .b(b[3:0]),
	   .cin(cin),
	   .s(s[3:0]),
	   .cout(cout_a)
	);
	
	// MODULE_B
	select_adder4 module_b (
	   .a(a[7:4]),
	   .b(b[7:4]),
	   .cin(cout_a),
	   .s(s[7:4]),
	   .cout(cout_b)
	);
	
	// MODULE_C
	select_adder4 module_c (
	   .a(a[11:8]),
	   .b(b[11:8]),
	   .cin(cout_b),
	   .s(s[11:8]),
	   .cout(cout_c)
	);
	
	// MODULE_D
	select_adder4 module_d (
	   .a(a[15:12]),
	   .b(b[15:12]),
	   .cin(cout_c),
	   .s(s[15:12]),
	   .cout(cout)
	);
	
	// FIX COUT OUTPUT
//	assign cout = cout_d;

endmodule
