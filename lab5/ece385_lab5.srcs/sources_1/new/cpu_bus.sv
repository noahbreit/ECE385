`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2024 02:36:30 PM
// Design Name: 
// Module Name: cpu_bus
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


module cpu_bus (
    input logic gate_pc,
    input logic gate_mdr,
    input logic gate_alu, 
    input logic gate_marmux,
    
    input logic [15:0] pc_in,
    input logic [15:0] mdr_in,
    input logic [15:0] alu_in,
    input logic [15:0] marmux_in,
    
    output logic [15:0] out
    );
    
    logic [3:0] ctrl;
    
    assign ctrl = {gate_pc, gate_mdr, gate_alu, gate_marmux};
    
    always_comb
    begin
        case (ctrl)
            1000:       // PC HIGH, ALL ELSE LOW
                out = pc_in;
                
            0100:       // MDR HIGH, ALL ELSE LOW
                out = mdr_in;
                
            0010:       // ALU HIGH, ALL ELSE LOW
                out = alu_in;
            
            0001:       // MARMUS HIGH, ALL ELSE LOW
                out = marmux_in;
            default:
                out = 16'bX;
//                ;
        endcase
    end
endmodule
