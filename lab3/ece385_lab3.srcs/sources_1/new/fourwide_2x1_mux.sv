`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2024 02:54:00 PM
// Design Name: 
// Module Name: fourwide_2x1_mux
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


module fourwide_2x1_mux(
    input logic     [3:0]   a,
    input logic     [3:0]   b,
    input logic             sel,
    output logic    [3:0]   z      
    );
    
    assign z = (sel) ? (b) : (a);
endmodule
