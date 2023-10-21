`default_nettype none

module sequencer
  (
   input wire clk,
   input wire reset,

   input wire [8:0] write_addr,
   input wire [15:0] write_data,
   input wire write_en,

   input wire [8:0] data_num,
   input wire [31:0] repetition,
   input wire [31:0] wait_num,
   input wire kick,
   input wire stop,
   output reg busy,

   output reg [15:0] data_out,
   output reg valid_out
   );

    reg kick_d;

    reg [8:0] data_num_r;
    reg [31:0] repetition_r;
    reg [31:0] wait_num_r;

    reg [8:0] read_addr;
    wire [15:0] read_data;

    reg [8:0] data_num_cnt;
    reg [31:0] repetition_cnt;
    reg [31:0] wait_num_cnt;

    reg [7:0] state;
    localparam IDLE = 8'd0;
    localparam SET_NEXT_ADDR = 8'd1;
    localparam DATA_VALID = 8'd2;
    localparam WAIT_CYCLE = 8'd3;

    always @(posedge clk) begin
	if(reset == 1) begin
	    kick_d <= 1'b1;
	    state <= IDLE;
	    valid_out <= 0;
	    data_out <= 0;
	end else begin
	    kick_d <= kick;
	    case(state)
		IDLE: begin
		    if(kick_d == 0 && kick == 1) begin
			busy <= 1;
			if(data_num == 0 || repetition == 0) begin
			    state <= IDLE;
			end else begin
			    state <= stop == 1 ? IDLE : SET_NEXT_ADDR;
			end
		    end else begin
			busy <= 0;
		    end
		    data_num_r <= data_num;
		    repetition_r <= repetition;
		    wait_num_r <= wait_num;
		    repetition_cnt <= 1;
		    read_addr <= 0;
		    data_num_cnt <= 0;
		    wait_num_cnt <= 0;
		    valid_out <= 0;
		    data_out <= 0;
		end
		SET_NEXT_ADDR: begin
		    data_num_cnt <= data_num_cnt + 1;
		    read_addr <= data_num_cnt + 1; // set for next
		    state <= stop == 1 ? IDLE : DATA_VALID;
		    valid_out <= 0;
		end
		DATA_VALID: begin
		    valid_out <= 1;
		    data_out <= read_data; // data for previous address
		    if(wait_num_cnt == wait_num_r) begin
			if(data_num_cnt == data_num_r) begin
			    if(repetition_cnt == repetition_r) begin
				state <= IDLE;
			    end else begin
				data_num_cnt <= 0;
				read_addr <= 0;
				state <= stop == 1 ? IDLE : SET_NEXT_ADDR;
				repetition_cnt <= repetition_cnt + 1;
			    end
			end else begin
			    state <= stop == 1 ? IDLE : SET_NEXT_ADDR;
			end
			wait_num_cnt <= 0;
		    end else begin
			wait_num_cnt <= wait_num_cnt + 1;
			state <= stop == 1 ? IDLE : WAIT_CYCLE;
		    end
		end
		WAIT_CYCLE : begin
		    valid_out <= 0;
		    if(wait_num_cnt == wait_num_r) begin
			if(data_num_cnt == data_num_r) begin
			    if(repetition_cnt == repetition_r) begin
				state <= IDLE;
			    end else begin
				data_num_cnt <= 0;
				read_addr <= 0;
				state <= stop == 1 ? IDLE : SET_NEXT_ADDR;
				repetition_cnt <= repetition_cnt + 1;
			    end
			end else begin
			    state <= stop == 1 ? IDLE : SET_NEXT_ADDR;
			end
			wait_num_cnt <= 0;
		    end else begin
			wait_num_cnt <= wait_num_cnt + 1;
			state <= stop == 1 ? IDLE : WAIT_CYCLE;
		    end
		end
		default: begin
		    state <= IDLE;
		end
	    endcase // case (state)
	end
    end

    bram_512_16 bram_512_16_i (
			       .clka(clk),
			       .wea(write_en),
			       .addra(write_addr),
			       .dina(write_data),
			       .clkb(clk),
			       .addrb(read_addr),
			       .doutb(read_data)
			       );

endmodule // sequencer

`default_nettype wire
