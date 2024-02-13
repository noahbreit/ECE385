`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2024 02:25:30 PM
// Design Name: 
// Module Name: full_adder
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


module full_adder(
    input logic cin,
    input logic a,
    input logic b,
    output logic s,
    output logic cout
    );
    
    assign s = ((a^b)^cin);
    assign cout = ((a&b)|(cin&a)|(cin&b));
    
endmodule
