`default_nettype none
`timescale 1ns/1ns

module sequencer_tb();

    reg clk;
    reg reset;

    reg [8:0] write_addr;
    reg [15:0] write_data;
    reg write_en;

    reg [8:0] data_num;
    reg [31:0] repetition;
    reg [31:0] wait_num;
    reg kick;
    reg stop;
    wire busy;

    wire [15:0] data_out;
    wire valid_out;

    reg [31:0] state_counter;
    initial begin
	clk = 0;
	reset = 0;

	write_addr = 0;
	write_data = 0;
	write_en = 0;

	data_num = 0;
	repetition = 0;
	wait_num = 0;
	kick = 0;
	stop = 0;

	state_counter = 0;
    end

    always begin
	#5 clk = ~clk;
    end

    always @(posedge clk) begin
	if(state_counter == 10) begin
	    reset <= 1;
	    state_counter <= state_counter + 1;
	end else if(state_counter == 20) begin
	    reset <= 0;
	    state_counter <= state_counter + 1;
	end else if(state_counter == 100) begin
	    state_counter <= state_counter + 1;
	    write_addr <= 0;
	    write_data <= 16'h1000;
	    write_en <= 1;
	end else if(state_counter == 101) begin
	    state_counter <= state_counter + 1;
	    write_addr <= 1;
	    write_data <= 16'h1001;
	    write_en <= 1;
	end else if(state_counter == 102) begin
	    state_counter <= state_counter + 1;
	    write_addr <= 2;
	    write_data <= 16'h1002;
	    write_en <= 1;
	end else if(state_counter == 103) begin
	    state_counter <= state_counter + 1;
	    write_addr <= 3;
	    write_data <= 16'h1003;
	    write_en <= 1;
	end else if(state_counter == 104) begin
	    state_counter <= state_counter + 1;
	    write_addr <= 4;
	    write_data <= 16'h1004;
	    write_en <= 1;
	end else if(state_counter == 105) begin
	    state_counter <= state_counter + 1;
	    write_addr <= 5;
	    write_data <= 16'h1005;
	    write_en <= 1;
	end else if(state_counter == 106) begin
	    state_counter <= state_counter + 1;
	    write_addr <= 6;
	    write_data <= 16'h1006;
	    write_en <= 1;
	end else if(state_counter == 107) begin
	    state_counter <= state_counter + 1;
	    write_addr <= 7;
	    write_data <= 16'h1007;
	    write_en <= 1;
	end else if(state_counter == 108) begin
	    state_counter <= state_counter + 1;
	    write_addr <= 8;
	    write_data <= 16'h1008;
	    write_en <= 1;
	end else if(state_counter == 109) begin
	    state_counter <= state_counter + 1;
	    write_addr <= 9;
	    write_data <= 16'h1009;
	    write_en <= 1;
	end else if(state_counter == 110) begin
	    state_counter <= state_counter + 1;
	    write_addr <= 10;
	    write_data <= 16'h100a;
	    write_en <= 1;
	end else if(state_counter == 111) begin
	    state_counter <= state_counter + 1;
	    write_addr <= 11;
	    write_data <= 16'h100b;
	    write_en <= 1;
	end else if(state_counter == 112) begin
	    state_counter <= state_counter + 1;
	    write_addr <= 12;
	    write_data <= 16'h100c;
	    write_en <= 1;
	end else if(state_counter == 113) begin
	    state_counter <= state_counter + 1;
	    write_addr <= 13;
	    write_data <= 16'h100d;
	    write_en <= 1;
	end else if(state_counter == 114) begin
	    state_counter <= state_counter + 1;
	    write_addr <= 14;
	    write_data <= 16'h100e;
	    write_en <= 1;
	end else if(state_counter == 115) begin
	    state_counter <= state_counter + 1;
	    write_addr <= 15;
	    write_data <= 16'h100f;
	    write_en <= 1;
	end else if(state_counter == 116) begin
	    state_counter <= state_counter + 1;
	    write_addr <= 16;
	    write_data <= 16'h1010;
	    write_en <= 1;
	end else if(state_counter == 117) begin
	    state_counter <= state_counter + 1;
	    write_addr <= 17;
	    write_data <= 16'h1011;
	    write_en <= 1;
	end else if(state_counter == 118) begin
	    state_counter <= state_counter + 1;
	    write_addr <= 18;
	    write_data <= 16'h1012;
	    write_en <= 1;
	end else if(state_counter == 119) begin
	    state_counter <= state_counter + 1;
	    write_addr <= 19;
	    write_data <= 16'h1013;
	    write_en <= 1;
	end else if(state_counter == 120) begin
	    state_counter <= state_counter + 1;
	    write_en <= 0;
	end else if(state_counter == 1000) begin
	    kick <= 1;
	    state_counter <= state_counter + 1;
	    data_num <= 1;
	    repetition <= 1;
	    wait_num <= 0;
	end else if(state_counter == 1001) begin
	    kick <= 0;
	    state_counter <= state_counter + 1;
	end else if(state_counter == 1100) begin
	    kick <= 1;
	    state_counter <= state_counter + 1;
	    data_num <= 5;
	    repetition <= 1;
	    wait_num <= 0;
	end else if(state_counter == 1101) begin
	    kick <= 0;
	    state_counter <= state_counter + 1;
	end else if(state_counter == 1200) begin
	    kick <= 1;
	    state_counter <= state_counter + 1;
	    data_num <= 1;
	    repetition <= 1;
	    wait_num <= 2;
	end else if(state_counter == 1201) begin
	    kick <= 0;
	    state_counter <= state_counter + 1;
	end else if(state_counter == 1300) begin
	    kick <= 1;
	    state_counter <= state_counter + 1;
	    data_num <= 1;
	    repetition <= 1;
	    wait_num <= 3;
	end else if(state_counter == 1301) begin
	    kick <= 0;
	    state_counter <= state_counter + 1;
	end else if(state_counter == 1400) begin
	    kick <= 1;
	    state_counter <= state_counter + 1;
	    data_num <= 5;
	    repetition <= 3;
	    wait_num <= 0;
	end else if(state_counter == 1401) begin
	    kick <= 0;
	    state_counter <= state_counter + 1;
	end else if(state_counter == 1500) begin
	    kick <= 1;
	    state_counter <= state_counter + 1;
	    data_num <= 5;
	    repetition <= 3;
	    wait_num <= 1;
	end else if(state_counter == 1501) begin
	    kick <= 0;
	    state_counter <= state_counter + 1;
	end else if(state_counter == 1600) begin
	    kick <= 1;
	    state_counter <= state_counter + 1;
	    data_num <= 5;
	    repetition <= 3;
	    wait_num <= 2;
	end else if(state_counter == 1601) begin
	    kick <= 0;
	    state_counter <= state_counter + 1;
	end else if(state_counter == 1700) begin
	    kick <= 1;
	    state_counter <= state_counter + 1;
	    data_num <= 5;
	    repetition <= 3;
	    wait_num <= 10;
	end else if(state_counter == 1701) begin
	    kick <= 0;
	    state_counter <= state_counter + 1;
	end else if(state_counter == 2000) begin
	    kick <= 1;
	    state_counter <= state_counter + 1;
	    data_num <= 5;
	    repetition <= 1;
	    wait_num <= 1;
	end else if(state_counter == 2001) begin
	    kick <= 0;
	    state_counter <= state_counter + 1;
	end else if(state_counter == 2100) begin
	    kick <= 1;
	    state_counter <= state_counter + 1;
	    data_num <= 5;
	    repetition <= 1;
	    wait_num <= 2;
	end else if(state_counter == 2101) begin
	    kick <= 0;
	    state_counter <= state_counter + 1;
	end else if(state_counter == 2200) begin
	    kick <= 1;
	    state_counter <= state_counter + 1;
	    data_num <= 5;
	    repetition <= 10;
	    wait_num <= 2;
	end else if(state_counter == 2201) begin
	    kick <= 0;
	    state_counter <= state_counter + 1;
	end else if(state_counter == 2310) begin
	    stop <= 1;
	    state_counter <= state_counter + 1;
	end else if(state_counter == 2311) begin
	    stop <= 0;
	    state_counter <= state_counter + 1;
	end else if(state_counter == 20000) begin
	    $finish;
	end else begin
	    state_counter <= state_counter + 1;
	    
	end
    end


    sequencer DUT (
		   .clk(clk),
		   .reset(reset),

		   .write_addr(write_addr),
		   .write_data(write_data),
		   .write_en(write_en),

		   .data_num(data_num),
		   .repetition(repetition),
		   .wait_num(wait_num),
		   .kick(kick),
		   .stop(stop),
		   .busy(busy),

		   .data_out(data_out),
		   .valid_out(valid_out)
		   );

endmodule // sequencer_tb

`default_nettype wire

