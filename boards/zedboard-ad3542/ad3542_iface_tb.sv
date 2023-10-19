`timescale 10ns/1ns
`default_nettype none


module ad3542_iface_tb();

    reg clk;
    reg reset;

    reg [15:0] dac_0;
    reg [15:0] dac_1;

    wire spi_sclk;
    wire spi_cs;
    wire spi_sdio0;
    wire spi_sdio1;
    wire ad3542_reset_x;

    reg [31:0] state_counter;

    initial begin
	$dumpfile("out.vcd");
	$dumpvars;

	clk <= 0;
	reset <= 0;
	state_counter <= 0;
	dac_0 <= 0;
	dac_1 <= 0;
    end

    always begin
	#5 clk <= ~clk;
    end

    always @(posedge clk) begin
	state_counter <= state_counter + 1;
	if(state_counter == 0) begin
	    reset <= 1;
	end else if(state_counter == 10) begin
	    reset <= 0;
	end else if(state_counter == 250000000) begin
	    $finish;
	end
	dac_0 <= state_counter;
	dac_1 <= state_counter + 1;
    end


    ad3542_iface DUT (
		      .clk(clk),
		      .reset(reset),

		      .dac_0(dac_0),
		      .dac_1(dac_1),

		      .spi_sclk(spi_sclk), // MAX 66MHz
		      .spi_cs(spi_cs),
		      .spi_sdio0(spi_sdio0),
		      .spi_sdio1(spi_sdio1),
		      .ad3542_reset_x(ad3542_reset_x)
		      );


endmodule // ad3542_iface_tb


`default_nettype wire
