`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/15/2024 02:26:06 PM
// Design Name: 
// Module Name: adder_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module adder_unit (
    input  logic        Sub,
    input  logic  [8:0] a, 
    input  logic  [8:0] b,
	
	output logic  [8:0] s
);
    // INTERNAL
    logic [8:0] b_mux;
    logic       cin;
    
    // ASSIGN
    genvar i;
    generate
        for (i = 0; i < 9; i = i + 1)
        begin
            assign b_mux[i] = (b[i] ^ Sub); // INVERT B if Sub Operation
        end
    endgenerate
        assign cin = (Sub);             // ADD ONE if Sub Operation
    
    ripple_adder ripple_adder (
        .a      (a),
        .b      (b_mux),
        .cin    (cin),
        .s      (s),
        .cout   (NULL)
    );
    
//    always_ff @(posedge Clk)
//    begin
//            ;   // REMOVE IF NOT USED
//    end
        
endmodule
