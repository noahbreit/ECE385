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
    input logic clk_100MHz,
    input logic  [0:0]  gpio_usb_int_tri_i,
    output logic [31:0] gpio_usb_keycode_0_tri_o,
    output logic [31:0] gpio_usb_keycode_1_tri_o,
    output logic [0:0]  gpio_usb_rst_tri_o,
    input logic         reset_rtl_0,
    input logic         uart_rtl_0_rxd,
    output logic        uart_rtl_0_txd,
    input logic         usb_spi_miso,
    output logic        usb_spi_mosi,
    output logic        usb_spi_sclk,
    output logic [0:0]  usb_spi_ss
    );
    
    mb_block_wrapper mb_block_wrapper (.*);
    
endmodule
