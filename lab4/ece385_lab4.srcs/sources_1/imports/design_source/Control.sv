//Two-always example for state machine

module control (
	input  logic Clk,
	input  logic Reset_Load_Clear,
	input  logic Run,
	input  logic M,
	
	// DEBUG DEBUG
//	output logic [5:0] state,
	// DEBUG DEBUG
	
	output logic Clr_Ld,
	output logic Shift,
	output logic Add,
	output logic Sub,
	output logic Load
);
    // INTERNAL
    logic Reset;
    
    
    // ASSIGN
    assign Reset = Reset_Load_Clear;
    assign state = curr_state;
    

// Declare signals curr_state, next_state of type enum
// with enum values of s_start, s_count0, ..., s_done as the state values
// Note that the length implies a max of 8 states, so you will need to bump this up for 8-bits
	enum logic [5:0] {
		s_start, 
		s_clear,
		s_add0,
		s_load0,
		s_shift0, 
		s_add1,
		s_load1,
		s_shift1,
		s_add2,
		s_load2,
		s_shift2,
		s_add3,
		s_load3,
		s_shift3,
		s_add4,
		s_load4,
		s_shift4,
		s_add5,
		s_load5,
		s_shift5,
		s_add6,
		s_load6,
		s_shift6,
		s_sub7,
		s_load7,
		s_shift7,
		s_done,
		s_delay
	} curr_state, next_state;

	always_comb
	begin
	// Assign outputs based on ‘state’
		unique case (curr_state) 
			s_start: 
			begin
				Clr_Ld <= 0;
				Shift <= 0;
				Add <= 0;
				Sub <= 0;
				Load <= 0;
			end

			s_done: 
			begin
			    Clr_Ld <= 0;
				Shift <= 0;
				Add <= 0;
				Sub <= 0;
				Load <= 0;
			end
			
			s_clear:
			begin
			    Clr_Ld <= 1;
				Shift <= 0;
				Add <= 0;
				Sub <= 0;
				Load <= 0;
		    end
			
			s_sub7:
			begin
			     Clr_Ld <= 0;
			     Shift <= 0;
			     Add <= 0;
			     Sub <= M;
			     Load <= M;
			end
			
			s_load0: 
			begin
			    Clr_Ld <= 0;
				Shift <= 0;
				Add <= 0;
				Sub <= 0;
				Load <= 0;
			end
			
			s_load1: 
			begin
			    Clr_Ld <= 0;
				Shift <= 0;
				Add <= 0;
				Sub <= 0;
				Load <= 0;
			end
			
			s_load2: 
			begin
			    Clr_Ld <= 0;
				Shift <= 0;
				Add <= 0;
				Sub <= 0;
				Load <= 0;
			end
			
			s_load3: 
			begin
			    Clr_Ld <= 0;
				Shift <= 0;
				Add <= 0;
				Sub <= 0;
				Load <= 0;
			end
			
			s_load4: 
			begin
			    Clr_Ld <= 0;
				Shift <= 0;
				Add <= 0;
				Sub <= 0;
				Load <= 0;
			end
			
			s_load5: 
			begin
			    Clr_Ld <= 0;
				Shift <= 0;
				Add <= 0;
				Sub <= 0;
				Load <= 0;
			end
			
			s_load6: 
			begin
			    Clr_Ld <= 0;
				Shift <= 0;
				Add <= 0;
				Sub <= 0;
				Load <= 0;
			end
			
			s_load7: 
			begin
			    Clr_Ld <= 0;
				Shift <= 0;
				Add <= 0;
				Sub <= 0;
				Load <= 0;
			end
			
			s_add0: 
			begin
			    Clr_Ld <= 0;
				Shift <= 0;
				Add <= M;
				Sub <= 0;
				Load <= M;
			end
			
			s_add1: 
			begin
			    Clr_Ld <= 0;
				Shift <= 0;
				Add <= M;
				Sub <= 0;
				Load <= M;
			end
			
			s_add2: 
			begin
			    Clr_Ld <= 0;
				Shift <= 0;
				Add <= M;
				Sub <= 0;
				Load <= M;
			end
			
			s_add3: 
			begin
			    Clr_Ld <= 0;
				Shift <= 0;
				Add <= M;
				Sub <= 0;
				Load <= M;
			end
			
			s_add4: 
			begin
			    Clr_Ld <= 0;
				Shift <= 0;
				Add <= M;
				Sub <= 0;
				Load <= M;
			end
			
			s_add5: 
			begin
			    Clr_Ld <= 0;
				Shift <= 0;
				Add <= M;
				Sub <= 0;
				Load <= M;
			end
			
			s_add6: 
			begin
			    Clr_Ld <= 0;
				Shift <= 0;
				Add <= M;
				Sub <= 0;
				Load <= M;
			end
			
			s_shift0: 
			begin
			    Clr_Ld <= 0;
				Shift <= 1;
				Add <= 0;
				Sub <= 0;
				Load <= 0;
			end
			
			s_shift1: 
			begin
			    Clr_Ld <= 0;
				Shift <= 1;
				Add <= 0;
				Sub <= 0;
				Load <= 0;
			end
			
			s_shift2: 
			begin
			    Clr_Ld <= 0;
				Shift <= 1;
				Add <= 0;
				Sub <= 0;
				Load <= 0;
			end
			
			s_shift3: 
			begin
			    Clr_Ld <= 0;
				Shift <= 1;
				Add <= 0;
				Sub <= 0;
				Load <= 0;
			end
			
			s_shift4: 
			begin
			    Clr_Ld <= 0;
				Shift <= 1;
				Add <= 0;
				Sub <= 0;
				Load <= 0;
			end
			
			s_shift5: 
			begin
			    Clr_Ld <= 0;
				Shift <= 1;
				Add <= 0;
				Sub <= 0;
				Load <= 0;
			end
			
			s_shift6: 
			begin
			    Clr_Ld <= 0;
				Shift <= 1;
				Add <= 0;
				Sub <= 0;
				Load <= 0;
			end
			
			s_shift7: 
			begin
			    Clr_Ld <= 0;
				Shift <= 1;
				Add <= 0;
				Sub <= 0;
				Load <= 0;
			end
			    

