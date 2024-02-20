`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2024 03:30:36 PM
// Design Name: 
// Module Name: Carry_Lookahead_Unit
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


module Carry_Lookahead_Unit(input logic [3:0]A,B, 
                            input logic c_in, 
                            output logic c_out, 
                            output logic [3:0]s, 
                            output logic PG,
                            output logic GG);
    logic c0,c1,c2,c3;
    logic P0,P1,P2,P3;
    logic G0,G1,G2,G3; 
    assign c0 = c_in;
    full_adder_wPG FAPG0 (.x(A[0]), .y(B[0]), .z(c0), .s(s[0]), .P(P0), .G(G0));
    assign c1 = (c0&P0)|G0;
    full_adder_wPG FAPG1 (.x(A[1]), .y(B[1]), .z(c1), .s(s[1]), .P(P1), .G(G1));
    assign c2 = (c0&P0&P1)|(G0&P1)|G1;
    full_adder_wPG FAPG2 (.x(A[2]), .y(B[2]), .z(c2), .s(s[2]), .P(P2), .G(G2));
    assign c3 = (c0&P0&P1&P2)|(G0&P1&P2)|(G1&P2)|G2;
    full_adder_wPG FAPG3 (.x(A[3]), .y(B[3]), .z(c3), .s(s[3]), .P(P3), .G(G3));
    assign PG = P0&P1&P2&P3;
    assign GG = G3|(G2&P3)|(G1&P3&P2)|(G0&P3&P2&P1);
    
endmodule
