module ripple_adder (
	input  logic  [8:0] a, 
    input  logic  [8:0] b,
	input  logic         cin,
	
	output logic  [8:0] s,
	output logic         cout
);

	/* TODO
		*
		* Insert code here to implement a ripple adder.
		* Your code should be completly combinational (don't use always_ff or always_latch).
		* Feel free to create sub-modules or other files. */
	
	// INIT LOCAL VARS
    logic [9:0] c_arr;
    assign c_arr[0] = cin;
    assign c_arr[8] = cout;
    
    // INIT FULL ADDER ARR
    genvar i;
    generate       
    for (i=0; i<9; i=i+1) 
        begin
            full_adder fa_unit(
                .a(a[i]),
                .b(b[i]),
                .cin(c_arr[i]),
                .s(s[i]),
                .cout(c_arr[i+1])
            );
        end
    endgenerate
    
endmodule