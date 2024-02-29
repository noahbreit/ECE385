`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2024 07:50:59 PM
// Design Name: 
// Module Name: lc3_reg_file
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


module lc3_reg_file(
    input logic clk,
    input logic reset,
    
    input logic [15:0] din,
    
    input logic [2:0] dr,
    input logic load,
    input logic [2:0] sr2_in,
    input logic [2:0] sr1_in,
    
    output logic [15:0] sr2_out,
    output logic [15:0] sr1_out
);

logic [15:0] reg_file [8];
logic [7:0]  load_reg;

assign sr2_out = reg_file[sr2_in];
assign sr1_out = reg_file[sr1_in];

always_comb
begin
    unique case (dr)            // TRANSLATE 3-BIT SIGNAL TO 8-BIT ONE HOT SIGNAL
        0:  load_reg = 8'h01;
        1:  load_reg = 8'h02;
        2:  load_reg = 8'h04;
        3:  load_reg = 8'h08;
        4:  load_reg = 8'h10;
        5:  load_reg = 8'h20;
        6:  load_reg = 8'h40;
        7:  load_reg = 8'h80;
    endcase
end

genvar i;
generate
    for (i = 0; i < 8; i = i + 1)
    begin
        load_reg lc3_register (
            .clk(clk),
            .reset(reset),
            .load(load_reg[i]), // ONE HOT TRANSLATED FROM DR SIGNAL
            .data_in(din),
            
            .data_out(reg_file[i])
        );
    end
endgenerate

endmodule
