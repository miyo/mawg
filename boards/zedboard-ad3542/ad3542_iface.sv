
`default_nettype none

module ad3542_iface
  (
   input wire clk, // MAX 132MHz
   input wire reset,

   input wire [15:0] dac_0,
   input wire [15:0] dac_1,

   output reg spi_sclk, // MAX 66MHz
   output reg spi_cs,
   output reg spi_sdio0,
   output reg spi_sdio1,
   output reg ldac,
   output reg ad3542_reset_x
   );

    localparam SPI_IDLE     = 8'd0;
    localparam SPI_ADDR_0   = 8'd1;
    localparam SPI_ADDR_1   = 8'd2;
    localparam SPI_DATA_0   = 8'd3;
    localparam SPI_DATA_1   = 8'd4;
    localparam SPI_FINISH_0 = 8'd5;
    localparam SPI_FINISH_1 = 8'd6;

    reg [7:0] spi_state;
    reg spi_kick;

    reg [15:0] data_0_r, data_1_r;
    reg [7:0] addr_r; // addr_r[7] = r or /w

    reg [7:0] addr_count;
    reg [7:0] data_count;

    reg ad3542_ctrl;
    reg [7:0] ad3542_ctrl_data;
    reg [7:0] ad3542_ctrl_addr;


    // SPI
    always @(posedge clk) begin
	if(reset == 1) begin
	    spi_state <= SPI_IDLE;
	    spi_cs <= 1;
	    spi_sclk <= 0;
	    spi_sdio0 <= 0;
	    spi_sdio1 <= 0;
		ldac <= 1'b1;
	end else begin
	    case(spi_state)
		SPI_IDLE: begin
		    spi_cs <= 1;
		    spi_sclk <= 0;
		    addr_count <= 8;
			ldac <= 1'b1;
		    if(spi_kick == 1) begin
			spi_state <= SPI_ADDR_0;
			if(ad3542_ctrl == 1) begin
			    data_0_r <= {ad3542_ctrl_data, 8'h0};
			    data_1_r <= 16'h0;
			    addr_r <= ad3542_ctrl_addr;
			    data_count <= 8;
			end else begin
			    data_0_r <= dac_0 & 16'hFFF0;
			    data_1_r <= dac_1 & 16'hFFF0;
			    //addr_r <= 8'h29; // CH0_DAC_16B
			    //addr_r <= 8'h33; // CH0_DAC_16B
			    //addr_r <= 8'h36; // CH0_DAC_16B
			    //addr_r <= 8'h33; // CH0_DAC_16B
				//addr_r <= 8'h35; // CH1_INPUT_16B
				//addr_r <= 8'h2B; // CH1_INPUT_16B
				addr_r <= 8'h34; // CH0_INPUT_16B
			    data_count <= 16;
			end
		    end
		end
		SPI_ADDR_0: begin
		    spi_cs <= 0;
		    spi_sclk <= 0;
		    spi_sdio0 <= addr_r[7];
		    addr_r <= {addr_r[6:0], 1'b0};
		    addr_count <= addr_count - 1;
		    spi_state <= SPI_ADDR_1;
		end
		SPI_ADDR_1: begin
		    spi_cs <= 0;
		    spi_sclk <= 1;
		    if(addr_count == 0) begin
			spi_state <= SPI_DATA_0;
		    end else begin
			spi_state <= SPI_ADDR_0;
		    end
		end
		SPI_DATA_0: begin
		    spi_cs <= 0;
		    spi_sclk <= 0;
		    spi_sdio0 <= data_0_r[15];
		    spi_sdio1 <= data_1_r[15];
		    data_0_r <= {data_0_r[14:0], 1'b1};
		    data_1_r <= {data_1_r[14:0], 1'b1};
		    data_count <= data_count - 1;
		    spi_state <= SPI_DATA_1;
		end
		SPI_DATA_1: begin
		    spi_cs <= 0;
		    spi_sclk <= 1;
		    if(data_count == 0) begin
			spi_state <= SPI_FINISH_0;
		    end else begin
			spi_state <= SPI_DATA_0;
		    end
		end
		SPI_FINISH_0: begin
		    spi_cs <= 0;
		    spi_sclk <= 0;
		    spi_sdio0 <= 0;
		    spi_sdio1 <= 0;
		    spi_state <= SPI_FINISH_1;
		end
		SPI_FINISH_1: begin
		    spi_cs <= 1;
		    spi_sclk <= 0;
		    spi_sdio0 <= 0;
		    spi_sdio1 <= 0;
		    spi_state <= SPI_IDLE;
			if(ad3542_ctrl == 0) begin
				ldac <= 1'b0;
			end
		end
		default: begin
			ldac <= 1'b1;
		    spi_state <= SPI_IDLE;
		end
	    endcase
	end
    end
    
    localparam AD3542_RESET      = 8'd0;
    localparam AD3542_RESET_POST = 8'd1;
    localparam AD3542_INIT_0     = 8'd2;
    localparam AD3542_INIT_1     = 8'd3;
    localparam AD3542_INIT_2     = 8'd4;
    localparam AD3542_DATA       = 8'd5;

    reg [31:0] ad3542_reset_counter;
    reg [7:0] ad3542_state;

    always @(posedge clk) begin
	if(reset == 1) begin
	    ad3542_reset_x <= 0;
	    ad3542_reset_counter <= 32'd1000;
	    ad3542_state <= AD3542_RESET;
	    spi_kick <= 0;
	end else begin
	    case(ad3542_state)
		AD3542_RESET: begin
		    spi_kick <= 0;
		    if(ad3542_reset_counter == 0) begin
			ad3542_reset_counter <= 32'd200000000; // 200M count
			ad3542_reset_x <= 1; // release reset
			ad3542_state <= AD3542_RESET_POST;
		    end else begin
			ad3542_reset_counter <= ad3542_reset_counter - 1;
		    end
		end
		AD3542_RESET_POST: begin
		    spi_kick <= 0;
		    if(ad3542_reset_counter == 0) begin
			ad3542_state <= AD3542_INIT_0;
		    end else begin
			ad3542_reset_counter <= ad3542_reset_counter - 1;
		    end
		end
		AD3542_INIT_0: begin
		    ad3542_state <= AD3542_INIT_1;
		    spi_kick <= 1;
		    ad3542_ctrl <= 1;
		    ad3542_ctrl_addr <= 8'h19;
		    ad3542_ctrl_data <= 8'h33; // DAC full scale
		end
		AD3542_INIT_1: begin
		    if(spi_kick == 0 && spi_state == SPI_IDLE) begin
			ad3542_state <= AD3542_INIT_2;
			spi_kick <= 1;
			ad3542_ctrl <= 1;
			ad3542_ctrl_addr <= 8'h0F;
			ad3542_ctrl_data <= 8'h40; // multi_IO_mode = '01'
		    end else begin
			spi_kick <= 0;
		    end
		end
		AD3542_INIT_2: begin
		    if(spi_kick == 0 && spi_state == SPI_IDLE) begin
			ad3542_state <= AD3542_DATA;
			spi_kick <= 1;
			ad3542_ctrl <= 1;
			ad3542_ctrl_addr <= 8'h14;
			ad3542_ctrl_data <= 8'h06; // Synchronouse dual spi mode
		    end else begin
			spi_kick <= 0;
		    end
		end
		AD3542_DATA: begin
		    if(spi_kick == 0 && spi_state == SPI_IDLE) begin
			spi_kick <= 1;
			ad3542_ctrl <= 0;
		    end else begin
			spi_kick <= 0;
		    end
		end

		default: begin
		    ad3542_state <= AD3542_RESET;
		    ad3542_reset_x <= 0;
		    ad3542_reset_counter <= 16'd1000;
		end
	    endcase
	end
    end

endmodule // ad3542_iface

`default_nettype wire
