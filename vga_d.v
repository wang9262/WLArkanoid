module vga_d(clk_in,reset,mode,game_button_l,game_button_r,red,grn,blu,hs,vs);
    input clk_in,reset,mode,game_button_l,game_button_r;
    output [2:0]red,grn;
    output [1:0]blu;
    output hs,vs;
    
    wire hs1,vs1;
    assign hs=hs1,vs=vs1;
    wire [9:0]hortional_counter;
wire [9:0] vertiacl_counter;
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
    VGA_sm sm(
          .clk_25M(clk_25M),
          .reset(reset),
          .Hs(hs1),
          .Vs(vs1),
    .hortional_counter(hortional_counter),
    .vertiacl_counter(vertiacl_counter)
          );
    
    VGA_display dis(
		.clk(CLK),
          .reset(reset),
    .mode(mode),
    .game_button_l(game_button_l),
    .game_button_r(game_button_r),
          .RED(red),
          .GRN(grn),
          .BLU(blu),
    .hortional_counter(hortional_counter),
    .vertiacl_counter(vertiacl_counter)
          );
    
endmodule