module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

logic clk = 0;


// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 clk = ~clk;
end
						  						  
						  
initial begin: CLOCK_INITIALIZATION
    clk = 0;
end 



logic [0:399][4:0] mapData; 
logic [5:0] data_In;
logic [18:0] write_address, read_address;
logic we;
logic [23:0] chestEmptyAnim0_data_Out;	 

chestEmptyAnim0 chest(	.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk(clk),
						.data_Out(chestEmptyAnim0_data_Out));
						
						
logic [9:0] DrawX, DrawY;
logic [7:0]  Red, Green, Blue;
logic reset;
/*
assign mapData = 
{
5'd0,5'd1,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,
5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,
5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,
5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,
5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,
5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,
5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,
5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,
5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,
5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,
5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,
5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,
5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,
5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,
5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,
5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,
5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,
5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,
5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,
5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0,5'd0};
						
color_mapper mapper0(.reset(reset), .Clk(clk), .DrawX, .DrawY, .Red, .Green, .Blue,
								.mapData , .readAddress(read_address),
								.chestEmptyAnim0_data_Out(chestEmptyAnim0_data_Out));
*/




// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program
initial begin: TEST_VECTORS

	write_address = 19'd0;
	we = 1'b0;
	data_In = 6'd0;
	
	#20 read_address = 8'd0;
	#10 read_address = 8'd1;
	#10 read_address = 8'd2;
	#10 read_address = 8'd3;
	#10 read_address = 8'd4;
	#10 read_address = 8'd5;
	#10 read_address = 8'd6;
	#10 read_address = 8'd7;
	#10 read_address = 8'd8;
	#10 read_address = 8'd9;
	#10 read_address = 8'd10;
	#10 read_address = 8'd11;
	#10 read_address = 8'd12;
	#10 read_address = 8'd13;
	#10 read_address = 8'd50;
	
	
	reset = 1'd0;
	#5 reset = 1'd1;
	#5 reset = 1'd0;
	
	#10 DrawX = 10'd0;
	DrawY = 10'd0;
	
	
	for (int i = 0; i < 480; i++)
	begin
		for (int j = 0; j < 640; j++)
		begin
			#2 DrawX = j;
			DrawY = i;
		end
	end
	
	
	
end


endmodule
