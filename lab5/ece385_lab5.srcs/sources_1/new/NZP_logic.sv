module NZP_logic(
    input logic [15:0] data_input,
    
    output logic [2:0] N_Z_P_val
    );
    
    logic [2:0] result = 3'bxxx;
    
    assign N_Z_P_val = result;
    
    always_comb
    begin 
       case(data_input[15])
            1'b1: //neg case
                begin 
                    result = 3'b100;
                end 
            1'b0: //pos case
                begin
                    if(data_input == 16'b0000000000000000) //zero case
                        result = 3'b010;
                    else
                        result = 3'b001;
                end
        endcase 
    end
endmodule
