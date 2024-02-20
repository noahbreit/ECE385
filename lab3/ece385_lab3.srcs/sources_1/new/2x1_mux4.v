//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2024 02:47:38 PM
// Design Name: 
// Module Name: 2x1_mux4
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


module 2x1_mux4(
    input  logic  [3:0] a, 
    input  logic  [3:0] b,
    input  logic        s,
    output logic  [3:0] z
    );
    
    assign z = (s) ? (b) : (a);
    
endmodule
