module N_Z_P_logic(
    input logic [15:0] data_input,
    
    output logic [2:0] N_Z_P_val
    );
    
    logic result = 3'b000;
    
    assign N_Z_P_val = result;
    
    always_comb
    begin 
        if(data_input == 16'b0000000000000000 ) // zero case 
            begin
                result = 3'b010;
            end
        else if( data_input[15] == 1'b1) // negative case 
            begin
                result = 3'b100;
            end
        else                              //positive case
            begin
                result = 3'b001;
            end
    end
endmodule
