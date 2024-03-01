module ben_logic(
    input logic [15:0] ir_in,
    input logic [2:0] nzp_in,
    
    output logic ben
    );
    
    assign ben = ir_in[11]&nzp_in[2] + ir_in[10]&nzp_in[1] + ir_in[9]&nzp_in[0];
endmodule
