`timescale 1 ps / 1 ps

module VGA_display(clk1,
				   clk,
				   reset,
				   level,
				   ps2_byte,
				   ps2_state,
                   RED,GRN,BLU,
				   hortional_counter,
				   vertiacl_counter,score);

input clk,clk1,reset,score;
input [7:0]ps2_byte;
input ps2_state;
reg ps2state;
reg gameover;
input [9:0]hortional_counter;
input [9:0] vertiacl_counter;
output RED,GRN,BLU;
wire [2:0]RGBx;
wire RED,GRN,BLU;

reg [2:0]RGB_top;
reg [2:0]RGB;
reg [7:0]tmpbytes;

assign {BLU,GRN,RED} = RGB_top;

always @(hortional_counter, vertiacl_counter)
begin
   if(hortional_counter>= 0 && hortional_counter <= 540)
    RGB_top = RGB;
   else
	RGB_top = RGBx;
end

/*******************custom blocks,board  and ball**************************/

parameter x_left = 0,x_right = 540;
parameter y_up   = 0,y_down = 480;


//custom board
parameter board_centerx = 250,half_board_width = 55,board_width = 110;
parameter board_centery = 470,half_board_height = 10,board_height = 20;
parameter board_speed = 1;
reg [9:0]board_cx,board_cy;

always @(posedge clk or posedge reset)
begin
	if(reset)
		begin 
			board_cx <= board_centerx;
			board_cy <= board_centery; 
		end
	else
		begin
			if(ps2_state)
				tmpbytes = ps2_byte;
			else
				tmpbytes = 8'b0;
			if(tmpbytes == "A")
				begin
					if(board_cx <= half_board_width - x_left) 
						board_cx <= board_cx;
					else 
						board_cx <= board_cx - 1;
				end
			else if(tmpbytes == "D")
				begin
					if(board_cx >= x_right - half_board_width)
						board_cx <= board_cx;
					else 
						board_cx <= board_cx + 1;	
				end
			else
				board_cx <= board_cx;
		end
end

  
/********************all blocks************************************
	1--2--3--4--5--6--7
	|				  |
	8-----------------9
	|				  |
	10----------------11
	|				  |
	12-13-14-15-16-17-18
******************************************************************/

parameter blk1_l = 60,   	blk1_r = 118 , 			blk1_u = 30 		,blk1_d = 	 58;
parameter blk2_l = 2*60, 	blk2_r = 118 +60 , 		blk2_u = 30 		,blk2_d = 	 58;
parameter blk3_l = 3*60, 	blk3_r = 118 +60*2, 	blk3_u = 30 		,blk3_d =	 58;
parameter blk4_l = 4*60,	blk4_r = 118 +60*3, 	blk4_u = 30 		,blk4_d = 	 58;
parameter blk5_l = 5*60, 	blk5_r = 118 +60*4, 	blk5_u = 30 		,blk5_d = 	 58;
parameter blk6_l = 6*60, 	blk6_r = 118 +60*5, 	blk6_u = 30 		,blk6_d = 	 58;
parameter blk7_l = 7*60, 	blk7_r = 118 +60*6, 	blk7_u = 30 		,blk7_d = 	 58;
parameter blk8_l = 60,   	blk8_r = 118 , 			blk8_u = 2*30 		,blk8_d =   58+30;
parameter blk9_l = 7*60, 	blk9_r = 118 +60*6, 	blk9_u = 2*30 		,blk9_d =   58+30;
parameter blk10_l = 60,  	blk10_r = 118 , 		blk10_u = 3*30 		,blk10_d = 58+2*30;
parameter blk11_l = 7*60,	blk11_r = 118 +60*6, 	blk11_u = 3*30 		,blk11_d = 58+2*30;
parameter blk12_l = 60,  	blk12_r = 118 , 		blk12_u = 4*30 		,blk12_d = 58+3*30;
parameter blk13_l = 2*60,	blk13_r = 118 +60, 		blk13_u = 4*30 		,blk13_d = 58+3*30;
parameter blk14_l = 3*60,	blk14_r = 118 +60*2, 	blk14_u = 4*30 		,blk14_d = 58+3*30;
parameter blk15_l = 4*60,	blk15_r = 118 +60*3, 	blk15_u = 4*30 		,blk15_d = 58+3*30;
parameter blk16_l = 5*60,	blk16_r = 118 +60*4, 	blk16_u = 4*30 		,blk16_d = 58+3*30;
parameter blk17_l = 6*60,	blk17_r = 118 +60*5, 	blk17_u = 4*30 		,blk17_d = 58+3*30;
parameter blk18_l = 7*60,	blk18_r = 118 +60*6, 	blk18_u = 4*30 		,blk18_d = 58+3*30;



reg[8:0]block1_l,block1_r,block1_u,block1_d;
reg[8:0]block2_l,block2_r,block2_u,block2_d;
reg[8:0]block3_l,block3_r,block3_u,block3_d;
reg[8:0]block4_l,block4_r,block4_u,block4_d;
reg[8:0]block5_l,block5_r,block5_u,block5_d;
reg[8:0]block6_l,block6_r,block6_u,block6_d;
reg[8:0]block7_l,block7_r,block7_u,block7_d;
reg[8:0]block8_l,block8_r,block8_u,block8_d;
reg[8:0]block9_l,block9_r,block9_u,block9_d;
reg[8:0]block10_l,block10_r,block10_u,block10_d;
reg[8:0]block11_l,block11_r,block11_u,block11_d;
reg[8:0]block12_l,block12_r,block12_u,block12_d;
reg[8:0]block13_l,block13_r,block13_u,block13_d;
reg[8:0]block14_l,block14_r,block14_u,block14_d;
reg[8:0]block15_l,block15_r,block15_u,block15_d;
reg[8:0]block16_l,block16_r,block16_u,block16_d;
reg[8:0]block17_l,block17_r,block17_u,block17_d;
reg[8:0]block18_l,block18_r,block18_u,block18_d;

//ball parameter
reg [9:0]ball_centerx,ball_centery;
reg ball_xdir,ball_ydir;
parameter ball_r = 10;
parameter speed = 1,flag_up = 0,flag_down = 1,flag_left = 0,flag_right = 1;
reg [17:0] blk_state = 18'b111111111111111111;

/**************Main Logic****************/
always @(posedge clk or posedge reset)
begin
	if(reset)
		begin
			blk_state = 18'b111111111111111111;
			ball_xdir <= flag_right;
			ball_ydir <= flag_down;
			block1_l <= blk1_l;block1_r = blk1_r;block1_u = blk1_u;block1_d = blk1_d;
			block2_l <= blk2_l;block2_r = blk2_r;block2_u = blk2_u;block2_d = blk2_d;
			block3_l <= blk3_l;block3_r = blk3_r;block3_u = blk3_u;block3_d = blk3_d;
			block4_l <= blk4_l;block4_r = blk4_r;block4_u = blk4_u;block4_d = blk4_d;
			block5_l <= blk5_l;block5_r = blk5_r;block5_u = blk5_u;block5_d = blk5_d;
			block6_l <= blk6_l;block6_r = blk6_r;block6_u = blk6_u;block6_d = blk6_d;
			block7_l <= blk7_l;block7_r = blk7_r;block7_u = blk7_u;block7_d = blk7_d;
			block8_l <= blk8_l;block8_r = blk8_r;block8_u = blk8_u;block8_d = blk8_d;
			block9_l <= blk9_l;block9_r = blk9_r;block9_u = blk9_u;block9_d = blk9_d;
			block10_l <= blk10_l;block10_r = blk10_r;block10_u = blk10_u;block10_d = blk10_d;
			block11_l <= blk11_l;block11_r = blk11_r;block11_u = blk11_u;block11_d = blk11_d;
			block12_l <= blk12_l;block12_r = blk12_r;block12_u = blk12_u;block12_d = blk12_d;
			block13_l <= blk13_l;block13_r = blk13_r;block13_u = blk13_u;block13_d = blk13_d;
			block14_l <= blk14_l;block14_r = blk14_r;block14_u = blk14_u;block14_d = blk14_d;
			block15_l <= blk15_l;block15_r = blk15_r;block15_u = blk15_u;block15_d = blk15_d;
			block16_l <= blk16_l;block16_r = blk16_r;block16_u = blk16_u;block16_d = blk16_d;
			block17_l <= blk17_l;block17_r = blk17_r;block17_u = blk17_u;block17_d = blk17_d;
			block18_l <= blk18_l;block18_r = blk18_r;block18_u = blk18_u;block18_d = blk18_d;
		end
	else if((ball_centerx - ball_r) == x_left)
		ball_xdir <= flag_right;
	else if((ball_centerx + ball_r) == x_right)
		ball_xdir <= flag_left;
	else if((ball_centery - ball_r) == y_up)
		ball_ydir <= flag_down;
	else if((ball_centery + ball_r) == y_down)
		ball_ydir <= flag_up;
	else if(ball_centery <= (y_down - ball_r - board_width))
		begin
			if(ball_centery == (y_down - ball_r - board_width)&&(board_cx - ball_centerx) <= half_board_width && 
			  (ball_centerx - board_cx) <= half_board_width)
				ball_ydir <= flag_up;
			else if(ball_centerx == (y_down - ball_r))
				begin
					if((ball_centerx + ball_r) == (board_cx - half_board_width))
						ball_xdir <= flag_left;
					else if((ball_centerx - ball_r) == (board_cx + half_board_width))
						ball_xdir <= flag_right;
					else
						gameover <= 1;
				end
			else
				gameover <= 1;
		end
	//bounce the bottom
	else if((ball_centery - ball_r) == blk18_d)
			begin 
				ball_ydir <= flag_down;
				if(blk12_l <= ball_centerx && blk12_r >= ball_centerx && blk_state[11])
					begin
						block12_l <= 9999;block12_r <= 9999;block12_u <= 9999;block12_d <= 9999;
						blk_state[11] = 0;
					end
				else if(blk13_l <= ball_centerx && blk13_r >= ball_centerx && blk_state[12])
					begin
						block13_l <= 9999;block13_r <= 9999;block13_u <= 9999;block13_d <= 9999;
						blk_state[12] = 0;
					end
				else if(blk14_l <= ball_centerx && blk14_r >= ball_centerx && blk_state[13])
					begin
						block14_l <= 9999;block14_r <= 9999;block14_u <= 9999;block14_d <= 9999;
						blk_state[13] = 0;
					end
				else if(blk15_l <= ball_centerx && blk15_r >= ball_centerx && blk_state[14])
					begin
						blk_state[14] = 0;
						block15_l <= 9999;block15_r <= 9999;block15_u <= 9999;block15_d <= 9999;
					end	
				else if(blk16_l <= ball_centerx && blk16_r >= ball_centerx && blk_state[15])
					begin
						blk_state[15] = 0;
						block16_l <= 9999;block16_r <= 9999;block16_u <= 9999;block16_d <= 9999;
					end	
				else if(blk17_l <= ball_centerx && blk17_r >= ball_centerx && blk_state[16])
					begin
						blk_state[16] = 0;
						block17_l <= 9999;block17_r <= 9999;block17_u <= 9999;block17_d <= 9999;
					end	
				else if(blk18_l <= ball_centerx && blk18_r >= ball_centerx && blk_state[17])
					begin
						blk_state[17] = 0;
						block18_l <= 9999;block18_r <= 9999;block18_u <= 9999;block18_d <= 9999;
					end
			end
	else if((ball_centery - ball_r) == blk10_d)
			begin 
				ball_ydir <= flag_down;
				if(blk10_l <= ball_centerx && blk10_r >= ball_centerx && blk_state[9])
					begin
						blk_state[9] = 0;
						block10_l <= 9999;block10_r <= 9999;block10_u <= 9999;block10_d <= 9999;
					end
				else if(blk11_l <= ball_centerx && blk11_r >= ball_centerx && blk_state[10])
					begin
						blk_state[10] = 0;
						block11_l <= 9999;block11_r <= 9999;block11_u <= 9999;block11_d <= 9999;
					end
			end
	else if((ball_centery - ball_r) == blk8_d)
			begin 
				ball_ydir <= flag_down;
				if(blk8_l <= ball_centerx && blk8_r >= ball_centerx && blk_state[7])
					begin
						blk_state[7] = 0;
						block8_l <= 9999;block8_r <= 9999;block8_u <= 9999;block8_d <= 9999;
					end	
				else if(blk9_l <= ball_centerx && blk9_r >= ball_centerx && blk_state[8])
					begin
						blk_state[8] = 0;
						block9_l <= 9999;block9_r <= 9999;block9_u <= 9999;block9_d <= 9999;
					end
			end
	else if((ball_centery - ball_r) == blk1_d)
			begin 
				ball_ydir <= flag_down;
				if(blk1_l <= ball_centerx && blk1_r >= ball_centerx && blk_state[0])
					begin
						blk_state[0] = 0;
						block1_l <= 9999;block1_r <= 9999;block1_u <= 9999;block1_d <= 9999;
					end
				else if(blk3_l <= ball_centerx && blk3_r >= ball_centerx && blk_state[2])
					begin
						blk_state[2] = 0;
						block3_l <= 9999;block3_r <= 9999;block3_u <= 9999;block3_d <= 9999;
					end
				else if(blk4_l <= ball_centerx && blk4_r >= ball_centerx && blk_state[3])
					begin
						blk_state[3] = 0;
						block4_l <= 9999;block4_r <= 9999;block4_u <= 9999;block4_d <= 9999;
					end
				else if(blk5_l <= ball_centerx && blk5_r >= ball_centerx && blk_state[4])
					begin
						blk_state[4] = 0;
						block5_l <= 9999;block5_r <= 9999;block5_u <= 9999;block5_d <= 9999;
					end
				else if(blk6_l <= ball_centerx && blk6_r >= ball_centerx && blk_state[5])
					begin
						blk_state[5] = 0;
						block6_l <= 9999;block6_r <= 9999;block6_u <= 9999;block6_d <= 9999;
					end
				else if(blk7_l <= ball_centerx && blk7_r >= ball_centerx && blk_state[6])
					begin
						blk_state[6] = 0;
						block7_l <= 9999;block7_r <= 9999;block7_u <= 9999;block7_d <= 9999;
					end
				else if(blk2_l <= ball_centerx && blk2_r >= ball_centerx && blk_state[1])
					begin
						blk_state[1] = 0;
						block2_l <= 9999;block2_r <= 9999;block2_u <= 9999;block2_d <= 9999;
					end
			end
	//bounce the upside
	else if((ball_centery + ball_r) == blk18_u)
			begin 
				ball_ydir <= flag_up;
				if(blk12_l <= ball_centerx && blk12_r >= ball_centerx && blk_state[11])
					begin
						block12_l <= 9999;block12_r <= 9999;block12_u <= 9999;block12_d <= 9999;
						blk_state[11] = 0;
					end
				else if(blk13_l <= ball_centerx && blk13_r >= ball_centerx && blk_state[12])
					begin
						block13_l <= 9999;block13_r <= 9999;block13_u <= 9999;block13_d <= 9999;
						blk_state[12] = 0;
					end
				else if(blk14_l <= ball_centerx && blk14_r >= ball_centerx && blk_state[13])
					begin
						block14_l <= 9999;block14_r <= 9999;block14_u <= 9999;block14_d <= 9999;
						blk_state[13] = 0;
					end
				else if(blk15_l <= ball_centerx && blk15_r >= ball_centerx && blk_state[14])
					begin
						blk_state[14] = 0;
						block15_l <= 9999;block15_r <= 9999;block15_u <= 9999;block15_d <= 9999;
					end	
				else if(blk16_l <= ball_centerx && blk16_r >= ball_centerx && blk_state[15])
					begin
						blk_state[15] = 0;
						block16_l <= 9999;block16_r <= 9999;block16_u <= 9999;block16_d <= 9999;
					end	
				else if(blk17_l <= ball_centerx && blk17_r >= ball_centerx && blk_state[16])
					begin
						blk_state[16] = 0;
						block17_l <= 9999;block17_r <= 9999;block17_u <= 9999;block17_d <= 9999;
					end	
				else if(blk18_l <= ball_centerx && blk18_r >= ball_centerx && blk_state[17])
					begin
						blk_state[17] = 0;
						block18_l <= 9999;block18_r <= 9999;block18_u <= 9999;block18_d <= 9999;
					end
			end
	else if((ball_centery + ball_r) == blk10_u)
			begin 
				ball_ydir <= flag_down;
				if(blk10_l <= ball_centerx && blk10_r >= ball_centerx && blk_state[9])
					begin
						blk_state[9] = 0;
						block10_l <= 9999;block10_r <= 9999;block10_u <= 9999;block10_d <= 9999;
					end
				else if(blk11_l <= ball_centerx && blk11_r >= ball_centerx && blk_state[10])
					begin
						blk_state[10] = 0;
						block11_l <= 9999;block11_r <= 9999;block11_u <= 9999;block11_d <= 9999;
					end
			end
	else if((ball_centery + ball_r) == blk8_u)
			begin 
				ball_ydir <= flag_down;
				if(blk8_l <= ball_centerx && blk8_r >= ball_centerx && blk_state[7])
					begin
						blk_state[7] = 0;
						block8_l <= 9999;block8_r <= 9999;block8_u <= 9999;block8_d <= 9999;
					end	
				else if(blk9_l <= ball_centerx && blk9_r >= ball_centerx && blk_state[8])
					begin
						blk_state[8] = 0;
						block9_l <= 9999;block9_r <= 9999;block9_u <= 9999;block9_d <= 9999;
					end
			end
	else if((ball_centery + ball_r) == blk1_u)
			begin 
				ball_ydir <= flag_down;
				if(blk1_l <= ball_centerx && blk1_r >= ball_centerx && blk_state[0])
					begin
						blk_state[0] = 0;
						block1_l <= 9999;block1_r <= 9999;block1_u <= 9999;block1_d <= 9999;
					end
				else if(blk3_l <= ball_centerx && blk3_r >= ball_centerx && blk_state[2])
					begin
						blk_state[2] = 0;
						block3_l <= 9999;block3_r <= 9999;block3_u <= 9999;block3_d <= 9999;
					end
				else if(blk4_l <= ball_centerx && blk4_r >= ball_centerx && blk_state[3])
					begin
						blk_state[3] = 0;
						block4_l <= 9999;block4_r <= 9999;block4_u <= 9999;block4_d <= 9999;
					end
				else if(blk5_l <= ball_centerx && blk5_r >= ball_centerx && blk_state[4])
					begin
						blk_state[4] = 0;
						block5_l <= 9999;block5_r <= 9999;block5_u <= 9999;block5_d <= 9999;
					end
				else if(blk6_l <= ball_centerx && blk6_r >= ball_centerx && blk_state[5])
					begin
						blk_state[5] = 0;
						block6_l <= 9999;block6_r <= 9999;block6_u <= 9999;block6_d <= 9999;
					end
				else if(blk7_l <= ball_centerx && blk7_r >= ball_centerx && blk_state[6])
					begin
						blk_state[6] = 0;
						block7_l <= 9999;block7_r <= 9999;block7_u <= 9999;block7_d <= 9999;
					end
				else if(blk2_l <= ball_centerx && blk2_r >= ball_centerx && blk_state[1])
					begin
						blk_state[1] = 0;
						block2_l <= 9999;block2_r <= 9999;block2_u <= 9999;block2_d <= 9999;
					end
			end
	//bounce the left 
	else if((ball_centerx + ball_r) == blk1_l)		//1,8,10,12
		begin
			ball_xdir <= flag_left;
				if(blk12_u <= ball_centerx && blk12_d >= ball_centerx && blk_state[11])
					begin
						block12_l <= 9999;block12_r <= 9999;block12_u <= 9999;block12_d <= 9999;
						blk_state[11] = 0;
					end
				else if(blk10_u <= ball_centerx && blk10_d >= ball_centerx && blk_state[9])
					begin
						block10_l <= 9999;block10_r <= 9999;block10_u <= 9999;block10_d <= 9999;
						blk_state[9] = 0;
					end
				else if(blk8_u <= ball_centerx && blk18_d >= ball_centerx && blk_state[7])
					begin
						block8_l <= 9999;block8_r <= 9999;block8_u <= 9999;block8_d <= 9999;
						blk_state[7] = 0;
					end
				else if(blk1_u <= ball_centerx && blk1_d >= ball_centerx && blk_state[0])
					begin
						block1_l <= 9999;block1_r <= 9999;block1_u <= 9999;block1_d <= 9999;
						blk_state[0] = 0;
					end
		end
	else if((ball_centerx + ball_r) == blk2_l)				//2,13
		begin
			ball_xdir <= flag_left;
				if(blk2_u <= ball_centerx && blk2_d >= ball_centerx && blk_state[1])
					begin
						block2_l <= 9999;block2_r <= 9999;block2_u <= 9999;block2_d <= 9999;
						blk_state[1] = 0;
					end
				else if(blk13_u <= ball_centerx && blk13_d >= ball_centerx && blk_state[12])
					begin
						block13_l <= 9999;block13_r <= 9999;block13_u <= 9999;block13_d <= 9999;
						blk_state[12] = 0;
					end
		end
	else if((ball_centerx + ball_r) == blk3_l)				//3,14
		begin
			ball_xdir <= flag_left;
				if(blk3_u <= ball_centerx && blk3_d >= ball_centerx && blk_state[2])
					begin
						block3_l <= 9999;block3_r <= 9999;block3_u <= 9999;block3_d <= 9999;
						blk_state[1] = 0;
					end
				else if(blk14_u <= ball_centerx && blk14_d >= ball_centerx && blk_state[13])
					begin
						block14_l <= 9999;block14_r <= 9999;block14_u <= 9999;block14_d <= 9999;
						blk_state[13] = 0;
					end
		end
	else if((ball_centerx + ball_r) == blk4_l)				//4,15
		begin
			ball_xdir <= flag_left;
				if(blk4_u <= ball_centerx && blk4_d >= ball_centerx && blk_state[3])
					begin
						block4_l <= 9999;block4_r <= 9999;block4_u <= 9999;block4_d <= 9999;
						blk_state[3] = 0;
					end
				else if(blk15_u <= ball_centerx && blk15_d >= ball_centerx && blk_state[14])
					begin
						block15_l <= 9999;block15_r <= 9999;block15_u <= 9999;block15_d <= 9999;
						blk_state[14] = 0;
					end
		end
	else if((ball_centerx + ball_r) == blk5_l)				//5,16
		begin
			ball_xdir <= flag_left;
				if(blk5_u <= ball_centerx && blk5_d >= ball_centerx && blk_state[4])
					begin
						block5_l <= 9999;block5_r <= 9999;block5_u <= 9999;block5_d <= 9999;
						blk_state[3] = 0;
					end
				else if(blk16_u <= ball_centerx && blk16_d >= ball_centerx && blk_state[15])
					begin
						block16_l <= 9999;block16_r <= 9999;block16_u <= 9999;block16_d <= 9999;
						blk_state[15] = 0;
					end
		end
	else if((ball_centerx + ball_r) == blk6_l)				//6,17
		begin
			ball_xdir <= flag_left;
				if(blk6_u <= ball_centerx && blk6_d >= ball_centerx && blk_state[5])
					begin
						block6_l <= 9999;block6_r <= 9999;block6_u <= 9999;block6_d <= 9999;
						blk_state[5] = 0;
					end
				else if(blk15_u <= ball_centerx && blk15_d >= ball_centerx && blk_state[16])
					begin
						block17_l <= 9999;block17_r <= 9999;block17_u <= 9999;block17_d <= 9999;
						blk_state[16] = 0;
					end
		end
	else if((ball_centerx + ball_r) == blk18_l)				//7,9,11,18
		begin
			ball_xdir <= flag_left;
				if(blk11_u <= ball_centerx && blk11_d >= ball_centerx && blk_state[10])
					begin
						block11_l <= 9999;block12_r <= 9999;block11_u <= 9999;block11_d <= 9999;
						blk_state[10] = 0;
					end
				else if(blk9_u <= ball_centerx && blk9_d >= ball_centerx && blk_state[8])
					begin
						block9_l <= 9999;block9_r <= 9999;block9_u <= 9999;block9_d <= 9999;
						blk_state[8] = 0;
					end
				else if(blk18_u <= ball_centerx && blk18_d >= ball_centerx && blk_state[17])
					begin
						block18_l <= 9999;block18_r <= 9999;block18_u <= 9999;block18_d <= 9999;
						blk_state[17] = 0;
					end
				else if(blk7_u <= ball_centerx && blk7_d >= ball_centerx && blk_state[6])
					begin
						block7_l <= 9999;block7_r <= 9999;block7_u <= 9999;block7_d <= 9999;
						blk_state[6] = 0;
					end
		end
	//bounce the right
	else if((ball_centerx - ball_r) == blk1_r)		//1,8,10,12
		begin
			ball_xdir <= flag_right;
				if(blk12_u <= ball_centerx && blk12_d >= ball_centerx && blk_state[11])
					begin
						block12_l <= 9999;block12_r <= 9999;block12_u <= 9999;block12_d <= 9999;
						blk_state[11] = 0;
					end
				else if(blk10_u <= ball_centerx && blk10_d >= ball_centerx && blk_state[9])
					begin
						block10_l <= 9999;block10_r <= 9999;block10_u <= 9999;block10_d <= 9999;
						blk_state[9] = 0;
					end
				else if(blk8_u <= ball_centerx && blk18_d >= ball_centerx && blk_state[7])
					begin
						block8_l <= 9999;block8_r <= 9999;block8_u <= 9999;block8_d <= 9999;
						blk_state[7] = 0;
					end
				else if(blk1_u <= ball_centerx && blk1_d >= ball_centerx && blk_state[0])
					begin
						block1_l <= 9999;block1_r <= 9999;block1_u <= 9999;block1_d <= 9999;
						blk_state[0] = 0;
					end
		end
	else if((ball_centerx - ball_r) == blk2_r)				//2,13
		begin
			ball_xdir <= flag_right;
				if(blk2_u <= ball_centerx && blk2_d >= ball_centerx && blk_state[1])
					begin
						block2_l <= 9999;block2_r <= 9999;block2_u <= 9999;block2_d <= 9999;
						blk_state[1] = 0;
					end
				else if(blk13_u <= ball_centerx && blk13_d >= ball_centerx && blk_state[12])
					begin
						block13_l <= 9999;block13_r <= 9999;block13_u <= 9999;block13_d <= 9999;
						blk_state[12] = 0;
					end
		end
	else if((ball_centerx - ball_r) == blk3_r)				//3,14
		begin
			ball_xdir <= flag_right;
				if(blk3_u <= ball_centerx && blk3_d >= ball_centerx && blk_state[2])
					begin
						block3_l <= 9999;block3_r <= 9999;block3_u <= 9999;block3_d <= 9999;
						blk_state[1] = 0;
					end
				else if(blk14_u <= ball_centerx && blk14_d >= ball_centerx && blk_state[13])
					begin
						block14_l <= 9999;block14_r <= 9999;block14_u <= 9999;block14_d <= 9999;
						blk_state[13] = 0;
					end
		end
	else if((ball_centerx - ball_r) == blk4_r)				//4,15
		begin
			ball_xdir <= flag_left;
				if(blk4_u <= ball_centerx && blk4_d >= ball_centerx && blk_state[3])
					begin
						block4_l <= 9999;block4_r <= 9999;block4_u <= 9999;block4_d <= 9999;
						blk_state[3] = 0;
					end
				else if(blk15_u <= ball_centerx && blk15_d >= ball_centerx && blk_state[14])
					begin
						block15_l <= 9999;block15_r <= 9999;block15_u <= 9999;block15_d <= 9999;
						blk_state[14] = 0;
					end
		end
	else if((ball_centerx - ball_r) == blk5_r)				//5,16
		begin
			ball_xdir <= flag_left;
				if(blk5_u <= ball_centerx && blk5_d >= ball_centerx && blk_state[4])
					begin
						block5_l <= 9999;block5_r <= 9999;block5_u <= 9999;block5_d <= 9999;
						blk_state[3] = 0;
					end
				else if(blk16_u <= ball_centerx && blk16_d >= ball_centerx && blk_state[15])
					begin
						block16_l <= 9999;block16_r <= 9999;block16_u <= 9999;block16_d <= 9999;
						blk_state[15] = 0;
					end
		end
	else if((ball_centerx - ball_r) == blk6_r)				//6,17
		begin
			ball_xdir <= flag_left;
				if(blk6_u <= ball_centerx && blk6_d >= ball_centerx && blk_state[5])
					begin
						block6_l <= 9999;block6_r <= 9999;block6_u <= 9999;block6_d <= 9999;
						blk_state[5] = 0;
					end
				else if(blk15_u <= ball_centerx && blk15_d >= ball_centerx && blk_state[16])
					begin
						block17_l <= 9999;block17_r <= 9999;block17_u <= 9999;block17_d <= 9999;
						blk_state[16] = 0;
					end
		end
	else if((ball_centerx - ball_r) == blk18_r)				//7,9,11,18
		begin
			ball_xdir <= flag_right;
				if(blk11_u <= ball_centerx && blk11_d >= ball_centerx && blk_state[10])
					begin
						block11_l <= 9999;block12_r <= 9999;block11_u <= 9999;block11_d <= 9999;
						blk_state[10] = 0;
					end
				else if(blk9_u <= ball_centerx && blk9_d >= ball_centerx && blk_state[8])
					begin
						block9_l <= 9999;block9_r <= 9999;block9_u <= 9999;block9_d <= 9999;
						blk_state[8] = 0;
					end
				else if(blk18_u <= ball_centerx && blk18_d >= ball_centerx && blk_state[17])
					begin
						block18_l <= 9999;block18_r <= 9999;block18_u <= 9999;block18_d <= 9999;
						blk_state[17] = 0;
					end
				else if(blk7_u <= ball_centerx && blk7_d >= ball_centerx && blk_state[6])
					begin
						block7_l <= 9999;block7_r <= 9999;block7_u <= 9999;block7_d <= 9999;
						blk_state[6] = 0;
					end
		end
	else
		begin
			ball_xdir <= ball_xdir;
			ball_ydir <= ball_ydir;
		end
end


always @(posedge clk or posedge reset)
begin
	if(reset)
		ball_centerx <= 270;
	else if(ball_xdir)
		ball_centerx <= ball_centerx+1;
	else 
		ball_centerx <= ball_centerx-1;
end
   
always @(posedge clk or posedge reset )
begin
	if(reset)
		ball_centery <= 450; 
    else if(ball_ydir)
		ball_centery <= ball_centery + 1;
	else
		ball_centery <= ball_centery - 1;
end


reg [31:0] Ball;
always @(*)
begin
	Ball=((hortional_counter-ball_centerx)*(hortional_counter-ball_centerx)+(vertiacl_counter-ball_centery)*(vertiacl_counter-ball_centery));
	if(Ball <= 100)
		RGB = 3'b101;
	else if(board_cx - half_board_width <= hortional_counter && hortional_counter <= board_cx + half_board_width &&
			board_cy - half_board_height <= vertiacl_counter && vertiacl_counter <= board_cy + half_board_height)
		RGB = 3'b011;
	else if(hortional_counter <= block1_r && hortional_counter >= block1_l && vertiacl_counter <= block1_d && vertiacl_counter >= block1_u ||
			hortional_counter <= block2_r && hortional_counter >= block2_l && vertiacl_counter <= block2_d && vertiacl_counter >= block2_u ||
			hortional_counter <= block3_r && hortional_counter >= block3_l && vertiacl_counter <= block3_d && vertiacl_counter >= block3_u ||
			hortional_counter <= block4_r && hortional_counter >= block4_l && vertiacl_counter <= block4_d && vertiacl_counter >= block4_u ||
			hortional_counter <= block5_r && hortional_counter >= block5_l && vertiacl_counter <= block5_d && vertiacl_counter >= block5_u ||
			hortional_counter <= block6_r && hortional_counter >= block6_l && vertiacl_counter <= block6_d && vertiacl_counter >= block6_u ||
			hortional_counter <= block7_r && hortional_counter >= block7_l && vertiacl_counter <= block7_d && vertiacl_counter >= block7_u ||
			hortional_counter <= block8_r && hortional_counter >= block8_l && vertiacl_counter <= block8_d && vertiacl_counter >= block8_u ||
			hortional_counter <= block9_r && hortional_counter >= block9_l && vertiacl_counter <= block9_d && vertiacl_counter >= block9_u ||
			hortional_counter <= block10_r && hortional_counter >= block10_l && vertiacl_counter <= block10_d && vertiacl_counter >= block10_u ||
			hortional_counter <= block11_r && hortional_counter >= block11_l && vertiacl_counter <= block11_d && vertiacl_counter >= block11_u ||
			hortional_counter <= block12_r && hortional_counter >= block12_l && vertiacl_counter <= block12_d && vertiacl_counter >= block12_u ||
			hortional_counter <= block13_r && hortional_counter >= block13_l && vertiacl_counter <= block13_d && vertiacl_counter >= block13_u ||
			hortional_counter <= block14_r && hortional_counter >= block14_l && vertiacl_counter <= block14_d && vertiacl_counter >= block14_u ||
			hortional_counter <= block15_r && hortional_counter >= block15_l && vertiacl_counter <= block15_d && vertiacl_counter >= block15_u ||
			hortional_counter <= block16_r && hortional_counter >= block16_l && vertiacl_counter <= block16_d && vertiacl_counter >= block16_u ||
			hortional_counter <= block17_r && hortional_counter >= block17_l && vertiacl_counter <= block17_d && vertiacl_counter >= block17_u ||
			hortional_counter <= block18_r && hortional_counter >= block18_l && vertiacl_counter <= block18_d && vertiacl_counter >= block18_u 
			)
		RGB = 3'b111;
    else 
		RGB = 3'b000;
end 














/***************merge from cy*****************/
input level;
wire [15:0]   addr;
reg  [15:0]   addr_res;
reg  [2:0] vga_rgb;
wire [9:0] xpos;
wire [9:0] ypos;
wire clk_25M;
reg clk_25M_res;
assign clk_25M = clk_25M_res;
always@(posedge clk1)
begin
	clk_25M_res <= ~clk_25M_res;
end
VGA_sm u1(clk_25M,reset,hsync,vsync,xpos,ypos);
//-----------------ÏÔÊ¾Í¼Ïñ-----------------------	  

//parameter level=30;
reg [3:0]level_a;
reg [3:0]level_b;

reg [3:0]score_a;
reg [3:0]score_b;

reg a;
reg b;

always @(posedge clk)
begin
   if(level==1) a<=1;
   else a<=0;
end


always @(posedge clk)
begin
   if(score==1) b<=1;
   else b<=0;
end


reg [6:0]n;
reg [6:0]m;
 //n=7'b0;
always @( posedge a or posedge reset)
   begin
     if(reset) n<=1;
   else if(n==99)   n<=0;
   else n<=n+1;
   end


always @( posedge b or posedge reset)
   begin
     if(reset) m<=0;
   else if(m==99)   m<=0;
   else m<=m+1;
   end                        
	               
always @ (*)
begin
	  if(n>=0&&n<=99)
		begin
			level_a=(n/10);
			level_b=(n%10);
		end
		
		if(m>=0&&m<=99)
		begin
			score_a=(m/10);
			score_b=(m%10);
		end
		
		
	  if((ypos >= 9'd160 && ypos <= 9'd199)&&(xpos >= 10'd551 && xpos <= 10'd590)) //level shiwei
	    begin
		   case(level_a)
		        0:begin addr_res   <= (ypos-160)*180 + (xpos-551);  end //xianshi 0
		        1:begin addr_res   <= (ypos-160)*180 + (xpos-551)+40;  end //xianshi 1
		        2:begin addr_res   <= (ypos-160)*180 + (xpos-551)+80;  end //xianshi 2
		        3:begin addr_res   <= (ypos-160)*180 + (xpos-551)+120;  end //xianshi 3
		        4:begin addr_res   <= (ypos-160)*180 + (xpos-551)+7200;  end //xianshi 4
		        5:begin addr_res   <= (ypos-160)*180 + (xpos-551)+7240;  end //xianshi 5
		        6:begin addr_res   <= (ypos-160)*180 + (xpos-551)+7280;  end //xianshi 6
		        7:begin addr_res   <= (ypos-160)*180 + (xpos-551)+7320;  end //xianshi 7
		        8:begin addr_res   <= (ypos-160)*180 + (xpos-551)+14400;  end //xianshi 8
		        9:begin addr_res   <= (ypos-160)*180 + (xpos-551)+14440;  end //xianshi 9
		        
		     endcase   
		end         
	  else if((ypos >= 9'd160 && ypos <= 9'd199)&&(xpos >= 10'd591 && xpos <= 10'd630)) //level gewei
	  begin
	  case(level_b)
	            0:begin addr_res   <= (ypos-160)*180 + (xpos-591);  end //xianshi 0
                1:begin addr_res   <= (ypos-160)*180 + (xpos-591)+40;  end //xianshi 1
		        2:begin addr_res   <= (ypos-160)*180 + (xpos-591)+80;  end //xianshi 2
		        3:begin addr_res   <= (ypos-160)*180 + (xpos-591)+120;  end //xianshi 3
		        4:begin addr_res   <= (ypos-160)*180 + (xpos-591)+7200;  end //xianshi 4
		        5:begin addr_res   <= (ypos-160)*180 + (xpos-591)+7240;  end //xianshi 5
		        6:begin addr_res   <= (ypos-160)*180 + (xpos-591)+7280;  end //xianshi 6
		        7:begin addr_res   <= (ypos-160)*180 + (xpos-591)+7320;  end //xianshi 7
		        8:begin addr_res   <= (ypos-160)*180 + (xpos-591)+14400;  end //xianshi 8
		        9:begin addr_res   <= (ypos-160)*180 + (xpos-591)+14440;  end //xianshi 9
	   endcase
	   end    
	  else if((ypos >= 9'd260 && ypos <= 9'd299)&&(xpos >= 10'd551 && xpos <= 10'd590)) //score shiwei
		        //addr_res   <= (ypos-160)*180 + (xpos-551);    //xianshi 0 	   
		  begin
		   case(score_a)
		        0:begin addr_res   <= (ypos-260)*180 + (xpos-551);  end //xianshi 0
		        1:begin addr_res   <= (ypos-260)*180 + (xpos-551)+40;  end //xianshi 1
		        2:begin addr_res   <= (ypos-260)*180 + (xpos-551)+80;  end //xianshi 2
		        3:begin addr_res   <= (ypos-260)*180 + (xpos-551)+120;  end //xianshi 3
		        4:begin addr_res   <= (ypos-260)*180 + (xpos-551)+7200;  end //xianshi 4
		        5:begin addr_res   <= (ypos-260)*180 + (xpos-551)+7240;  end //xianshi 5
		        6:begin addr_res   <= (ypos-260)*180 + (xpos-551)+7280;  end //xianshi 6
		        7:begin addr_res   <= (ypos-260)*180 + (xpos-551)+7320;  end //xianshi 7
		        8:begin addr_res   <= (ypos-260)*180 + (xpos-551)+14400;  end //xianshi 8
		        9:begin addr_res   <= (ypos-260)*180 + (xpos-551)+14440;  end //xianshi 9
		        
		     endcase   
		end              
	  	 else if((ypos >= 9'd260 && ypos <= 9'd299)&&(xpos >= 10'd591 && xpos <= 10'd630)) //score gewei
	  begin
	  case(score_b)
	            0:begin addr_res   <= (ypos-260)*180 + (xpos-591);  end //xianshi 0
                1:begin addr_res   <= (ypos-260)*180 + (xpos-591)+40;  end //xianshi 1
		        2:begin addr_res   <= (ypos-260)*180 + (xpos-591)+80;  end //xianshi 2
		        3:begin addr_res   <= (ypos-260)*180 + (xpos-591)+120;  end //xianshi 3
		        4:begin addr_res   <= (ypos-260)*180 + (xpos-591)+7200;  end //xianshi 4
		        5:begin addr_res   <= (ypos-260)*180 + (xpos-591)+7240;  end //xianshi 5
		        6:begin addr_res   <= (ypos-260)*180 + (xpos-591)+7280;  end //xianshi 6
		        7:begin addr_res   <= (ypos-260)*180 + (xpos-591)+7320;  end //xianshi 7
		        8:begin addr_res   <= (ypos-260)*180 + (xpos-591)+14400;  end //xianshi 8
		        9:begin addr_res   <= (ypos-260)*180 + (xpos-591)+14440;  end //xianshi 9
	   endcase
	   end    
		        
	  else if((ypos >= 9'd210 && ypos <= 9'd249)&&(xpos >= 10'd551 && xpos <= 10'd630))
		        addr_res   <= (ypos-210)*180 + (xpos-551)+14480;    //xianshi fenshu 
	 else if((ypos >= 9'd319 && ypos <= 9'd400)&&(xpos >= 10'd551 && xpos <= 10'd630))
		        addr_res   <= (ypos-319)*180 + (xpos-551)+50400;    //xianshi beijing 
	else if((ypos >= 9'd11 && ypos <= 9'd90)&&(xpos >= 10'd551 && xpos <= 10'd630))
		        addr_res   <= (ypos-11)*180 + (xpos-551)+50400+80;    //xianshi tou 	        
		
	 else if((ypos >= 9'd110 && ypos <= 9'd149)&&(xpos >= 10'd551 && xpos <= 10'd630))
		        addr_res   <= (ypos-110)*180 + (xpos-551)+21600;    //xianshi LEVEL 
	 
	 else if((ypos >= 9'd0 && ypos <= 9'd239)&&(xpos >= 10'd541 && xpos <= 10'd550))
		        addr_res   <= (ypos-0)*180 + (xpos-541)+160;    //xianshi gan10 
		        
      else if((ypos >= 9'd240 && ypos <= 9'd479)&&(xpos >= 10'd541 && xpos <= 10'd550))
		        addr_res   <= (ypos-240)*180 + (xpos-541)+170;    //xianshi gan11  
	 
	 else if((ypos >= 9'd0 && ypos <= 9'd239)&&(xpos >= 10'd631 && xpos <= 10'd640))
		        addr_res   <= (ypos-0)*180 + (xpos-631)+160;    //xianshi gan20 
		        
      else if((ypos >= 9'd240 && ypos <= 9'd479)&&(xpos >= 10'd631 && xpos <= 10'd640))
		        addr_res   <= (ypos-240)*180 + (xpos-631)+170;    //xianshi gan21  
	 
	 else if((ypos >= 9'd240 && ypos <= 9'd359)&&(xpos >= 10'd240 && xpos <= 10'd399))
		        addr_res   <= (ypos-240)*180 + (xpos-240)+28800;    //xianshi GAME OVER	         
	 else addr_res <=0;
		
end
assign addr = addr_res;

 rom1
	(
		addr,
		clk_25M,
		RGBx
	);  
endmodule