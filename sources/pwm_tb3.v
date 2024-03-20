`timescale 1ns/1ps
`default_nettype none

module pwm_tb();

    localparam WAVE_WEIGHT = 1;
    localparam WAVE_LEN_WIDTH = 8;

    reg clk;
    reg reset;

    reg update;
    reg [WAVE_LEN_WIDTH-1:0] wave_length;
    reg [WAVE_LEN_WIDTH-1:0] pulse_width;
    reg active_high;

    wire [WAVE_LEN_WIDTH-1:0] wave_length_out;
    wire [WAVE_LEN_WIDTH-1:0] pulse_width_out;
    wire active_high_out;

    reg enable;
    wire pwm_out;

    reg [31:0] counter;

    initial begin
	clk = 0;
	reset = 0;
	update = 0;
	wave_length = 0;
	pulse_width = 0;
	active_high = 0;
	enable = 0;
	counter = 0;
	$dumpvars;
    end

    always begin
	#5 clk = ~clk;
    end

    always @(posedge clk) begin
	case(counter)
	    5: begin
		counter <= counter + 1;
		reset <= 1;
	    end
	    10: begin
		counter <= counter + 1;
		reset <= 0;
	    end
	    12: begin
		counter <= counter + 1;
		update <= 1;
		wave_length <= 'd10;
		pulse_width <= 'd5;
		active_high <= 1;
	    end
	    13: begin
		counter <= counter + 1;
		update <= 0;
		wave_length <= 0; // check whether preserved or not
		pulse_width <= 0; // check whether preserved or not
		active_high <= 0; // check whether preserved or not
	    end
	    14: begin
		counter <= counter + 1;
		enable <= 1;
	    end
	    1000: begin // stop
		counter <= counter + 1;
		enable <= 0;
	    end
	    1100: begin // restart
		counter <= counter + 1;
		enable <= 1;
	    end
	    1300: begin // active_low
		counter <= counter + 1;
		update <= 1;
		wave_length <= 'd10;
		pulse_width <= 'd5;
		active_high <= 0;
	    end
	    1301: begin
		counter <= counter + 1;
		update <= 0;
	    end
	    2000: begin // long active
		counter <= counter + 1;
		update <= 1;
		wave_length <= 'd20;
		pulse_width <= 'd18;
		active_high <= 1;
	    end
	    2001: begin
		counter <= counter + 1;
		update <= 0;
	    end
	    3000: begin // short active
		counter <= counter + 1;
		update <= 1;
		wave_length <= 'd5;
		pulse_width <= 'd1;
		active_high <= 1;
	    end
	    3001: begin
		counter <= counter + 1;
		update <= 0;
	    end
	    4000: begin // non active
		counter <= counter + 1;
		update <= 1;
		wave_length <= 'd5;
		pulse_width <= 'd0;
		active_high <= 1;
	    end
	    4001: begin
		counter <= counter + 1;
		update <= 0;
	    end
	    5000: begin // always active
		counter <= counter + 1;
		update <= 1;
		wave_length <= 'd5;
		pulse_width <= 'd5;
		active_high <= 1;
	    end
	    5001: begin
		counter <= counter + 1;
		update <= 0;
	    end
	    6000: begin // 50%
		counter <= counter + 1;
		update <= 1;
		wave_length <= 'd10;
		pulse_width <= 'd5;
		active_high <= 1;
	    end
	    6001: begin
		counter <= counter + 1;
		update <= 0;
	    end
	    7000: begin // always active
		counter <= counter + 1;
		update <= 1;
		wave_length <= 'd5;
		pulse_width <= 'd10;
		active_high <= 1;
	    end
	    7001: begin
		counter <= counter + 1;
		update <= 0;
	    end
	    8000: begin // 50%
		counter <= counter + 1;
		update <= 1;
		wave_length <= 'd10;
		pulse_width <= 'd5;
		active_high <= 1;
	    end
	    8001: begin
		counter <= counter + 1;
		update <= 0;
	    end
	    100000:
	      $finish;
	    default:
	      counter <= counter + 1;
	endcase
    end

    pwm#(.WAVE_WEIGHT(WAVE_WEIGHT),
	 .WAVE_LEN_WIDTH(WAVE_LEN_WIDTH)
	 )
    DUT(
	.clk(clk),
	.reset(reset),

	.update(update),

	.wave_length(wave_length),
	.pulse_width(pulse_width),
	.active_high(active_high),

	.wave_length_out(wave_length_out),
	.pulse_width_out(pulse_width_out),
	.active_high_out(active_high_out),

	.enable(enable),
	.pwm_out(pwm_out)
     );

endmodule // pwm_tb

`default_nettype wire

