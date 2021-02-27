/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  chestEmptyAnim0
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/chest_empty_open_anim_f0.png.txt", mem);
	 //$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/chest_empty_open_anim_f0.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule



module  floor_1
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/floor_1.png.txt", mem);
	 //$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/floor_1.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule



module  wall_mid
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/wall_mid.png.txt", mem);
	 //$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/wall_mid.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module  wall_left
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/wall_corner_left.png.txt", mem);
	 //$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/wall_corner_left.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module  wall_right
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/wall_corner_right.png.txt", mem);
	 //$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/wall_corner_right.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule



module  imp_idle_anim_f1
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/imp_idle_anim_f1.png.txt", mem);
	 //$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/imp_idle_anim_f1.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module  imp_idle_anim_f2
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/imp_idle_anim_f2.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/imp_idle_anim_f2.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module  floor_ladder
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/floor_ladder.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/floor_ladder.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule



module  swampy_idle_anim_f0
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/swampy_idle_anim_f0.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/swampy_idle_anim_f0.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module  swampy_idle_anim_f1
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/swampy_idle_anim_f1.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/swampy_idle_anim_f1.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module  swampy_idle_anim_f2
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/swampy_idle_anim_f2.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/swampy_idle_anim_f2.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module  swampy_idle_anim_f3
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/swampy_idle_anim_f3.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/swampy_idle_anim_f3.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule


module  elf_m_idle_anim_f0
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/elf_m_idle_anim_f0.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/elf_m_idle_anim_f0.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module  elf_m_idle_anim_f1
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/elf_m_idle_anim_f1.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/elf_m_idle_anim_f1.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module  elf_m_idle_anim_f2
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/elf_m_idle_anim_f2.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/elf_m_idle_anim_f2.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module  elf_m_idle_anim_f3
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/elf_m_idle_anim_f3.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/elf_m_idle_anim_f3.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module elf_m_run_anim_f0
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/elf_m_run_anim_f0.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/elf_m_run_anim_f0.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module elf_m_run_anim_f1
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/elf_m_run_anim_f1.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/elf_m_run_anim_f1.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module elf_m_run_anim_f2
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/elf_m_run_anim_f2.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/elf_m_run_anim_f2.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module elf_m_run_anim_f3
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/elf_m_run_anim_f3.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/elf_m_run_anim_f3.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module elf_m_hit_anim_f0
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/elf_m_hit_anim_f0.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/elf_m_hit_anim_f0.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule




module font_1
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/image_18_1.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/image_18_1.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module font_2
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/image_19_1.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/image_19_1.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module font_3
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/image_20_1.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/image_20_1.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module font_4
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/image_21_1.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/image_21_1.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module font_5
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/image_22_1.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/image_22_1.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module font_6
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/image_23_1.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/image_23_1.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module font_7
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/image_24_1.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/image_24_1.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule
module font_8
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/image_25_1.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/image_25_1.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module font_9
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/image_26_1.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/image_26_1.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module font_0
(
		input [5:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 256 addresses
logic [23:0] mem [0:255];

initial
begin
	 $readmemh("C:/Users/hobbs/Documents/UIUC/ECE/ECE_385/Final_Project/Assets/image_17_1.png.txt", mem);
	//$readmemh("D:/Fall_2020/ECE_385/Final_Project/Assets/image_17_1.png.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule
