`default_nettype none

module pwm#(
	    parameter WAVE_LEN=1024,
	    parameter WAVE_WEIGHT=1024,
	    parameter WAVE_LEN_WIDTH = $clog2(WAVE_LEN + 1),
	    parameter WAVE_WEIGHT_WIDTH = $clog2(WAVE_WEIGHT + 1)
	    )
    (
     input wire clk,
     input wire reset,

     input wire update,
     input wire [WAVE_LEN_WIDTH-1:0] pulse_width,

     input wire enable,
     input wire active_high,
     output wire pwm_out
     );

    reg update_d;
    reg [WAVE_LEN_WIDTH-1:0] pulse_width_r;

    initial begin
	$display("WAVE_LEN          = %d", WAVE_LEN);
	$display("WAVE_WEIGHT       = %d", WAVE_WEIGHT);
	$display("WAVE_LEN_WIDTH    = %d", WAVE_LEN_WIDTH);
	$display("WAVE_WEIGHT_WIDTH = %d", WAVE_WEIGHT_WIDTH);
    end

    always @(posedge clk) begin
	if (reset == 1) begin
	    update_d <= 1'b1;
	end else begin
	    update_d <= update;
	    if(update == 1 && update_d == 0) begin
		pulse_width_r <= pulse_width;
	    end
	end
    end

    reg [WAVE_WEIGHT_WIDTH-1:0] weight_counter;
    reg [WAVE_LEN_WIDTH-1:0] pulse_counter;
    reg pwm_pulse;
    always @(posedge clk) begin
	if (reset == 1 || enable == 0) begin
	    weight_counter <= 0;
	    pwm_pulse <= 0;
	    pulse_counter <= 0;
	end else begin

	    if(weight_counter == 0) begin // update at weight_counter period
		
		if(pulse_counter < pulse_width_r) begin
		    pwm_pulse <= active_high;
		end else begin
		    pwm_pulse <= ~active_high;
		end

		if(pulse_counter == WAVE_LEN - 1) begin
		    pulse_counter <= 0;
		end else begin
		    pulse_counter <= pulse_counter + 1;
		end
	    end


	    if(weight_counter == WAVE_WEIGHT - 1) begin
		weight_counter <= 0;
	    end else begin
		weight_counter <= weight_counter + 1;
	    end

	end
    end

    assign pwm_out = pwm_pulse;

endmodule // pwm_internal

`default_nettype wire

