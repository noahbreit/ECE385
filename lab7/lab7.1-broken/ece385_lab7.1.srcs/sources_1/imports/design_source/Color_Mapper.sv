//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Zuofu Cheng   08-19-2023                               --
//                                                                       --
//    Fall 2023 Distribution                                             --
//                                                                       --
//    For use with ECE 385 USB + HDMI                                    --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input  logic [9:0] BallX, BallY, DrawX, DrawY, Ball_size,
                       input  logic [31:0]  vram_data,
                       output logic [9:0]  vram_addr,
                       output logic [3:0]  Red, Green, Blue );
    
    logic ball_on;
    
    /* ROM */
    logic [7:0] rom_data;
    logic [10:0] rom_addr;
    logic [7:0] rom_mask;
    font_rom font_rom(
        .data(rom_data),
        .addr(rom_addr)
    );
	 
 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*BallS, centered at (BallX, BallY).  Note that this requires unsigned comparisons.
	 
    if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))
       )

     New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 120 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). */
	  
    int DistX, DistY, Size;
    int i;
    assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Size = Ball_size;
  
//    always_comb
//    begin:Ball_on_proc
//        if ( (DistX*DistX + DistY*DistY) <= (Size * Size) )
//            ball_on = 1'b1;
//        else 
//            ball_on = 1'b0;
//     end 
       
//    always_comb
//    begin:RGB_Display
//        if ((ball_on == 1'b1)) begin 
//            Red = 4'hf;
//            Green = 4'h7;
//            Blue = 4'h0;
//        end       
//        else begin 
//            Red = 4'hf - DrawX[9:6]; 
//            Green = 4'hf - DrawX[9:6];
//            Blue = 4'hf - DrawX[9:6];
//        end      
//    end 
    
    logic shape_on;
    logic [10:0] shape_x = 300;
    logic [10:0] shape_y = 300;
    logic [10:0] shape_size_x = 8;
    logic [10:0] shape_size_y = 16;
    
    always_comb
    begin:Fetch_Vram_Data
        begin
            vram_addr = ((DrawY << 4 + DrawY) + (DrawX >> 3)) >> 2;
            
            rom_addr = vram_data[7:0];
        end
    end
    
    always_comb
    begin:RGB_Display
        
        if (rom_data[(DrawX & 10'h00F)])    // %Mod #16...
        begin
            // ON! -- FOREGROUND
            vram_addr = 600; // ctrl_reg
            Red = vram_data[21:4];
            Green = vram_data[17:4];
            Blue = vram_data[13:4];
        end
        else 
        begin
            // OFF! -- BACKGROUND
            vram_addr = 600; // ctrl_reg
            Red = vram_data[12:9];
            Green = vram_data[8:5];
            Blue = vram_data[4:1];
        end
    end
    
endmodule
