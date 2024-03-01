module ben_logic(
    input logic [2:0] ir_in,
    input logic [2:0] nzp_in,
    
    output logic ben
    );
    
    assign ben = ir_in[2]&nzp_in[2] + ir_in[1]&nzp_in[1] + ir_in[0]&nzp_in[0];
endmodule
