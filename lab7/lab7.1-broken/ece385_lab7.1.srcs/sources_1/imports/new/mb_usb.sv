`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2024 10:44:26 PM
// Design Name: 
// Module Name: mb_usb
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


module mb_usb(
    input logic         clk_100MHz,
    input logic         reset_rtl_0,
    input logic         uart_rtl_0_rxd,
    output logic        uart_rtl_0_txd,
    output logic         HDMI_0_tmds_clk_n,
    output logic         HDMI_0_tmds_clk_p,
    output logic [2:0]   HDMI_0_tmds_data_n,
    output logic [2:0]   HDMI_0_tmds_data_p
    );
    
    mb_block_wrapper mb_block_wrapper (.*);
    
endmodule