//			default:  //default case, can also have default assignments for Ld_A and Ld_B before case
//			begin 
//                if ( curr_state & 5'b00001 ) // CHECK IF ADD STATE
//                begin
//                    Clr_Ld <= 0;
//                    Shift <= 0;
//                    Add <= M;
//                    Sub <= 0;
//                end
//                else                    // SHIFT STATE
//                begin
//                    Clr_Ld <= 0;
//                    Shift <= 1;
//                    Add <= 0;
//                    Sub <= 0;
//                end
//			end
		endcase
	end

// Assign outputs based on state
	always_comb
	begin

		next_state  = curr_state;	//required because I haven't enumerated all possibilities below. Synthesis would infer latch without this
		unique case (curr_state)

			s_start :    
			begin
				if (Run) 
				begin
					next_state = s_clear;
				end
			end
		
			s_done :    
			begin
				if (~Run) 
				begin
					next_state = s_start;
				end
			end
			
//			s_clear : 
//			begin
//			     ; // NOTHING
//			end
			
//			s_delay : 
//			begin
//			    if (curr_state & 5'b00001)
//			    begin
//			         next_state = buffer_state;
//			         buffer_state = s_delay;
//			    end
//			end
            
            s_clear  : next_state = s_add0;
			
			s_add0   : next_state = s_load0;
			s_load0  : next_state = s_shift0;
			s_shift0 : next_state = s_add1;
			
			s_add1   : next_state = s_load1;
			s_load1  : next_state = s_shift1;
			s_shift1 : next_state = s_add2;
			
			s_add2   : next_state = s_load2;
			s_load2  : next_state = s_shift2;
			s_shift2 : next_state = s_add3;
			
			s_add3   : next_state = s_load3;
			s_load3  : next_state = s_shift3;
			s_shift3 : next_state = s_add4;
			
			s_add4   : next_state = s_load4;
			s_load4  : next_state = s_shift4;
			s_shift4 : next_state = s_add5;
			
			s_add5   : next_state = s_load5;
			s_load5  : next_state = s_shift5;
			s_shift5 : next_state = s_add6;
			
			s_add6   : next_state = s_load6;
			s_load6  : next_state = s_shift6;
			s_shift6 : next_state = s_sub7;
			
			s_sub7   : next_state = s_load7;
			s_load7  : next_state = s_shift7;
			s_shift7 : next_state = s_done;
			
		endcase
	end



	//updates flip flop, current state is the only one
	always_ff @(posedge Clk)  
	begin
		if (Reset)
		begin
			curr_state <= s_start;
		end
		else 
		begin
			curr_state <= next_state;
		end
	end
	
//	always_ff @(negedge (Run))
//	begin
//	   next_state <= s_start;
//	end

endmodule
