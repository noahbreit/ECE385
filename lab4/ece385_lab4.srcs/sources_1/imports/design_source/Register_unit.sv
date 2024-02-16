module register_unit (
	input  logic       Clk, 
	input  logic       Reset_Load_Clear,
	input  logic       Clr_Ld,
	input  logic       Shift,
	input  logic       Add,
	input  logic       Sub,
	input  logic       M,

    input  logic       D_X,             
	input  logic [7:0] D_A,
	input  logic [7:0] D_B,
	
	output logic       X,
	output logic [7:0] A,
	output logic [7:0] B
);
    // INTERNAL
    logic Load;
    logic Reset;
    logic X_SH;
    logic A_SH;
    
    
    // ASSIGN
    assign Load = (M & (Add | Sub));
    assign Reset = (Reset_Load_Clear | Clr_Ld);

    reg_1 reg_X (
        .Clk            (Clk), 
		.Reset          (Reset),

		.Shift_In       (1'b0),   // PULL LOW
		.Load           (Load), 
		.Shift_En       (Shift),
		.D              (D_X),

		.Shift_Out      (X_SH),
		.Data_Out       (X)
	);
    
    reg_8 reg_A (
		.Clk            (Clk), 
		.Reset          (Reset),

		.Shift_In       (X_SH), 
		.Load           (Load), 
		.Shift_En       (Shift),
		.D              (D_A),

		.Shift_Out      (A_SH),
		.Data_Out       (A)
	);

	reg_8 reg_B (
		.Clk            (Clk), 
		.Reset          (1'b0),   // PULL LOW

		.Shift_In       (A_SH), 
		.Load           (Reset_Load_Clear), 
		.Shift_En       (Shift),
		.D              (D_B),

		.Shift_Out      (NULL),   // DNC
		.Data_Out       (B)
	);


endmodule
