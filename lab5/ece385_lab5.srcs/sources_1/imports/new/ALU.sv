`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2024 07:54:02 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
input logic [15:0] A,
input logic [15:0] B,
input logic [1:0] ALUK,

output logic [15:0] ALU_out
    );
    logic [15:0] ALU_result;
    assign ALU_out = ALU_result;
    always_comb
	begin 
	   case(ALUK)
           2'b00:
               ALU_result = A+B;
           2'b01:
               ALU_result = A&B;
           2'b10:
               ALU_result = ~A;
           2'b11: 
               ALU_result = A;
           default : ALU_result = A+B;
	   endcase
    end
    
endmodule
