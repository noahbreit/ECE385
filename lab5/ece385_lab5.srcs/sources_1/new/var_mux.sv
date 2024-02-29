`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2024 07:54:12 PM
// Design Name: 
// Module Name: var_mux
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

module var_mux #(parameter  WIDTH = 16, 
                 parameter  CHANNELS = 4,
                 localparam SEL = $clog2(CHANNELS)
) (
    input logic     [(WIDTH - 1) : 0] din [CHANNELS],
    input logic     [(SEL - 1) : 0] sel,
    
    output logic    [(WIDTH - 1) : 0] out
);

assign out = din[sel];

endmodule
