`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2024 10:54:55 AM
// Design Name: 
// Module Name: hdmi_tx_0
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


module hdmi_tx_0(
    input logic [3:0] red,
    input logic [3:0] green,
    input logic [3:0] blue,
    input logic [3:0] aux0_din,
    input logic [3:0] aux1_din,
    input logic [3:0] aux2_din,
    input logic pix_clk,
    input logic pix_clk_locked,
    input logic pix_clkx5,
    input logic ade,
    input logic hsync,
    input logic vde,
    input logic vsync,
    input logic rst,
    
    output logic [2:0] TMDS_DATA_N,
    output logic [2:0] TMDS_DATA_P,
    output logic TMDS_CLK_N,
    output logic TMDS_CLK_P
    );
    
    vga_to_hdmi_block_wrapper vga_to_hdmi_block_wrapper (.*);
    
endmodule
