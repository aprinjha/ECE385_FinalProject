//-------------------------------------------------------------------------
//                                                                       --
//                                                                       --
//      For use with ECE 385 Lab 8                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module lab8 (

      ///////// Clocks /////////
      input              Clk,

      ///////// KEY /////////
      input    [ 1: 0]   KEY,

      ///////// SW /////////
      input    [ 9: 0]   SW,

      ///////// LEDR /////////
      output   [ 9: 0]   LEDR,

      ///////// HEX /////////
      output   [ 7: 0]   HEX0,
      output   [ 7: 0]   HEX1,
      output   [ 7: 0]   HEX2,
      output   [ 7: 0]   HEX3,
      output   [ 7: 0]   HEX4,
      output   [ 7: 0]   HEX5,

      ///////// SDRAM /////////
      output             DRAM_CLK,
      output             DRAM_CKE,
      output   [12: 0]   DRAM_ADDR,
      output   [ 1: 0]   DRAM_BA,
      inout    [15: 0]   DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_UDQM,
      output             DRAM_CS_N,
      output             DRAM_WE_N,
      output             DRAM_CAS_N,
      output             DRAM_RAS_N,

      ///////// VGA /////////
      output             VGA_HS,
      output             VGA_VS,
      output   [ 3: 0]   VGA_R,
      output   [ 3: 0]   VGA_G,
      output   [ 3: 0]   VGA_B,


      ///////// ARDUINO /////////
      inout    [15: 0]   ARDUINO_IO,
      inout              ARDUINO_RESET_N 

);




logic Reset_h, vssig, blank, sync, VGA_Clk;


//=======================================================
//  REG/WIRE declarations
//=======================================================
	logic SPI0_CS_N, SPI0_SCLK, SPI0_MISO, SPI0_MOSI, USB_GPX, USB_IRQ, USB_RST;
	logic [3:0] hex_num_4, hex_num_3, hex_num_1, hex_num_0; //4 bit input hex digits
	logic [1:0] signs;
	logic [1:0] hundreds;
	logic [9:0] drawxsig, drawysig, ballxsig, ballysig, ballsizesig;
	logic [7:0] Red, Blue, Green;
	logic [7:0] keycode;

