`default_nettype none

module mawg_unit
  (
   input wire clk,
   input wire reset,
   
   input wire [0:0] ctrl_addr,
   input wire [9+16+16-1:0] ctrl_data, // {repetition,length,offset}
   input wire ctrl_we,
   
   input wire [8:0] wave_we_addr,
   input wire [15:0] wave_we_data,
   input wire wave_we,
   
   input wire kick,
   output wire busy,
   input wire force_stop,
   input wire [15:0] repetition,
   input wire [0:0] ctrl_length,
   
   output wire wave_valid,
   output wire [15:0] wave_out
   );
    
    wire [8:0] wave_addr;
    wire [15:0] wave_data;

    mawg#(.CTRL_DEPTH(1),
          .WAVE_DEPTH(9),
          .WAVE_WIDTH(16),
          .WAVE_RAM_DELAY(1)
          )
    mawg_i(
	   .clk(clk),
	   .reset(reset),
     
	   .ctrl_addr(ctrl_addr),
	   .ctrl_data(ctrl_data), // {repetition,length,offset}
	   .ctrl_we(ctrl_we),

	   .kick(kick),
	   .busy(busy),
	   .force_stop(force_stop),
	   .repetition(repetition),
	   .ctrl_length(ctrl_length),

	   .wave_addr(wave_addr),
	   .wave_data(wave_data),

	   .wave_valid(wave_valid),
	   .wave_out(wave_out)
	   );

    bram_512_16 bram_512_16_i (
			       .clka(clk),
			       .wea(wave_we),
			       .addra(wave_we_addr),
			       .dina(wave_we_data),
			       .clkb(clk),
			       .addrb(wave_addr),
			       .doutb(wave_data)
			       );

endmodule // mawg_unit

`default_nettype wire
