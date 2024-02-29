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
                 parameter  CHANNELS = 4
) (
    input logic     [(WIDTH - 1) : 0] din [CHANNELS],
    input logic     [(CHANNELS - 1) : 0] sel,           // ONE HOT
    
    output logic    [(WIDTH - 1) : 0] out
);

always_comb
begin
    unique case (sel)
        0: out = din[0];
        2: out = din[1];
        4: out = din[2];
        8: out = din[3];
        default: out = 'X;
    endcase
end

endmodule
