`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2024 11:00:20 AM
// Design Name: 
// Module Name: clk_wiz_0
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


module clk_wiz_0(
    input logic     clk_in1,
    input logic     reset,
    output logic    clk_out1,
    output logic    clk_out2,
    output logic    locked
    );
    
    clk_wiz_block_wrapper clk_wiz_block_wrapper (.*);
    
endmodule
