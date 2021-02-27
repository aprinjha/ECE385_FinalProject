//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input logic reset, input logic Clk, input [9:0] DrawX, DrawY, output logic [7:0]  Red, Green, Blue,
								input logic [0:399] [4:0] inMapData, output logic [18:0] readAddress,
								
								input logic [9:0] playerX, playerY, playerWidth, playerHeight, 
								input logic [0:7] keycode,
								input logic [23:0] chestEmptyAnim0_data_Out,
								input logic [23:0] floor_1_data_out,
								input logic [23:0] floor_ladder_data_out,
								input logic [23:0] wall_mid_data_out,
								input logic [23:0] wall_left_data_out,
								input logic [23:0] wall_right_data_out,
								input logic [23:0] imp_idle_anim_f1_data_out,
								input logic [23:0] imp_idle_anim_f2_data_out,
								input logic [23:0] swamp_data_out_0,
								input logic [23:0] swamp_data_out_1,
								input logic [23:0] swamp_data_out_2,
								input logic [23:0] swamp_data_out_3,
								input logic [23:0] elf_data_out_0,
								input logic [23:0] elf_data_out_1,
								input logic [23:0] elf_data_out_2,
								input logic [23:0] elf_data_out_3,
								input logic [23:0] elf_data_out_4,
								input logic [23:0] elf_data_out_5,
								input logic [23:0] elf_data_out_6,
								input logic [23:0] elf_data_out_7,
								input logic [23:0] elf_data_out_8,
								input logic [23:0] font_data_0,
								input logic [23:0] font_data_1,
								input logic [23:0] font_data_2,
								input logic [23:0] font_data_3,
								input logic [23:0] font_data_4,
								input logic [23:0] font_data_5,
								input logic [23:0] font_data_6,
								input logic [23:0] font_data_7,
								input logic [23:0] font_data_8,
								input logic [23:0] font_data_9);
 
    logic ball_on;
	 
 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*Ball_Size, centered at (BallX, BallY).  Note that this requires unsigned comparisons.
	 
    if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))

     New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 12 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). */
	  
	 /*
    int DistX, DistY, Size;
	 assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Size = Ball_size;
	  
    always_comb
    begin:Ball_on_proc
        if ( ( DistX*DistX + DistY*DistY) <= (Size * Size) ) 
            ball_on = 1'b1;
        else 
            ball_on = 1'b0;
     end 
       
    always_comb
    begin:RGB_Display
        if ((ball_on == 1'b1)) 
        begin 
            Red = 8'hff;
            Green = 8'h55;
            Blue = 8'h00;
        end       
        else 
        begin 
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h7f - DrawX[9:3];
        end      
    end */
	 //mapData
	 
	 logic [4:0] tileData;
	 logic [23:0] colorData;
	 logic left;
	 
	 logic [4:0] playercolorData;
	 logic [25:0] counter;

	
	 assign Red = colorData[23:16];
	 assign Green = colorData[15:8];
	 assign Blue = colorData[7:0];
	 
	 logic [9:0] lastX, lastY;
	 logic [9:0] colIndex;
	 logic [9:0] rowIndex;
	 /*
	 always_ff @ (posedge Clk) 
	 begin
		if (reset == 1'd1)
		begin
			colIndex <= 10'd0;
			rowIndex <= 10'd0;
			lastX = 10'd0;
			lastY = 10'd0;
		end
		if ((DrawY > 10'd479)) begin colIndex <= 10'd0; rowIndex <= 10'd0; end
		if (DrawX > 10'd639) colIndex <= 10'd0;
		if ((DrawY[3:0] == 4'd0) && (DrawY != lastY)) rowIndex <= rowIndex + 10'd1; 
		if ((DrawX[3:0] == 4'd0) && (DrawX != lastX)) colIndex <= colIndex + 10'd1;
		lastX <= DrawX;
		lastY <= DrawY;
	 end */
	 
	 /*
	 always_ff @ (posedge Clk)
	 begin
		
	 end
	 */
	 
	 
	 
	 always_comb
	 begin
		
		
		colorData = 24'd0;
		tileData = 5'd0;
		readAddress = 19'd0;
		
		
		if (DrawY[9:4] < 10'd20 && DrawX[9:4] < 10'd20)
		begin
			tileData = inMapData[DrawY[9:4]*20 + DrawX[9:4]];//mapData[rowIndex*10'd20+colIndex]; //Row major order
			readAddress = (DrawY[3:0])*16+(DrawX[3:0]);
		end

	
		
		
		//colorData = chestEmptyAnim0_data_Out;
		case (tileData)
			5'd0: colorData = floor_1_data_out;
			5'd31:colorData = floor_1_data_out;
			5'd1: colorData = wall_mid_data_out;
			5'd2: colorData = chestEmptyAnim0_data_Out;
			5'd3: colorData = imp_idle_anim_f1_data_out;
			5'd4: colorData = imp_idle_anim_f2_data_out;
			5'd5: colorData = wall_left_data_out;
			5'd6: colorData = wall_right_data_out;
			5'd7: colorData = floor_ladder_data_out;
			5'd10:colorData = swamp_data_out_0;
			5'd11:colorData = swamp_data_out_1;
			5'd12:colorData = swamp_data_out_2;
			5'd13:colorData = swamp_data_out_3;
			5'd20:colorData = font_data_0;
			5'd21:colorData = font_data_1;
			5'd22:colorData = font_data_2;
			5'd23:colorData = font_data_3;
			5'd24:colorData = font_data_4;
			5'd25:colorData = font_data_5;
			5'd26:colorData = font_data_6;
			5'd27:colorData = font_data_7;
			5'd28:colorData = font_data_8;
			5'd29:colorData = font_data_9;
			
			default: colorData = 24'd0;
		endcase
		
		
		//Draw player sprite
		if (DrawX >= playerX && DrawX <= playerX+playerWidth && DrawY >= (playerY) && DrawY <= playerY+playerHeight)
		begin
			
			if (left) readAddress = (DrawY-(playerY-3))*16 + (playerX-DrawX+9);
			else readAddress = (DrawY-(playerY-3))*16 + (DrawX-(playerX));
			
			if( keycode == 8'h4 || keycode == 8'h7 || keycode == 8'h16 || keycode == 8'h1A )
				begin
				case(playercolorData)
					5'd0 : colorData = elf_data_out_4;
					5'd1 : colorData = elf_data_out_5;
					5'd2 : colorData = elf_data_out_6;
					5'd3 : colorData = elf_data_out_7;
					default : ;
				endcase
				end
			else
				begin
				case(playercolorData)
					5'd0 : colorData = elf_data_out_0;
					5'd1 : colorData = elf_data_out_1;
					5'd2 : colorData = elf_data_out_2;
					5'd3 : colorData = elf_data_out_3;
					default : ;
				endcase
				end
		end
		
	 end

/*	 
always_comb
		begin
			if(reset == 1'd0)
				begin
				//counter <= 26'd0;
				playercolorData = elf_data_out_5;
				end
			else if(reset == 1'd1)
				playercolorData = elf_data_out_1;	
			
		end
*/		
	 
 
always_ff @ (posedge Clk or posedge !reset)
begin
	if (reset == 1'd0)
	begin
		counter <= 26'd0;
		playercolorData <= 5'd0;
		//left <= 0;
	end
	else if (counter > 12500000 && counter < 50000000)
	begin
		if(playercolorData == 5'd0)
				playercolorData <= 5'd1;
		else if(playercolorData == 5'd1)
				playercolorData <= 5'd2;
		else if(playercolorData == 5'd2)
				playercolorData <= 5'd3;
		else if(playercolorData == 5'd3)
				playercolorData <= 5'd0;
		counter <= 26'd0;
	end
	else
		begin
			counter <= counter + 1;
		end	
end

always_ff @ (posedge Clk or posedge !reset)
begin
	if(reset == 1'd0) left <= 0;
	else if (keycode == 8'h04) left <= 1;
	else if (keycode == 8'h07) left <= 0;
end
    
endmodule
