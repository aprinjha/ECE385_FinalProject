module mapManager(input logic Clk, input logic reset, input logic inputTest,
						input logic [0:399] [4:0] inMapData, input [9:0] DrawX, DrawY, 
						input int playerScore,
						input logic [4:0] collisionTile, playerCurrRow, playerCurrCol,
						input logic enemyOverlap,
						output logic [0:399] [4:0] outMapData,
						output logic mapReset
						);


logic [25:0] counter;
logic [3:0] mapCounter;
int realPlayerScore, nextPlayerScore;
logic[4:0] maximum_score_units, maximum_score_tens;

always_ff @ (posedge Clk or posedge !reset)
begin
	if (reset == 1'd0)
	begin
		outMapData <= inMapData;
		counter <= 26'd0;
		mapReset <= 0;
		mapCounter <= 4'd0;
		realPlayerScore <= 1;
		maximum_score_units <= 5'd20;
		maximum_score_tens <=  5'd20;
	end
	else if (inputTest == 1'd0)
	begin
		outMapData <= {
				5'd5,5'd1,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd6,
				5'd5,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd1 ,5'd0,5'd0,5'd0,5'd2,5'd1,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd1 ,5'd0,5'd1,5'd1,5'd1,5'd1,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd1 ,5'd0,5'd0,5'd0,5'd0,5'd1,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd1 ,5'd1,5'd1,5'd1,5'd0,5'd1,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd0,5'd1,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd1,5'd0,5'd0 ,5'd0,5'd1,5'd0,5'd1 ,5'd1,5'd1,5'd1,5'd1,5'd1,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd1,5'd0,5'd4 ,5'd0,5'd1,5'd0,5'd1 ,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd1,5'd0,5'd0 ,5'd0,5'd1,5'd0,5'd1 ,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd31,5'd1,5'd2,5'd10,5'd0,5'd0,5'd0,5'd3 ,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd1,5'd0,5'd0 ,5'd0,5'd1,5'd0,5'd3 ,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd7,
				5'd5,5'd0,5'd1,5'd0,5'd4 ,5'd0,5'd1,5'd0,5'd1 ,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd1,5'd0,5'd0 ,5'd0,5'd1,5'd0,5'd1 ,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd0,5'd1 ,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd12,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd1 ,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd1 ,5'd0,5'd2,5'd0,5'd0,5'd0,5'd2,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd1 ,5'd0,5'd2,5'd0,5'd0,5'd0,5'd2,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd1 ,5'd0,5'd2,5'd0,5'd0,5'd0,5'd2,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd1,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd6};
	end
	
	
	else if (counter > 25000000 && counter < 50000000 && collisionTile != 5'd7)
	begin
	/*
		if (outMapData[DrawY[9:4]*20 + DrawX[9:4]] == 5'd3)
		begin
			outMapData[DrawY[9:4]*20 + DrawX[9:4]] <= 5'd4;
			counter <= 26'd0;
		end
		else if (outMapData[DrawY[9:4]*20 + DrawX[9:4]] == 5'd4) 
		begin
			outMapData[DrawY[9:4]*20 + DrawX[9:4]] <= 5'd3;
			counter <= 26'd0;
		end
		*/
		for (int i = 0; i<400; i++)
		begin
			//This is where animations are updated
			if (outMapData[i] == 5'd3) outMapData[i] <= 5'd4;
			else if (outMapData[i] == 5'd4) outMapData[i] <= 5'd3;
			
			if (outMapData[i] == 5'd10) outMapData[i] <= 5'd11;
			else if (outMapData[i] == 5'd11) outMapData[i] <= 5'd12;
			else if (outMapData[i] == 5'd12) outMapData[i] <= 5'd13;
			else if (outMapData[i] == 5'd13) outMapData[i] <= 5'd10;
		end
		counter <= 26'd0;
		mapReset <= 0;
		mapCounter <= mapCounter;
	end
	else if (collisionTile == 5'd7) //Collision with ladder tile (initiates map change)
	begin
	
		//TEMPORARY HARDCODED NEW MAP 
		if (mapCounter == 4'd0)
		begin
			
			outMapData <= {
				5'd5,(maximum_score_tens),(maximum_score_units),5'd1,5'd1 ,5'd1,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd20,5'd20,5'd6,
				5'd5,5'd1,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd6,
			   5'd5,5'd 31,5'd1,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd 0,5'd1,5'd0,5'd0 ,5'd0,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd1,5'd0,5'd0 ,5'd0,5'd0 ,5'd0 ,5'd0 ,5'd0,5'd6,
				5'd5,5'd 0,5'd1,5'd0,5'd4 ,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd1,5'd0,5'd0 ,5'd0,5'd0 ,5'd0 ,5'd0 ,5'd0,5'd6,
				5'd5,5'd 0,5'd1,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd1,5'd0,5'd0 ,5'd0,5'd10,5'd0 ,5'd0 ,5'd0,5'd6,
				5'd5,5'd 0,5'd1,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd1,5'd0,5'd0 ,5'd1,5'd1 ,5'd1 ,5'd0 ,5'd0,5'd6,
				5'd5,5'd 0,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd1,5'd1 ,5'd0,5'd0,5'd1,5'd0,5'd0 ,5'd0,5'd0 ,5'd0 ,5'd0 ,5'd0,5'd6,
				5'd5,5'd 0,5'd1,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd0 ,5'd3,5'd0,5'd1,5'd0,5'd0 ,5'd0,5'd0 ,5'd0 ,5'd0 ,5'd0,5'd6,
				5'd5,5'd 0,5'd1,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd1,5'd0,5'd0 ,5'd0,5'd0 ,5'd0 ,5'd0 ,5'd0,5'd6,
				5'd5,5'd 0,5'd1,5'd0,5'd0 ,5'd1,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd1,5'd0,5'd10,5'd0,5'd0 ,5'd0 ,5'd10,5'd0,5'd6,
				5'd5,5'd 0,5'd1,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd1,5'd0,5'd0 ,5'd0,5'd0 ,5'd0 ,5'd0 ,5'd0,5'd6,
				5'd5,5'd 0,5'd1,5'd0,5'd0 ,5'd3,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd1,5'd1,5'd1 ,5'd0,5'd0 ,5'd0 ,5'd1 ,5'd1,5'd6,
				5'd5,5'd 0,5'd1,5'd0,5'd0 ,5'd4,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd1,5'd0,5'd0 ,5'd0,5'd0 ,5'd0 ,5'd0 ,5'd0,5'd6,
				5'd5,5'd 0,5'd1,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd1,5'd0,5'd0 ,5'd0,5'd0 ,5'd0 ,5'd0 ,5'd0,5'd6,
				5'd5,5'd 0,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd1,5'd1 ,5'd0,5'd0,5'd1,5'd0,5'd0 ,5'd0,5'd0 ,5'd0 ,5'd0 ,5'd0,5'd6,
				5'd5,5'd 0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd1,5'd0,5'd0 ,5'd0,5'd7 ,5'd0 ,5'd0 ,5'd0,5'd6,
				5'd5,5'd 0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd1,5'd0,5'd0 ,5'd0,5'd0 ,5'd0 ,5'd0 ,5'd0,5'd6,
				5'd5,5'd 0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd1,5'd0,5'd0 ,5'd0,5'd0 ,5'd0 ,5'd0 ,5'd0,5'd6,
				5'd5,5'd 1,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd1,5'd1,5'd1 ,5'd1,5'd1 ,5'd1 ,5'd1 ,5'd1,5'd6};
			realPlayerScore <= 1;
			mapCounter <= mapCounter + 1;
		end
		else if (mapCounter == 4'd1)
		begin
			outMapData <= {
				5'd5,outMapData[1],outMapData[2],5'd1,5'd1 ,5'd1,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,outMapData[17],outMapData[18],5'd6,
				5'd5,5'd1,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd6,
				5'd5,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd1 ,5'd0,5'd0,5'd0,5'd0,5'd1,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd1 ,5'd1,5'd1,5'd1,5'd0,5'd1,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd0,5'd1,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd1,5'd0,5'd0 ,5'd0,5'd1,5'd0,5'd1 ,5'd1,5'd1,5'd1,5'd1,5'd1,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd1,5'd0,5'd4 ,5'd0,5'd0,5'd0,5'd1 ,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd1,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd1 ,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd31,5'd1,5'd2,5'd10,5'd0,5'd0,5'd0,5'd3 ,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd1,5'd0,5'd0 ,5'd0,5'd1,5'd0,5'd3 ,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd7,5'd6,
				5'd5,5'd0,5'd1,5'd0,5'd4 ,5'd0,5'd1,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd1,5'd0,5'd0 ,5'd0,5'd1,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd0,5'd12,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd1 ,5'd0,5'd2,5'd0,5'd4,5'd0,5'd2,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd1 ,5'd0,5'd2,5'd0,5'd0,5'd0,5'd2,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd0,5'd0,5'd0,5'd0 ,5'd0,5'd0,5'd0,5'd1 ,5'd0,5'd2,5'd0,5'd0,5'd0,5'd2,5'd0,5'd0,5'd0,5'd0,5'd6,
				5'd5,5'd1,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd6};
			mapCounter <= mapCounter + 1;
		end
		else 
		begin
			outMapData <= {
		5'd 5 , outMapData[1] ,outMapData[2] , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , outMapData[17] ,outMapData[18] , 5'd 6 ,
		5'd 5 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 6 ,
		5'd 5 , 5'd 0 ,5'd 4 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 3 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 1 ,5'd 0 , 5'd13 ,5'd 0 , 5'd 3 ,5'd 0 , 5'd 6 ,
		5'd 5 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd12 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 1 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 6 ,
		5'd 5 , 5'd 0 ,5'd 0 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd13 ,5'd 0 , 5'd 6 ,
		5'd 5 , 5'd 0 ,5'd 0 , 5'd 1 ,5'd 4 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 1 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 6 ,
		5'd 5 , 5'd 0 ,5'd 0 , 5'd 1 ,5'd 2 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 1 ,5'd 0 , 5'd 3 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 6 ,
		5'd 5 , 5'd 0 ,5'd 0 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 1 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 6 ,
		5'd 5 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 1 ,5'd 0 , 5'd 12,5'd 0 , 5'd 3 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 7 ,5'd 0 , 5'd 6 ,
		5'd 5 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 1 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 6 ,
		5'd 5 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 0 ,5'd 0 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 6 ,
		5'd 5 , 5'd31 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 1 ,5'd 3 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 4 , 5'd 6 ,
		5'd 5 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 0 ,5'd 0 , 5'd 1 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 6 ,
		5'd 5 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 1 ,5'd 0 , 5'd 0 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 0 ,5'd 0 , 5'd 6 ,
		5'd 5 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 1 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd11 ,5'd 1 , 5'd 0 ,5'd 0 , 5'd 6 ,
		5'd 5 , 5'd 0 ,5'd 0 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 0 ,5'd 0 , 5'd 1 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd12 ,5'd 1 , 5'd 0 ,5'd 0 , 5'd 6 ,
		5'd 5 , 5'd 0 ,5'd 0 , 5'd 1 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 0 ,5'd 0 , 5'd 6 ,
		5'd 5 , 5'd 0 ,5'd 0 , 5'd 1 ,5'd 0 , 5'd 3 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 6 ,
		5'd 5 , 5'd 3 ,5'd 2 , 5'd 1 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 0 ,5'd 0 , 5'd 6 ,
		5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 ,5'd 1 , 5'd 1 
	    };
			mapCounter <= 4'd0;
		end
		mapReset <= 1'd1;
		counter <= 26'd0;
	end
	else if (enemyOverlap)
	begin
		if(outMapData[playerCurrRow*20 + playerCurrCol] == 5'd10 ||
			outMapData[playerCurrRow*20 + playerCurrCol] == 5'd11 ||
			outMapData[playerCurrRow*20 + playerCurrCol] == 5'd12 ||
			outMapData[playerCurrRow*20 + playerCurrCol] == 5'd13)
			begin
						outMapData[playerCurrRow*20 + playerCurrCol] <= 5'd3;
			end
		else 
			begin
						outMapData[playerCurrRow*20 + playerCurrCol] <= 5'd0;
			end
		counter <= counter + 1;
		mapReset <= 1'd0;
		mapCounter <= mapCounter;
		realPlayerScore <= realPlayerScore + 1;
		
		//if (playerScore/10 == 10'd0) outMapData[17] <= 5'd20;
		outMapData[18] <= 20 + (realPlayerScore  - ((realPlayerScore)/10)*10 );
		outMapData[17] <= 20 + (realPlayerScore)/10 ;
		
		if(realPlayerScore > (maximum_score_tens*10 + maximum_score_units))
				begin
					maximum_score_units <= maximum_score_units;
					maximum_score_tens <= maximum_score_tens;		
				end
		else
				begin
					maximum_score_units <= 20 + ((realPlayerScore)-((realPlayerScore)/10)*10 );
					maximum_score_tens <= 20 + (realPlayerScore)/10;
				end
		
		
		//Score tiles: row=0, cols=17-18
		
		/*
		case (playerScore - (playerScore/10)*10)
			0: outMapData[17] <= 5'd20;
			1: outMapData[17] <= 5'd21;
			2: outMapData[17] <= 5'd22;
			3: outMapData[17] <= 5'd23;
			4: outMapData[17] <= 5'd24;
			5: outMapData[17] <= 5'd25;
			6: outMapData[17] <= 5'd26;
			7: outMapData[17] <= 5'd27;
			8: outMapData[17] <= 5'd28;
			9: outMapData[17] <= 5'd29;
			default:;
		endcase
		
		
		case (playerScore/100)
			0: outMapData[18] <= 5'd20;
			1: outMapData[18] <= 5'd21;
			2: outMapData[18] <= 5'd22;
			3: outMapData[18] <= 5'd23;
			4: outMapData[18] <= 5'd24;
			5: outMapData[18] <= 5'd25;
			6: outMapData[18] <= 5'd26;
			7: outMapData[18] <= 5'd27;
			8: outMapData[18] <= 5'd28;
			9: outMapData[18] <= 5'd29;
			default:;
		endcase
		*/
		
	end
	else
	begin
		outMapData <= outMapData;
		counter <= counter + 1;
		mapReset <= 1'd0;
		mapCounter <= mapCounter;
		
		
		//Score update
		/*
		realPlayerScore <= nextPlayerScore;
		outMapData[18] <= 20 + (realPlayerScore  - ((realPlayerScore)/10)*10 );
		outMapData[17] <= 20 + (realPlayerScore-1)/10 ;
		*/
	end

end
/*
always_comb
begin
	nextPlayerScore = realPlayerScore;
	if (enemyOverlap)
	begin
		nextPlayerScore = realPlayerScore + 1;
	end
end
*/

endmodule