//=======================================================
//  Structural coding
//=======================================================
	assign ARDUINO_IO[10] = SPI0_CS_N;
	assign ARDUINO_IO[13] = SPI0_SCLK;
	assign ARDUINO_IO[11] = SPI0_MOSI;
	assign ARDUINO_IO[12] = 1'bZ;
	assign SPI0_MISO = ARDUINO_IO[12];
	
	assign ARDUINO_IO[9] = 1'bZ; 
	assign USB_IRQ = ARDUINO_IO[9];
		
	//Assignments specific to Circuits At Home UHS_20
	assign ARDUINO_RESET_N = USB_RST;
	assign ARDUINO_IO[7] = USB_RST;//USB reset 
	assign ARDUINO_IO[8] = 1'bZ; //this is GPX (set to input)
	assign USB_GPX = 1'b0;//GPX is not needed for standard USB host - set to 0 to prevent interrupt
	
	//Assign uSD CS to '1' to prevent uSD card from interfering with USB Host (if uSD card is plugged in)
	assign ARDUINO_IO[6] = 1'b1;
	
	//HEX drivers to convert numbers to HEX output
	HexDriver hex_driver4 (hex_num_4, HEX4[6:0]);
	assign HEX4[7] = 1'b1;
	
	HexDriver hex_driver3 (hex_num_3, HEX3[6:0]);
	assign HEX3[7] = 1'b1;
	
	HexDriver hex_driver1 (hex_num_1, HEX1[6:0]);
	assign HEX1[7] = 1'b1;
	
	HexDriver hex_driver0 (hex_num_0, HEX0[6:0]);
	assign HEX0[7] = 1'b1;
	
	//fill in the hundreds digit as well as the negative sign
	assign HEX5 = {1'b1, ~signs[1], 3'b111, ~hundreds[1], ~hundreds[1], 1'b1};
	assign HEX2 = {1'b1, ~signs[0], 3'b111, ~hundreds[0], ~hundreds[0], 1'b1};
	
	
	//Assign one button to reset
	assign {Reset_h}=~ (KEY[0]);

	//Our A/D converter is only 12 bit
	assign VGA_R = Red[7:4];
	assign VGA_B = Blue[7:4];
	assign VGA_G = Green[7:4];
	assign vssig = VGA_VS;
	
	
	Final_soc u0 (
		.clk_clk                           (Clk),            //clk.clk
		.reset_reset_n                     (1'b1),           //reset.reset_n
		.altpll_0_locked_conduit_export    (),               //altpll_0_locked_conduit.export
		.altpll_0_phasedone_conduit_export (),               //altpll_0_phasedone_conduit.export
		.altpll_0_areset_conduit_export    (),               //altpll_0_areset_conduit.export
		.key_external_connection_export    (KEY),            //key_external_connection.export

		//SDRAM
		.sdram_clk_clk(DRAM_CLK),                            //clk_sdram.clk
		.sdram_wire_addr(DRAM_ADDR),                         //sdram_wire.addr
		.sdram_wire_ba(DRAM_BA),                             //.ba
		.sdram_wire_cas_n(DRAM_CAS_N),                       //.cas_n
		.sdram_wire_cke(DRAM_CKE),                           //.cke
		.sdram_wire_cs_n(DRAM_CS_N),                         //.cs_n
		.sdram_wire_dq(DRAM_DQ),                             //.dq
		.sdram_wire_dqm({DRAM_UDQM,DRAM_LDQM}),              //.dqm
		.sdram_wire_ras_n(DRAM_RAS_N),                       //.ras_n
		.sdram_wire_we_n(DRAM_WE_N),                         //.we_n

		//USB SPI	
		.spi0_SS_n(SPI0_CS_N),
		.spi0_MOSI(SPI0_MOSI),
		.spi0_MISO(SPI0_MISO),
		.spi0_SCLK(SPI0_SCLK),
		
		//USB GPIO
		.usb_rst_export(USB_RST),
		.usb_irq_export(USB_IRQ),
		.usb_gpx_export(USB_GPX),
		
		//LEDs and HEX
		.hex_digits_export({hex_num_4, hex_num_3, hex_num_1, hex_num_0}),
		.leds_export({hundreds, signs, LEDR}),
		.keycode_export(keycode)

	 );
	 
logic [0:399] [4:0] mapData; 
logic [0:399] [4:0] currentMapData;

logic [0:9] playerX, playerY;

always_ff @ (posedge Clk)
begin
	if (KEY[0] == 1'd0)
	begin
		mapData <= {
				5'd5,5'd1,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd1,5'd1 ,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd1,5'd20,5'd20,5'd6,
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
				
	end
end


logic [4:0] collisionTile, currRow, currCol;
logic[9:0] playerWidth,playerHeight;
int playerScore;
logic [5:0] data_In;
logic [18:0] write_address, read_address;
logic we, mapReset, enemyOverlap;
logic [23:0] chestEmptyAnim0_data_Out, floor_1_data_out, wall_mid_data_out, imp_idle_anim_f1_data_out, imp_idle_anim_f2_data_out, wall_left_data_out, wall_right_data_out,floor_ladder_data_out,
					swamp_data_out_0,swamp_data_out_1, swamp_data_out_2, swamp_data_out_3, elf_data_out_0,elf_data_out_1,elf_data_out_2,elf_data_out_3, elf_data_out_4, elf_data_out_5, elf_data_out_6,
					elf_data_out_7, elf_data_out_8, 
					font_data_0, font_data_1, font_data_2, font_data_3, font_data_4, font_data_5, font_data_6, font_data_7, font_data_8, font_data_9;
					
//ram ram0(.address(ADDR[9:0]), .clock(Clk), .data(Data_to_SRAM),  .rden(OE), .wren(WE), .q(Data_from_SRAM));
chestEmptyAnim0 chest(	.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(chestEmptyAnim0_data_Out));
						
floor_1 floor(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(floor_1_data_out));

floor_ladder floor_ladder(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(floor_ladder_data_out));
						
wall_mid wall_mid(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(wall_mid_data_out));
						
wall_left wall_left(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(wall_left_data_out));

wall_right wall_right(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(wall_right_data_out));
					
imp_idle_anim_f1 imp_idle_anim_f1(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(imp_idle_anim_f1_data_out));
						
imp_idle_anim_f2 imp_idle_anim_f2(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(imp_idle_anim_f2_data_out));
						
swampy_idle_anim_f0 swampy_idle_anim_f0(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(swamp_data_out_0));

swampy_idle_anim_f1 swampy_idle_anim_f1(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(swamp_data_out_1));

swampy_idle_anim_f2 swampy_idle_anim_f2(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(swamp_data_out_2));
						
swampy_idle_anim_f3 swampy_idle_anim_f3(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(swamp_data_out_3));
						
elf_m_idle_anim_f0 elf_m_idle_anim_f0(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(elf_data_out_0));

elf_m_idle_anim_f1 elf_m_idle_anim_f1(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(elf_data_out_1));

elf_m_idle_anim_f2 elf_m_idle_anim_f2(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(elf_data_out_2));
						
elf_m_idle_anim_f3 elf_m_idle_anim_f3(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(elf_data_out_3));
						
elf_m_run_anim_f0 elf_m_run_anim_f0(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(elf_data_out_4));
						
elf_m_run_anim_f1 elf_m_run_anim_f1(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(elf_data_out_5));

elf_m_run_anim_f2 elf_m_run_anim_f2(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(elf_data_out_6));
	
elf_m_run_anim_f3 elf_m_run_anim_f3(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(elf_data_out_7));	
						
elf_m_hit_anim_f0 elf_m_hit_anim_f0(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(elf_data_out_8));
						
font_0 font_0(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(font_data_0));

font_1 font_1(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(font_data_1));
						
font_2 font_2(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(font_data_2));
						
font_3 font_3(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(font_data_3));	
	
font_4 font_4(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(font_data_4));
	
font_5 font_5(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(font_data_5));
	
font_6 font_6(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(font_data_6));
					
font_7 font_7(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(font_data_7));
					
font_8 font_8(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(font_data_8));
					
font_9 font_9(		.data_In,
						.write_address, .read_address(read_address),
						.we, .Clk,
						.data_Out(font_data_9));	
						
//instantiate a vga_controller, ball, and color_mapper here with the ports.
//assign mapData = 2500'd0;//mapData[0] = 5'd0;
vga_controller vga_controller_1 ( .Clk(Clk),            // 50 MHz clock
                                  .Reset(Reset_h),      // reset signal
                                  .hs(VGA_HS),          // Horizontal sync pulse.  Active low
								          .vs(VGA_VS),          // Vertical sync pulse.  Active low
										    .pixel_clk(VGA_Clk),  // 25 MHz pixel clock output
										    .blank(blank),        // Blanking interval indicator.  Active low.
										    .sync(sync),          // Composite Sync signal.  Active low.  We don't use it in this lab,
										 		                    //   but the video DAC on the DE2 board requires an input for it.
								          .DrawX(drawxsig),     // horizontal coordinate
								          .DrawY(drawysig) 

										   );		

ball ball_1	( .Reset(Reset_h), 
				  .frame_clk(vssig),  // We get VGA_VS as frame_clk as it determines every time a new screen comes whereas 
											  // VGA_HS shows new line
				  .keycode(keycode),
              .BallX(ballxsig),
				  .BallY(ballysig),
				  .BallS(ballsizesig) 
				 );	
				 
				 
mapManager mapManager0(.Clk, .reset(KEY[0]), .inputTest(KEY[1]), .inMapData(mapData) , .outMapData(currentMapData), .DrawX(drawxsig), .DrawY(drawysig), .collisionTile, 
								.mapReset, .playerCurrRow(currRow), .playerCurrCol(currCol), .enemyOverlap, .playerScore);


playerManager player0(.Clk, .frameClk(vssig), .reset(!KEY[0] || mapReset), .inMapData(currentMapData), .keycode(keycode), .DrawX(drawxsig), .DrawY(drawysig), .playerX, .playerY,
								.playerWidth, .playerHeight, .collisionTile, .enemyOverlap, .currRow, .currCol, .playerScore);

color_mapper color_1 ( 	.reset(KEY[0]),
								.DrawX(drawxsig), 
								.DrawY(drawysig),
								.Clk, .inMapData(currentMapData),  .readAddress(read_address),
								.playerX, .playerY, .playerWidth, .playerHeight,
								.keycode(keycode),
								.chestEmptyAnim0_data_Out,
								.Red(Red),
								.Green(Green),
								.Blue(Blue),
								.floor_1_data_out,
								.floor_ladder_data_out,
								.wall_mid_data_out,
								.wall_left_data_out,
								.wall_right_data_out,
								.imp_idle_anim_f1_data_out,
							   .imp_idle_anim_f2_data_out,
								.swamp_data_out_0,
								.swamp_data_out_1,
								.swamp_data_out_2,
								.swamp_data_out_3,
								.elf_data_out_0,
								.elf_data_out_1,
								.elf_data_out_2,
								.elf_data_out_3,
								.elf_data_out_4,
								.elf_data_out_5,
								.elf_data_out_6,
								.elf_data_out_7,
								.elf_data_out_8,
								.font_data_0,
                        .font_data_1,
                        .font_data_2,
								.font_data_3,
                        .font_data_4,
                        .font_data_5,
                        .font_data_6,
                        .font_data_7,
                        .font_data_8,
                        .font_data_9);
								
endmodule
