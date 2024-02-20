`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2024 03:36:35 PM
// Design Name: 
// Module Name: full_adder_wPG
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


module full_adder_wPG(input logic x,y,z, output logic s,c,P,G);
    assign s = x^y^z;
    assign c = (x&y)|(y&z)|(x&z);
    assign P = x^y;
    assign G = x&y;
endmodule
