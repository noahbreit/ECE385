`timescale 1ns / 1ps
//mb_intro_top
//
//Replacement block diagram wrapper file and top level for use with ECE 385
//MicroBlaze introduction tutorial. Note that this instances only the block
//design with no additional logic. You will have to modify this for future labs
//to instantate additional logic
//
//Distribution starting with Fall 2023 semester
//modified 7/25/2023 - Zuofu

module mb_intro_top
   (input  logic clk,
    output logic [15:0] led,
    input  logic [3:0] btn,
    input  logic [15:0] sw,
    output logic uart_rxd,
    input  logic uart_txd);
    
    // LOCALS
    logic [15:0] sw_s;      // DEBOUNCED

    // MICROBLAZE SoC Block Wrapper
//  mb_block mb_block_i
//       (.clk_100MHz(clk),
//        .gpio_rtl_0_tri_o(led[0]),
//        .reset_rtl_0(~btn[0]),      //Note the inversion of the reset button. Buttons are active low, but the MicroBlaze reset is active high
//        .uart_rtl_0_rxd(uart_txd),  //Note the switcheroo between RTX and TXD. This is a common source of confusion in embedded development
//        .uart_rtl_0_txd(uart_rxd)); //RXD = Received Data, and TXD = Transmitted Data, but whether data is transmitted or received depeneds on the
//                                    //perspective. Here, the TXD port means transmitted by the FPGA (but received by the Urbana Board's UART chip)

    // MICROBLAZE SoC Verilog Wrapper
    mb_block_wrapper mb_block_wrapper_i
        (.clk_100MHz(clk),
         .gpio_rtl_0_tri_o(led),     // WEEK1 LAB -- INCREASED GPIO CH1 Bitwidth to 16 and tied to output smt LEDs
         .gpio_rtl_1_tri_i(sw_s),    // WEEK1 LAB -- ADDED SW INPUT TO MICROBLAZE
         .reset_rtl_0(~btn[0]),      //Note the inversion of the reset button. Buttons are active low, but the MicroBlaze reset is active high
         .uart_rtl_0_rxd(uart_txd),  //Note the switcheroo between RTX and TXD. This is a common source of confusion in embedded development
         .uart_rtl_0_txd(uart_rxd)); //RXD = Received Data, and TXD = Transmitted Data, but whether data is transmitted or received depeneds on the
                                     //perspective. Here, the TXD port means transmitted by the FPGA (but received by the Urbana Board's UART chip)
    
    // SWITCH INPUT DEBOUNCE
    sync_flop sw_sync [15:0] (
        .clk	(clk),
        .d		(sw),
    
        .q		(sw_s)
    );
    
endmodule
