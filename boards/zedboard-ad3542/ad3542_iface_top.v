`default_nettype none

module ad5342_iface_top
  (
   input wire GCLK, // MAX 132MHz
      
   input wire[7:0] SW,
   output wire[7:0] LD,
  
   output wire spi_sclk_0, // MAX 66MHz
   output wire spi_cs_0,
   output wire spi_sdio0_0,
   output wire spi_sdio1_0,
   output wire ldac_0,

   output wire spi_sclk_1, // MAX 66MHz
   output wire spi_cs_1,
   output wire spi_sdio0_1,
   output wire spi_sdio1_1,
   output wire ldac_1,

   output wire spi_sclk_2, // MAX 66MHz
   output wire spi_cs_2,
   output wire spi_sdio0_2,
   output wire spi_sdio1_2,
   output wire ldac_2,

   output wire spi_sclk_3, // MAX 66MHz
   output wire spi_cs_3,
   output wire spi_sdio0_3,
   output wire spi_sdio1_3,
   output wire ldac_3,

   output wire spi_sclk_4, // MAX 66MHz
   output wire spi_cs_4,
   output wire spi_sdio0_4,
   output wire spi_sdio1_4,
   output wire ldac_4,

   output wire spi_sclk_5, // MAX 66MHz
   output wire spi_cs_5,
   output wire spi_sdio0_5,
   output wire spi_sdio1_5,
   output wire ldac_5,

   output wire spi_sclk_6, // MAX 66MHz
   output wire spi_cs_6,
   output wire spi_sdio0_6,
   output wire spi_sdio1_6,
   output wire ldac_6,

   output wire spi_sclk_7, // MAX 66MHz
   output wire spi_cs_7,
   output wire spi_sdio0_7,
   output wire spi_sdio1_7,
   output wire ldac_7,

   output wire ad3542_reset_x,

   inout wire [5:0] FMC_GPIO,
   output wire FMC_LED
   );

    wire AD3524_CLK;

    clk_wiz_0 clk_wiz_0_i
      (
       // Clock out ports
       .clk_out1(AD3524_CLK),     // output clk_out1
       // Status and control signals
       .reset(1'b0), // input reset
       .locked(),       // output locked
       // Clock in ports
       .clk_in1(GCLK)      // input clk_in1
       );

    reg [31:0] counter;
    always @(posedge AD3524_CLK) begin
	counter <= counter + 1;
    end
    assign LD = counter[24:17];

    reg [15:0] dac_test_val;

    wire [15:0] dac_0_0;
    wire [15:0] dac_1_0;

    wire [15:0] dac_0_1;
    wire [15:0] dac_1_1;

    wire [15:0] dac_0_2;
    wire [15:0] dac_1_2;

    wire [15:0] dac_0_3;
    wire [15:0] dac_1_3;

    wire [15:0] dac_0_4;
    wire [15:0] dac_1_4;

    wire [15:0] dac_0_5;
    wire [15:0] dac_1_5;

    wire [15:0] dac_0_6;
    wire [15:0] dac_1_6;

    wire [15:0] dac_0_7;
    wire [15:0] dac_1_7;

    reg sw0_d;
    reg sw0_dd;
    always @(posedge AD3524_CLK) begin
	sw0_d <= SW[0];
	sw0_dd <= sw0_d;
    end

    reg [2:0] mode_d;
    reg [2:0] mode_dd;

    always @(posedge AD3524_CLK) begin
	mode_d <= SW[7:5];
	mode_dd <= mode_d;
    end

    always @(posedge AD3524_CLK) begin
	case(mode_dd)
	    3'b001: dac_test_val <= 16'hFFFF;
	    3'b010: dac_test_val <= 16'h7FFF;
	    3'b011: dac_test_val <= 16'h0FFF;
	    3'b100: dac_test_val <= 16'h07FF;
	    3'b101: dac_test_val <= 16'h8000;
	    default: dac_test_val <= 16'h0000;
	endcase // case (mode_dd)
    end

    assign dac_0_0 = dac_test_val;
    assign dac_1_0 = dac_test_val;
    assign dac_0_1 = dac_test_val;
    assign dac_1_1 = dac_test_val;
    assign dac_0_2 = dac_test_val;
    assign dac_1_2 = dac_test_val;
    assign dac_0_3 = dac_test_val;
    assign dac_1_3 = dac_test_val;
    assign dac_0_4 = dac_test_val;
    assign dac_1_4 = dac_test_val;
    assign dac_0_5 = dac_test_val;
    assign dac_1_5 = dac_test_val;
    assign dac_0_6 = dac_test_val;
    assign dac_1_6 = dac_test_val;
    assign dac_0_7 = dac_test_val;
    assign dac_1_7 = dac_test_val;

    ad3542_iface ad3542_iface_i_0
      (
       .clk(AD3524_CLK), // MAX 132MHz
       .reset(sw0_dd),

       .dac_0(dac_0_0),
       .dac_1(dac_1_0),

       .spi_sclk(spi_sclk_0), // MAX 66MHz
       .spi_cs(spi_cs_0),
       .spi_sdio0(spi_sdio0_0),
       .spi_sdio1(spi_sdio1_0),
       .ldac(ldac_0),
       .ad3542_reset_x(ad3542_reset_x)
       );

    ad3542_iface ad3542_iface_i_1
      (
       .clk(AD3524_CLK), // MAX 132MHz
       .reset(sw0_dd),

       .dac_0(dac_0_1),
       .dac_1(dac_1_1),

       .spi_sclk(spi_sclk_1), // MAX 66MHz
       .spi_cs(spi_cs_1),
       .spi_sdio0(spi_sdio0_1),
       .spi_sdio1(spi_sdio1_1),
       .ldac(ldac_1),
       .ad3542_reset_x()
       );

    ad3542_iface ad3542_iface_i_2
      (
       .clk(AD3524_CLK), // MAX 132MHz
       .reset(sw0_dd),

       .dac_0(dac_0_2),
       .dac_1(dac_1_2),

       .spi_sclk(spi_sclk_2), // MAX 66MHz
       .spi_cs(spi_cs_2),
       .spi_sdio0(spi_sdio0_2),
       .spi_sdio1(spi_sdio1_2),
       .ldac(ldac_2),
       .ad3542_reset_x()
       );

    ad3542_iface ad3542_iface_i_3
      (
       .clk(AD3524_CLK), // MAX 132MHz
       .reset(sw0_dd),

       .dac_0(dac_0_3),
       .dac_1(dac_1_3),

       .spi_sclk(spi_sclk_3), // MAX 66MHz
       .spi_cs(spi_cs_3),
       .spi_sdio0(spi_sdio0_3),
       .spi_sdio1(spi_sdio1_3),
       .ldac(ldac_3),
       .ad3542_reset_x()
       );

    ad3542_iface ad3542_iface_i_4
      (
       .clk(AD3524_CLK), // MAX 132MHz
       .reset(sw0_dd),

       .dac_0(dac_0_4),
       .dac_1(dac_1_4),

       .spi_sclk(spi_sclk_4), // MAX 66MHz
       .spi_cs(spi_cs_4),
       .spi_sdio0(spi_sdio0_4),
       .spi_sdio1(spi_sdio1_4),
       .ldac(ldac_4),
       .ad3542_reset_x()
       );

    ad3542_iface ad3542_iface_i_5
      (
       .clk(AD3524_CLK), // MAX 132MHz
       .reset(sw0_dd),

       .dac_0(dac_0_5),
       .dac_1(dac_1_5),

       .spi_sclk(spi_sclk_5), // MAX 66MHz
       .spi_cs(spi_cs_5),
       .spi_sdio0(spi_sdio0_5),
       .spi_sdio1(spi_sdio1_5),
       .ldac(ldac_5),
       .ad3542_reset_x()
       );

    ad3542_iface ad3542_iface_i_6
      (
       .clk(AD3524_CLK), // MAX 132MHz
       .reset(sw0_dd),

       .dac_0(dac_0_6),
       .dac_1(dac_1_6),

       .spi_sclk(spi_sclk_6), // MAX 66MHz
       .spi_cs(spi_cs_6),
       .spi_sdio0(spi_sdio0_6),
       .spi_sdio1(spi_sdio1_6),
       .ldac(ldac_6),
       .ad3542_reset_x()
       );

    ad3542_iface ad3542_iface_i_7
      (
       .clk(AD3524_CLK), // MAX 132MHz
       .reset(sw0_dd),

       .dac_0(dac_0_7),
       .dac_1(dac_1_7),

       .spi_sclk(spi_sclk_7), // MAX 66MHz
       .spi_cs(spi_cs_7),
       .spi_sdio0(spi_sdio0_7),
       .spi_sdio1(spi_sdio1_7),
       .ldac(ldac_7),
       .ad3542_reset_x()
       );

endmodule

`default_nettype wire

