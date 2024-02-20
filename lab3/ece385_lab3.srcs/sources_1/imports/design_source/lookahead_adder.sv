module lookahead_adder (
	input  logic  [15:0] a, 
    input  logic  [15:0] b,
	input  logic         cin,
	
	output logic  [15:0] s,
	output logic         cout
);

	/* TODO
		*
		* Insert code here to implement a CLA adder.
		* Your code should be completly combinational (don't use always_ff or always_latch).
		* Feel free to create sub-modules or other files. */
		logic C0, C4, C8, C12;
		logic Pg0,Pg4,Pg8,Pg12;
		logic Gg0,Gg4,Gg8,Gg12;
		
		Carry_Lookahead_Unit CLU0(.A(a[3:0]), .B(b[3:0]), .c_in(cin), .s(s[3:0]),  .PG(Pg0), .GG(Gg0));
		Carry_Lookahead_Unit CLU1(.A(a[7:4]), .B(b[7:4]), .c_in(C4), .s(s[7:4]),  .PG(Pg4), .GG(Gg4));
		Carry_Lookahead_Unit CLU2(.A(a[11:8]), .B(b[11:8]), .c_in(C8), .s(s[11:8]),  .PG(Pg8), .GG(Gg8));
		Carry_Lookahead_Unit CLU3(.A(a[15:12]), .B(b[15:12]), .c_in(C12), .s(s[15:12]),  .PG(Pg12), .GG(Gg12));
		
		assign C0 = cin;
		assign C4 = Gg0 | (C0&Pg0); 
		assign C8 = Gg4 | (Gg0&Pg4) | (C0&Pg0&Pg4);
		assign C12 = Gg8 | (Gg4&Pg8) |(Gg0&Pg8&Pg4) | (C0&Pg8&Pg4&Pg0);
        assign cout = Gg12 | (Gg8&Pg12) | (Gg4&Pg12&Pg8) | (Gg0&Pg12&Pg8&Pg4) | (C0&Pg12&Pg8&Pg4&Pg0);
        
         
endmodule
