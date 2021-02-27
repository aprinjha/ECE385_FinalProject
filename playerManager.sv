module playerManager(input logic Clk, input logic frameClk, input logic reset, input logic [0:7] keycode,
						input logic [0:399] [4:0] inMapData,
						input [9:0] DrawX, DrawY,
						output logic [9:0] playerX, playerY, playerWidth, playerHeight,
						output logic [4:0] collisionTile,
						output logic enemyOverlap,
						output logic [4:0] currRow, currCol,
						output int playerScore);
		
int player_x_pos, player_y_pos, player_x_next, player_y_next, player_y_dir, player_x_dir;
int live_x_dir, live_y_dir;
int player_width, player_height;
int speed;
logic collision;
int next_x_pos, next_y_pos;
logic [4:0] collision_tile;
logic enemy_overlap;
int nextScore;

assign playerX = player_x_pos;
assign playerY = player_y_pos;
assign playerWidth = player_width;
assign playerHeight = player_height;
assign collisionTile = collision_tile;
assign enemyOverlap = enemy_overlap;
	
always_ff @ (posedge frameClk or posedge reset)	
begin
	if (reset)
	begin
		for (int row = 0; row < 20; row++)
		begin
			for (int col = 0; col < 20; col++)
			begin
				if (inMapData[row*20+col] == 5'd31) //31 signifies starting location for player
				begin
					player_x_pos <= col*16;
					player_y_pos <= row*16;
				end
			end
		end
		playerScore <= 0;
	end

	else 
	begin
		player_width <= 9;
		player_height <= 12;
		speed <= 2;
		player_x_dir <= 0;
		player_y_dir <= 0;
		
		//Do keyboard direction
		case (keycode)
						8'h04 : begin
									player_x_dir <= -1;//A
									player_y_dir <= 0;
								  end
								  
						8'h07 : begin
								  player_x_dir <= 1;//D
								  player_y_dir <= 0;
								  end

								  
						8'h16 : begin
								  player_y_dir <= 1;//S
								  player_x_dir <= 0;
								 end
								  
						8'h1A : begin
								  player_y_dir <= -1;//W
								  player_x_dir <= 0;
								 end	  
						default: ;
		endcase
		
		
		//Collision detection
		/*
		for (int row = 0; row < 20; row++)
		begin
			for (int col = 0; col < 20; col++)
				begin
					
					if (((((player_x_pos + speed*live_x_dir) < col*16+16 && 
							(player_x_pos+speed*live_x_dir+player_width) > col*16) &&
							((player_y_pos+speed*live_y_dir) < row*16+16 &&
							(player_y_pos+speed*live_y_dir+player_height) > row*16)) &&
							(inMapData[row*20+col] != 5'd31 && inMapData[row*20+col] != 5'd0)))
					begin
						player_x_dir <= 0;
						player_y_dir <= 0;
					end
	
					
				
			end
		end
		
		//Update position of player
		
		player_x_pos <= player_x_pos + speed*player_x_dir;
		player_y_pos <= player_y_pos + speed*player_y_dir;
		*/
		player_x_pos <= next_x_pos;
		player_y_pos <= next_y_pos;
		
		playerScore <= nextScore;
		
	end
	
	
end

always_comb
begin
	live_x_dir = 0;
	live_y_dir = 0;
	next_x_pos = 0;
	next_y_pos = 0;
	collision = 0;
	collision_tile = 5'd0;
	enemy_overlap = 1'd0;
	currRow = 5'd0;
	currCol = 5'd0;
	nextScore = playerScore;
	

	
	case (keycode)
						8'h04 : begin
									live_x_dir = -1;//A
									live_y_dir = 0;
								  end
								  
						8'h07 : begin
								  live_x_dir = 1;//D
								  live_y_dir = 0;
								  end

								  
						8'h16 : begin
								  live_y_dir = 1;//S
								  live_x_dir = 0;
								 end
								  
						8'h1A : begin
								  live_y_dir = -1;//W
								  live_x_dir = 0;
								 end	  
						default: ;
		endcase

		//Press 'Q' when over ladder to go to next map
		if ((inMapData[(player_y_pos+player_height/2)/16*20+(player_x_pos+player_width/2)/16] == 5'd7 && keycode == 8'h14))
		begin
			collision_tile[4:0] = 5'd7;
		end
		
		//Press 'E' to kill enemies when on top of them
		if (( inMapData[(player_y_pos+player_height/2)/16*20+(player_x_pos+player_width/2)/16] == 5'd3  ||
				inMapData[(player_y_pos+player_height/2)/16*20+(player_x_pos+player_width/2)/16] == 5'd4  ||
				inMapData[(player_y_pos+player_height/2)/16*20+(player_x_pos+player_width/2)/16] == 5'd10 ||
				inMapData[(player_y_pos+player_height/2)/16*20+(player_x_pos+player_width/2)/16] == 5'd11 ||
				inMapData[(player_y_pos+player_height/2)/16*20+(player_x_pos+player_width/2)/16] == 5'd12 ||
				inMapData[(player_y_pos+player_height/2)/16*20+(player_x_pos+player_width/2)/16] == 5'd13 
						) && 
					keycode == 8'h08)
		begin
			currRow = (player_y_pos+player_height/2)/16;
			currCol = (player_x_pos+player_width/2)/16;
			enemy_overlap = 1'd1;
			nextScore = playerScore + 10;
		end 
		else 
		begin
			enemy_overlap = 1'd0;
			nextScore = playerScore;
		end
		
		
		
		//Collision detection stuff
		for (int row = 0; row < 20; row++)
		begin
			for (int col = 0; col < 20; col++)
				begin
					//Test x-direction			
					if (live_x_dir == 1 && ((((player_x_pos + speed*live_x_dir) < col*16+16 && 
							(player_x_pos+speed*live_x_dir+player_width) > col*16) &&
							((player_y_pos+speed*live_y_dir) < row*16+16 &&
							(player_y_pos+speed*live_y_dir+player_height) > row*16)) &&
							(inMapData[row*20+col] != 5'd31 && inMapData[row*20+col] != 5'd0 && inMapData[row*20+col] != 5'd7 && inMapData[row*20+col] != 5'd3
							&& inMapData[row*20+col] != 5'd4 && inMapData[row*20+col] != 5'd10 && inMapData[row*20+col] != 5'd11 && inMapData[row*20+col] != 5'd12 
							&& inMapData[row*20+col] != 5'd13)))
					begin
						next_x_pos = col*16 - player_width - 1;
						next_y_pos = player_y_pos;
						collision = 1;
						break;
					end 

					else if (live_x_dir == -1 && ((((player_x_pos + speed*live_x_dir) < col*16+16 && 
							(player_x_pos+speed*live_x_dir+player_width) > col*16) &&
							((player_y_pos+speed*live_y_dir) < row*16+16 &&
							(player_y_pos+speed*live_y_dir+player_height) > row*16)) &&
							(inMapData[row*20+col] != 5'd31 && inMapData[row*20+col] != 5'd0 && inMapData[row*20+col] != 5'd7 && inMapData[row*20+col] != 5'd3
							&& inMapData[row*20+col] != 5'd4 && inMapData[row*20+col] != 5'd10 && inMapData[row*20+col] != 5'd11 && inMapData[row*20+col] != 5'd12 
							&& inMapData[row*20+col] != 5'd13)))
					begin
						next_x_pos = col*16+17;
						next_y_pos = player_y_pos;
						collision = 1;
						break;
					end

					
					//Test y-direction
					else if (live_y_dir == 1 && ((((player_x_pos + speed*live_x_dir) < col*16+16 && 
							(player_x_pos+speed*live_x_dir+player_width) > col*16) &&
							((player_y_pos+speed*live_y_dir) < row*16+16 &&
							(player_y_pos+speed*live_y_dir+player_height) > row*16)) &&
							(inMapData[row*20+col] != 5'd31 && inMapData[row*20+col] != 5'd0 && inMapData[row*20+col] != 5'd7 && inMapData[row*20+col] != 5'd3
							&& inMapData[row*20+col] != 5'd4 && inMapData[row*20+col] != 5'd10 && inMapData[row*20+col] != 5'd11 && inMapData[row*20+col] != 5'd12 
							&& inMapData[row*20+col] != 5'd13)))
					begin
						next_y_pos = row*16 - player_height - 1;
						next_x_pos = player_x_pos;
						collision = 1;
						break;
					end

					else if (live_y_dir == -1 && ((((player_x_pos + speed*live_x_dir) < col*16+16 && 
							(player_x_pos+speed*live_x_dir+player_width) > col*16) &&
							((player_y_pos+speed*live_y_dir) < row*16+16 &&
							(player_y_pos+speed*live_y_dir+player_height) > row*16)) &&
							(inMapData[row*20+col] != 5'd31 && inMapData[row*20+col] != 5'd0 && inMapData[row*20+col] != 5'd7 && inMapData[row*20+col] != 5'd3
							&& inMapData[row*20+col] != 5'd4 && inMapData[row*20+col] != 5'd10 && inMapData[row*20+col] != 5'd11 && inMapData[row*20+col] != 5'd12 
							&& inMapData[row*20+col] != 5'd13)))
					begin
						next_y_pos = row*16 + 17;
						next_x_pos = player_x_pos;
						collision = 1;
						break;
					end
			end
			if (collision) break;
		end
		
		if (!collision)
		begin
			next_x_pos = player_x_pos + speed*live_x_dir;
			next_y_pos = player_y_pos + speed*live_y_dir;
		end
		
end		

endmodule
