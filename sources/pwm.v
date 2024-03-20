`default_nettype none

module pwm#(
	    parameter WAVE_WEIGHT=1024, // common clock weight
	    parameter WAVE_LEN_WIDTH = 11, // wave and pulse width
	    parameter WAVE_WEIGHT_WIDTH = $clog2(WAVE_WEIGHT + 1)
	    )
    (
     input wire clk,
     input wire reset,

     // parameters for PWM
     input wire update,
     input wire [WAVE_LEN_WIDTH-1:0] wave_length,
     input wire [WAVE_LEN_WIDTH-1:0] pulse_width,
     input wire active_high,

     output wire [WAVE_LEN_WIDTH-1:0] wave_length_out,
     output wire [WAVE_LEN_WIDTH-1:0] pulse_width_out,
     output wire active_high_out,

     input wire enable,
     output wire pwm_out
     );

    reg update_d;

    reg [WAVE_LEN_WIDTH-1:0] wave_length_r;
    reg [WAVE_LEN_WIDTH-1:0] pulse_width_r;
    reg active_high_r;

    assign wave_length_out = wave_length_r;
    assign pulse_width_out = pulse_width_r;
    assign active_high_out = active_high_r;

    // for checking parameters
    // initial begin
    // 	$display("WAVE_LEN          = %d", WAVE_LEN);
    // 	$display("WAVE_WEIGHT       = %d", WAVE_WEIGHT);
    // 	$display("WAVE_LEN_WIDTH    = %d", WAVE_LEN_WIDTH);
    // 	$display("WAVE_WEIGHT_WIDTH = %d", WAVE_WEIGHT_WIDTH);
    // end

    // preserver parameters into internal registers at `update` rising
    always @(posedge clk) begin
	if (reset == 1) begin
	    update_d <= 1'b1;
	end else begin
	    update_d <= update;
	    if(update == 1 && update_d == 0) begin
		wave_length_r <= wave_length;
		pulse_width_r <= pulse_width;
		active_high_r <= active_high;
	    end
	end
    end

    // common clock weight counter
    // to reduce reousrce usage, move this block outside of this module
    reg [WAVE_WEIGHT_WIDTH-1:0] weight_counter;
    reg pulse_update;
    always @(posedge clk) begin
	if (reset == 1) begin
	    weight_counter <= 0;
	    pulse_update <= 1'b0;
	end else begin

	    if(weight_counter == WAVE_WEIGHT - 1) begin
		weight_counter <= 0;
		pulse_update <= 1'b1;
	    end else begin
		weight_counter <= weight_counter + 1;
		pulse_update <= 1'b0;
	    end
	end
    end

    // PWM kernel
    reg [WAVE_LEN_WIDTH-1:0] wave_counter; // whole wave length counter
    reg pwm_pulse; // pwm output
    always @(posedge clk) begin
	if (reset == 1) begin
	    pwm_pulse <= 0;
	    wave_counter <= 0;
	end else begin

	    if(enable == 1'b0) begin // disabled module
		wave_counter <= 0;
	    end else begin
		if(pulse_update == 1'b1) begin // update at pulse_update is asserted
		    if(wave_counter < pulse_width_r) begin // active or non-active
			pwm_pulse <= active_high_r;
		    end else begin
			pwm_pulse <= ~active_high_r;
		    end
		    if(wave_counter == wave_length_r - 1) begin // count up
			wave_counter <= 0;
		    end else begin
			wave_counter <= wave_counter + 1;
		    end
		end
	    end

	end
    end

    assign pwm_out = pwm_pulse;

endmodule // pwm_internal

`default_nettype wire

