//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2024 02:57:11 PM
// Design Name: 
// Module Name: select_adder4
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


module select_adder4(
    input  logic    [3:0]  a, 
    input  logic    [3:0]  b,
	input  logic           cin,
	
	output logic    [3:0]  s,
	output logic           cout
    );
    
    logic [3:0] s_ripple_a, s_ripple_b; // INTERNAL RIPPLE DATAPATH
    logic cout_ripple_a, cout_ripple_b;
    
    ripple_adder4 ripple_a (
        .a(a),
        .b(b),
        .cin(1'b0),         // CIN PULLED LOW FOR RIPPLE A
        .s(s_ripple_a),
        .cout(cout_ripple_a)
    );
    
    ripple_adder4 ripple_b (
        .a(a),
        .b(b),
        .cin(1'b1),         // CIN PULLED HIGH FOR RIPPLE B
        .s(s_ripple_b),
        .cout(cout_ripple_b)
    );
    
    fourwide_2x1_mux s_mux (
        .a(s_ripple_a),
        .b(s_ripple_b),
        .sel(cin),          // MUX SEL SIGNAL
        .z(s)               // MUX OUTPUT
    );
    
    assign cout = ((cout_ripple_b & cin) | cout_ripple_a);
        
endmodule
