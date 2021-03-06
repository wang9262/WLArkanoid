module vga_d(clk_in,reset,level,ps2k_clk,ps2k_data,red,grn,blu,hs,vs,ps2_byte,speaker,bouncetest,scoretest);
    input clk_in,reset,ps2k_clk,ps2k_data,level;
    output red,grn;
    output blu,bouncetest,scoretest;
    output hs,vs;
    output [7:0]ps2_byte;
    wire [7:0]ps2_byte;
    wire ps2_state; 
    wire hs1,vs1;
    assign hs=hs1,vs=vs1;
    wire [9:0]hortional_counter;
	wire [9:0] vertiacl_counter; 
	output speaker;
///////////////////////////////// 
reg CLK;
integer i;
always @(posedge clk_in)//50MHz
    begin

		if(reset) 
			begin 
				CLK<=0;
				i<=0;
			end
		else if(i==300000)
			begin 
				CLK<=~CLK;
				i<=0;
			end
		else 
			i <= i+1;
    end
///////////////////////////////////
reg clk_25M;
always @(posedge clk_in or posedge reset)
    begin
   if(reset) clk_25M<=0; 
   else clk_25M<=~clk_25M;
    end
/////////////////////////////////////
	ps2_top(clk_in,~reset,ps2k_clk,ps2k_data,ps2_byte,ps2_state);
    VGA_sm sm(
			.clk_25M(clk_25M),
			.reset(reset),
			.Hs(hs1),
			.Vs(vs1),
			.hortional_counter(hortional_counter),
			.vertiacl_counter(vertiacl_counter)
          );
   
    VGA_display dis(
            .clk1(clk_in),
			.clk(CLK),
			.reset(reset),
			.level(level),
			.ps2_byte(ps2_byte),
			.ps2_state(ps2_state),
			.RED(red),
			.GRN(grn),
			.BLU(blu),
			.hortional_counter(hortional_counter),
			.vertiacl_counter(vertiacl_counter),
			.speaker(speaker),
			.bouncetest(bouncetest),
			.scoretest(scoretest)
          );
   
endmodule