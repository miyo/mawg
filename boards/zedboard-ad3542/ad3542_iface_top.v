`default_nettype none

module ad5342_iface_top
  (
   inout wire [14:0] DDR_addr,
   inout wire [2:0] DDR_ba,
   inout wire DDR_cas_n,
   inout wire DDR_ck_n,
   inout wire DDR_ck_p,
   inout wire DDR_cke,
   inout wire DDR_cs_n,
   inout wire [3:0] DDR_dm,
   inout wire [31:0] DDR_dq,
   inout wire [3:0] DDR_dqs_n,
   inout wire [3:0] DDR_dqs_p,
   inout wire DDR_odt,
   inout wire DDR_ras_n,
   inout wire DDR_reset_n,
   inout wire DDR_we_n,
   inout wire FIXED_IO_ddr_vrn,
   inout wire FIXED_IO_ddr_vrp,
   inout wire [53:0] FIXED_IO_mio,
   inout wire FIXED_IO_ps_clk,
   inout wire FIXED_IO_ps_porb,
   inout wire FIXED_IO_ps_srstb,

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

    wire AD3542_CLK;

    reg [31:0] counter;
    always @(posedge AD3542_CLK) begin
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

    reg [7:0] sw_d;
    reg [7:0] sw_dd;
    always @(posedge AD3542_CLK) begin
	sw_d <= SW;
	sw_dd <= sw_d;
    end

    wire sys_reset;
    assign sys_reset = sw_dd[0];

    wire debug_mode;
    assign debug_mode = sw_dd[1];
    
    wire [2:0] dac_val_mode;
    assign dac_val_mode = sw_dd[4:2];

    always @(posedge AD3542_CLK) begin
	case(dac_val_mode)
	    3'b001: dac_test_val <= 16'hFFFF;
	    3'b010: dac_test_val <= 16'h7FFF;
	    3'b011: dac_test_val <= 16'h0FFF;
	    3'b100: dac_test_val <= 16'h07FF;
	    3'b101: dac_test_val <= 16'h8000;
	    default: dac_test_val <= 16'h0000;
	endcase // case (dac_val_mode)
    end

    reg [31:0] ad3524_clk_counter;
    always @(posedge AD3542_CLK) begin
	ad3524_clk_counter <= ad3524_clk_counter + 1;
    end
    assign FMC_LED = ad3524_clk_counter[23:0];

    ad3542_iface ad3542_iface_i_0
      (
       .clk(AD3542_CLK), // MAX 132MHz
       .reset(sys_reset),

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
       .clk(AD3542_CLK), // MAX 132MHz
       .reset(sys_reset),

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
       .clk(AD3542_CLK), // MAX 132MHz
       .reset(sys_reset),

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
       .clk(AD3542_CLK), // MAX 132MHz
       .reset(sys_reset),

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
       .clk(AD3542_CLK), // MAX 132MHz
       .reset(sys_reset),

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
       .clk(AD3542_CLK), // MAX 132MHz
       .reset(sys_reset),

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
       .clk(AD3542_CLK), // MAX 132MHz
       .reset(sys_reset),

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
       .clk(AD3542_CLK), // MAX 132MHz
       .reset(sys_reset),

       .dac_0(dac_0_7),
       .dac_1(dac_1_7),

       .spi_sclk(spi_sclk_7), // MAX 66MHz
       .spi_cs(spi_cs_7),
       .spi_sdio0(spi_sdio0_7),
       .spi_sdio1(spi_sdio1_7),
       .ldac(ldac_7),
       .ad3542_reset_x()
       );

    wire [0:0] mawg_ctrl_addr;
    wire [10+16+16-1:0] mawg_ctrl_data;
    wire [3:0] mawg_ctrl_we;
    wire [9:0] mawg_wave_addr;
    wire [15:0] mawg_wave_data;
    wire [3:0] mawg_wave_we;

    wire mawg_kick;
    wire mawg_force_stop;
    wire [15:0] mawg_repetition;
    wire [3:0] mawg_ctrl_length;

    wire mawg_0_ctrl_we;
    wire mawg_0_wave_we;
    wire mawg_0_busy;
    wire wave_0_valid;
    wire [15:0] wave_0_out;

    mawg_unit mawg_0(
		     .clk(AD3542_CLK),
		     .reset(sys_reset),
		     
		     .ctrl_addr(mawg_ctrl_addr),
		     .ctrl_data(mawg_ctrl_data),
		     .ctrl_we(mawg_0_ctrl_we),
		     
		     .wave_we_addr(mawg_wave_addr),
		     .wave_we_data(mawg_wave_data),
		     .wave_we(mawg_0_wave_we),
		     
		     .kick(mawg_kick),
		     .busy(mawg_0_busy),
		     .force_stop(mawg_force_stop),
		     .repetition(mawg_repetition),
		     .ctrl_length(mawg_ctrl_length),
		     
		     .wave_valid(wave_0_valid),
		     .wave_out(wave_0_out)
		     );

    wire mawg_1_ctrl_we;
    wire mawg_1_wave_we;
    wire mawg_1_busy;
    wire wave_1_valid;
    wire [15:0] wave_1_out;
    
    mawg_unit mawg_1(
		     .clk(AD3542_CLK),
		     .reset(sys_reset),
		     
		     .ctrl_addr(mawg_ctrl_addr),
		     .ctrl_data(mawg_ctrl_data),
		     .ctrl_we(mawg_1_ctrl_we),
		     
		     .wave_we_addr(mawg_wave_addr),
		     .wave_we_data(mawg_wave_data),
		     .wave_we(mawg_1_wave_we),
		     
		     .kick(mawg_kick),
		     .busy(mawg_1_busy),
		     .force_stop(mawg_force_stop),
		     .repetition(mawg_repetition),
		     .ctrl_length(mawg_ctrl_length),
		     
		     .wave_valid(wave_1_valid),
		     .wave_out(wave_1_out)
		     );

    wire mawg_2_ctrl_we;
    wire mawg_2_wave_we;
    wire mawg_2_busy;
    wire wave_2_valid;
    wire [15:0] wave_2_out;

    mawg_unit mawg_2(
		     .clk(AD3542_CLK),
		     .reset(sys_reset),
		     
		     .ctrl_addr(mawg_ctrl_addr),
		     .ctrl_data(mawg_ctrl_data),
		     .ctrl_we(mawg_2_ctrl_we),
		     
		     .wave_we_addr(mawg_wave_addr),
		     .wave_we_data(mawg_wave_data),
		     .wave_we(mawg_2_wave_we),

		     .kick(mawg_kick),
		     .busy(mawg_2_busy),
		     .force_stop(mawg_force_stop),
		     .repetition(mawg_repetition),
		     .ctrl_length(mawg_ctrl_length),
		     
		     .wave_valid(wave_2_valid),
		     .wave_out(wave_2_out)
		     );

    wire mawg_3_ctrl_we;
    wire mawg_3_wave_we;
    wire mawg_3_busy;
    wire wave_3_valid;
    wire [15:0] wave_3_out;

    mawg_unit mawg_3(
		     .clk(AD3542_CLK),
		     .reset(sys_reset),
		     
		     .ctrl_addr(mawg_ctrl_addr),
		     .ctrl_data(mawg_ctrl_data),
		     .ctrl_we(mawg_3_ctrl_we),
		     
		     .wave_we_addr(mawg_wave_addr),
		     .wave_we_data(mawg_wave_data),
		     .wave_we(mawg_3_wave_we),

		     .kick(mawg_kick),
		     .busy(mawg_3_busy),
		     .force_stop(mawg_force_stop),
		     .repetition(mawg_repetition),
		     .ctrl_length(mawg_ctrl_length),
		     
		     .wave_valid(wave_3_valid),
		     .wave_out(wave_3_out)
		     );

    wire mawg_4_ctrl_we;
    wire mawg_4_wave_we;
    wire mawg_4_busy;
    wire wave_4_valid;
    wire [15:0] wave_4_out;

    mawg_unit mawg_4(
		     .clk(AD3542_CLK),
		     .reset(sys_reset),
		     
		     .ctrl_addr(mawg_ctrl_addr),
		     .ctrl_data(mawg_ctrl_data),
		     .ctrl_we(mawg_4_ctrl_we),
		     
		     .wave_we_addr(mawg_wave_addr),
		     .wave_we_data(mawg_wave_data),
		     .wave_we(mawg_4_wave_we),
		     
		     .kick(mawg_kick),
		     .busy(mawg_4_busy),
		     .force_stop(mawg_force_stop),
		     .repetition(mawg_repetition),
		     .ctrl_length(mawg_ctrl_length),
		     
		     .wave_valid(wave_4_valid),
		     .wave_out(wave_4_out)
		     );

    wire mawg_5_ctrl_we;
    wire mawg_5_wave_we;
    wire mawg_5_busy;
    wire wave_5_valid;
    wire [15:0] wave_5_out;

    mawg_unit mawg_5(
		     .clk(AD3542_CLK),
		     .reset(sys_reset),
		     
		     .ctrl_addr(mawg_ctrl_addr),
		     .ctrl_data(mawg_ctrl_data),
		     .ctrl_we(mawg_5_ctrl_we),
		     
		     .wave_we_addr(mawg_wave_addr),
		     .wave_we_data(mawg_wave_data),
		     .wave_we(mawg_5_wave_we),
		     
		     .kick(mawg_kick),
		     .busy(mawg_5_busy),
		     .force_stop(mawg_force_stop),
		     .repetition(mawg_repetition),
		     .ctrl_length(mawg_ctrl_length),
		     
		     .wave_valid(wave_5_valid),
		     .wave_out(wave_5_out)
		     );

    wire mawg_6_ctrl_we;
    wire mawg_6_wave_we;
    wire mawg_6_busy;
    wire wave_6_valid;
    wire [15:0] wave_6_out;
    
    mawg_unit mawg_6(
		     .clk(AD3542_CLK),
		     .reset(sys_reset),
		     
		     .ctrl_addr(mawg_ctrl_addr),
		     .ctrl_data(mawg_ctrl_data),
		     .ctrl_we(mawg_6_ctrl_we),
		     
		     .wave_we_addr(mawg_wave_addr),
		     .wave_we_data(mawg_wave_data),
		     .wave_we(mawg_6_wave_we),
		     
		     .kick(mawg_kick),
		     .busy(mawg_6_busy),
		     .force_stop(mawg_force_stop),
		     .repetition(mawg_repetition),
		     .ctrl_length(mawg_ctrl_length),
		     
		     .wave_valid(wave_6_valid),
		     .wave_out(wave_6_out)
		     );

    wire mawg_7_ctrl_we;
    wire mawg_7_wave_we;
    wire mawg_7_busy;
    wire wave_7_valid;
    wire [15:0] wave_7_out;

    mawg_unit mawg_7(
		     .clk(AD3542_CLK),
		     .reset(sys_reset),
		     
		     .ctrl_addr(mawg_ctrl_addr),
		     .ctrl_data(mawg_ctrl_data),
		     .ctrl_we(mawg_7_ctrl_we),
		     
		     .wave_we_addr(mawg_wave_addr),
		     .wave_we_data(mawg_wave_data),
		     .wave_we(mawg_7_wave_we),
		     
		     .kick(mawg_kick),
		     .busy(mawg_7_busy),
		     .force_stop(mawg_force_stop),
		     .repetition(mawg_repetition),
		     .ctrl_length(mawg_ctrl_length),
		     
		     .wave_valid(wave_7_valid),
		     .wave_out(wave_7_out)
		     );

    wire mawg_8_ctrl_we;
    wire mawg_8_wave_we;
    wire mawg_8_busy;
    wire wave_8_valid;
    wire [15:0] wave_8_out;

    mawg_unit mawg_8(
		     .clk(AD3542_CLK),
		     .reset(sys_reset),
		     
		     .ctrl_addr(mawg_ctrl_addr),
		     .ctrl_data(mawg_ctrl_data),
		     .ctrl_we(mawg_8_ctrl_we),
		     
		     .wave_we_addr(mawg_wave_addr),
		     .wave_we_data(mawg_wave_data),
		     .wave_we(mawg_8_wave_we),
		     
		     .kick(mawg_kick),
		     .busy(mawg_8_busy),
		     .force_stop(mawg_force_stop),
		     .repetition(mawg_repetition),
		     .ctrl_length(mawg_ctrl_length),
		     
		     .wave_valid(wave_8_valid),
		     .wave_out(wave_8_out)
		     );

    wire mawg_9_ctrl_we;
    wire mawg_9_wave_we;
    wire mawg_9_busy;
    wire wave_9_valid;
    wire [15:0] wave_9_out;

    mawg_unit mawg_9(
		     .clk(AD3542_CLK),
		     .reset(sys_reset),
		     
		     .ctrl_addr(mawg_ctrl_addr),
		     .ctrl_data(mawg_ctrl_data),
		     .ctrl_we(mawg_9_ctrl_we),
		     
		     .wave_we_addr(mawg_wave_addr),
		     .wave_we_data(mawg_wave_data),
		     .wave_we(mawg_9_wave_we),
		     
		     .kick(mawg_kick),
		     .busy(mawg_9_busy),
		     .force_stop(mawg_force_stop),
		     .repetition(mawg_repetition),
		     .ctrl_length(mawg_ctrl_length),
		     
		     .wave_valid(wave_9_valid),
		     .wave_out(wave_9_out)
		     );

    wire mawg_a_ctrl_we;
    wire mawg_a_wave_we;
    wire mawg_a_busy;
    wire wave_a_valid;
    wire [15:0] wave_a_out;

    mawg_unit mawg_a(
		     .clk(AD3542_CLK),
		     .reset(sys_reset),
		     
		     .ctrl_addr(mawg_ctrl_addr),
		     .ctrl_data(mawg_ctrl_data),
		     .ctrl_we(mawg_a_ctrl_we),
		     
		     .wave_we_addr(mawg_wave_addr),
		     .wave_we_data(mawg_wave_data),
		     .wave_we(mawg_a_wave_we),
		     
		     .kick(mawg_kick),
		     .busy(mawg_a_busy),
		     .force_stop(mawg_force_stop),
		     .repetition(mawg_repetition),
		     .ctrl_length(mawg_ctrl_length),
		     
		     .wave_valid(wave_a_valid),
		     .wave_out(wave_a_out)
		     );

    wire mawg_b_ctrl_we;
    wire mawg_b_wave_we;
    wire mawg_b_busy;
    wire wave_b_valid;
    wire [15:0] wave_b_out;

    mawg_unit mawg_b(
		     .clk(AD3542_CLK),
		     .reset(sys_reset),
		     
		     .ctrl_addr(mawg_ctrl_addr),
		     .ctrl_data(mawg_ctrl_data),
		     .ctrl_we(mawg_b_ctrl_we),
		     
		     .wave_we_addr(mawg_wave_addr),
		     .wave_we_data(mawg_wave_data),
		     .wave_we(mawg_b_wave_we),
		     
		     .kick(mawg_kick),
		     .busy(mawg_b_busy),
		     .force_stop(mawg_force_stop),
		     .repetition(mawg_repetition),
		     .ctrl_length(mawg_ctrl_length),
		     
		     .wave_valid(wave_b_valid),
		     .wave_out(wave_b_out)
		     );

    wire mawg_c_ctrl_we;
    wire mawg_c_wave_we;
    wire mawg_c_busy;
    wire wave_c_valid;
    wire [15:0] wave_c_out;

    mawg_unit mawg_c(
		     .clk(AD3542_CLK),
		     .reset(sys_reset),
		     
		     .ctrl_addr(mawg_ctrl_addr),
		     .ctrl_data(mawg_ctrl_data),
		     .ctrl_we(mawg_c_ctrl_we),
		     
		     .wave_we_addr(mawg_wave_addr),
		     .wave_we_data(mawg_wave_data),
		     .wave_we(mawg_c_wave_we),
		     
		     .kick(mawg_kick),
		     .busy(mawg_c_busy),
		     .force_stop(mawg_force_stop),
		     .repetition(mawg_repetition),
		     .ctrl_length(mawg_ctrl_length),
		     
		     .wave_valid(wave_c_valid),
		     .wave_out(wave_c_out)
		     );

    wire mawg_d_ctrl_we;
    wire mawg_d_wave_we;
    wire mawg_d_busy;
    wire wave_d_valid;
    wire [15:0] wave_d_out;

    mawg_unit mawg_d(
		     .clk(AD3542_CLK),
		     .reset(sys_reset),
		     
		     .ctrl_addr(mawg_ctrl_addr),
		     .ctrl_data(mawg_ctrl_data),
		     .ctrl_we(mawg_d_ctrl_we),
		     
		     .wave_we_addr(mawg_wave_addr),
		     .wave_we_data(mawg_wave_data),
		     .wave_we(mawg_d_wave_we),
		     
		     .kick(mawg_kick),
		     .busy(mawg_d_busy),
		     .force_stop(mawg_force_stop),
		     .repetition(mawg_repetition),
		     .ctrl_length(mawg_ctrl_length),
		     
		     .wave_valid(wave_d_valid),
		     .wave_out(wave_d_out)
		     );

    wire mawg_e_ctrl_we;
    wire mawg_e_wave_we;
    wire mawg_e_busy;
    wire wave_e_valid;
    wire [15:0] wave_e_out;

    mawg_unit mawg_e(
		     .clk(AD3542_CLK),
		     .reset(sys_reset),
		     
		     .ctrl_addr(mawg_ctrl_addr),
		     .ctrl_data(mawg_ctrl_data),
		     .ctrl_we(mawg_e_ctrl_we),
		     
		     .wave_we_addr(mawg_wave_addr),
		     .wave_we_data(mawg_wave_data),
		     .wave_we(mawg_e_wave_we),
		     
		     .kick(mawg_kick),
		     .busy(mawg_e_busy),
		     .force_stop(mawg_force_stop),
		     .repetition(mawg_repetition),
		     .ctrl_length(mawg_ctrl_length),
		     
		     .wave_valid(wave_e_valid),
		     .wave_out(wave_e_out)
		     );

    wire mawg_f_ctrl_we;
    wire mawg_f_wave_we;
    wire mawg_f_busy;
    wire wave_f_valid;
    wire [15:0] wave_f_out;

    mawg_unit mawg_f(
		     .clk(AD3542_CLK),
		     .reset(sys_reset),
		     
		     .ctrl_addr(mawg_ctrl_addr),
		     .ctrl_data(mawg_ctrl_data),
		     .ctrl_we(mawg_f_ctrl_we),
		     
		     .wave_we_addr(mawg_wave_addr),
		     .wave_we_data(mawg_wave_data),
		     .wave_we(mawg_f_wave_we),
		     
		     .kick(mawg_kick),
		     .busy(mawg_f_busy),
		     .force_stop(mawg_force_stop),
		     .repetition(mawg_repetition),
		     .ctrl_length(mawg_ctrl_length),
		     
		     .wave_valid(wave_f_valid),
		     .wave_out(wave_f_out)
		     );

    reg [15:0] wave_0_out_r;
    reg [15:0] wave_1_out_r;
    reg [15:0] wave_2_out_r;
    reg [15:0] wave_3_out_r;
    reg [15:0] wave_4_out_r;
    reg [15:0] wave_5_out_r;
    reg [15:0] wave_6_out_r;
    reg [15:0] wave_7_out_r;
    reg [15:0] wave_8_out_r;
    reg [15:0] wave_9_out_r;
    reg [15:0] wave_a_out_r;
    reg [15:0] wave_b_out_r;
    reg [15:0] wave_c_out_r;
    reg [15:0] wave_d_out_r;
    reg [15:0] wave_e_out_r;
    reg [15:0] wave_f_out_r;

    always @(posedge AD3542_CLK) begin
	if(wave_0_valid) wave_0_out_r <= wave_0_out;
	if(wave_1_valid) wave_1_out_r <= wave_1_out;
	if(wave_2_valid) wave_2_out_r <= wave_2_out;
	if(wave_3_valid) wave_3_out_r <= wave_3_out;
	if(wave_4_valid) wave_4_out_r <= wave_4_out;
	if(wave_5_valid) wave_5_out_r <= wave_5_out;
	if(wave_6_valid) wave_6_out_r <= wave_6_out;
	if(wave_7_valid) wave_7_out_r <= wave_7_out;
	if(wave_8_valid) wave_8_out_r <= wave_8_out;
	if(wave_9_valid) wave_9_out_r <= wave_9_out;
	if(wave_a_valid) wave_a_out_r <= wave_a_out;
	if(wave_b_valid) wave_b_out_r <= wave_b_out;
	if(wave_c_valid) wave_c_out_r <= wave_c_out;
	if(wave_d_valid) wave_d_out_r <= wave_d_out;
	if(wave_e_valid) wave_e_out_r <= wave_e_out;
	if(wave_f_valid) wave_f_out_r <= wave_f_out;
    end

    assign dac_0_0 = debug_mode == 1'b0 ? wave_0_out_r : dac_test_val;
    assign dac_1_0 = debug_mode == 1'b0 ? wave_1_out_r : dac_test_val;
    assign dac_0_1 = debug_mode == 1'b0 ? wave_2_out_r : dac_test_val;
    assign dac_1_1 = debug_mode == 1'b0 ? wave_3_out_r : dac_test_val;
    assign dac_0_2 = debug_mode == 1'b0 ? wave_4_out_r : dac_test_val;
    assign dac_1_2 = debug_mode == 1'b0 ? wave_5_out_r : dac_test_val;
    assign dac_0_3 = debug_mode == 1'b0 ? wave_6_out_r : dac_test_val;
    assign dac_1_3 = debug_mode == 1'b0 ? wave_7_out_r : dac_test_val;
    assign dac_0_4 = debug_mode == 1'b0 ? wave_8_out_r : dac_test_val;
    assign dac_1_4 = debug_mode == 1'b0 ? wave_9_out_r : dac_test_val;
    assign dac_0_5 = debug_mode == 1'b0 ? wave_a_out_r : dac_test_val;
    assign dac_1_5 = debug_mode == 1'b0 ? wave_b_out_r : dac_test_val;
    assign dac_0_6 = debug_mode == 1'b0 ? wave_c_out_r : dac_test_val;
    assign dac_1_6 = debug_mode == 1'b0 ? wave_d_out_r : dac_test_val;
    assign dac_0_7 = debug_mode == 1'b0 ? wave_e_out_r : dac_test_val;
    assign dac_1_7 = debug_mode == 1'b0 ? wave_f_out_r : dac_test_val;
    
    wire FCLK_CLK0_0;
    wire [15:0] bram_addr_a_0;
    wire [15:0] bram_addr_a_1;
    wire bram_clk_a_0;
    wire bram_clk_a_1;
    wire bram_en_a_0;
    wire bram_en_a_1;
    wire [31:0] bram_rddata_a_0;
    wire [31:0] bram_rddata_a_1;
    wire bram_rst_a_0;
    wire bram_rst_a_1;
    wire [3:0] bram_we_a_0;
    wire [7:0] bram_we_a_1;
    wire [31:0] bram_wrdata_a_0;
    wire [63:0] bram_wrdata_a_1;
    wire [31:0] gpio2_io_i_0;
    wire [31:0] gpio_io_o_0;

    design_1_wrapper (
		      .DDR_addr(DDR_addr),
		      .DDR_ba(DDR_ba),
		      .DDR_cas_n(DDR_cas_n),
		      .DDR_ck_n(DDR_ck_n),
		      .DDR_ck_p(DDR_ck_p),
		      .DDR_cke(DDR_cke),
		      .DDR_cs_n(DDR_cs_n),
		      .DDR_dm(DDR_dm),
		      .DDR_dq(DDR_dq),
		      .DDR_dqs_n(DDR_dqs_n),
		      .DDR_dqs_p(DDR_dqs_p),
		      .DDR_odt(DDR_odt),
		      .DDR_ras_n(DDR_ras_n),
		      .DDR_reset_n(DDR_reset_n),
		      .DDR_we_n(DDR_we_n),
		      .FCLK_CLK0_0(FCLK_CLK0_0),
		      .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
		      .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
		      .FIXED_IO_mio(FIXED_IO_mio),
		      .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
		      .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
		      .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
		      .bram_addr_a_0(bram_addr_a_0),
		      .bram_addr_a_1(bram_addr_a_1),
		      .bram_clk_a_0(bram_clk_a_0),
		      .bram_clk_a_1(bram_clk_a_1),
		      .bram_en_a_0(bram_en_a_0),
		      .bram_en_a_1(bram_en_a_1),
		      .bram_rddata_a_0(bram_rddata_a_0),
		      .bram_rddata_a_1(bram_rddata_a_1),
		      .bram_rst_a_0(bram_rst_a_0),
		      .bram_rst_a_1(bram_rst_a_1),
		      .bram_we_a_0(bram_we_a_0),
		      .bram_we_a_1(bram_we_a_1),
		      .bram_wrdata_a_0(bram_wrdata_a_0),
		      .bram_wrdata_a_1(bram_wrdata_a_1),
		      .gpio2_io_i_0(gpio2_io_i_0),
		      .gpio_io_o_0(gpio_io_o_0)
		      );

    wire [4:0] mawg_ctrl_addr_in;
    wire [41:0] mawg_ctrl_data_in;
    wire [13:0] mawg_wave_addr_in;
    wire [15:0] mawg_wave_data_in;

    assign mawg_ctrl_addr_in = bram_addr_a_1[10:3];
    assign mawg_ctrl_data_in = bram_wrdata_a_1[41:0];
    assign mawg_wave_addr_in = bram_addr_a_0[15:2];
    assign mawg_wave_data_in = bram_wrdata_a_0[15:0];

    wire [31:0] mawg_cr;
    wire [31:0] mawg_status;

    assign mawg_cr = gpio_io_o_0;
    assign gpio2_io_i_0 = mawg_status;

    assign mawg_ctrl_addr = mawg_ctrl_addr_in[0:0];
    assign mawg_ctrl_we = bram_we_a_1[0];
    assign mawg_ctrl_data = mawg_ctrl_data_in;

    assign mawg_wave_addr = mawg_wave_addr_in[9:0];
    assign mawg_wave_we = bram_we_a_0[0];
    assign mawg_wave_data = mawg_wave_data_in;

    assign mawg_0_ctrl_we = mawg_ctrl_addr_in[4:1] == 4'h0 ? 1'b1 : 1'b0;
    assign mawg_1_ctrl_we = mawg_ctrl_addr_in[4:1] == 4'h1 ? 1'b1 : 1'b0;
    assign mawg_2_ctrl_we = mawg_ctrl_addr_in[4:1] == 4'h2 ? 1'b1 : 1'b0;
    assign mawg_3_ctrl_we = mawg_ctrl_addr_in[4:1] == 4'h3 ? 1'b1 : 1'b0;
    assign mawg_4_ctrl_we = mawg_ctrl_addr_in[4:1] == 4'h4 ? 1'b1 : 1'b0;
    assign mawg_5_ctrl_we = mawg_ctrl_addr_in[4:1] == 4'h5 ? 1'b1 : 1'b0;
    assign mawg_6_ctrl_we = mawg_ctrl_addr_in[4:1] == 4'h6 ? 1'b1 : 1'b0;
    assign mawg_7_ctrl_we = mawg_ctrl_addr_in[4:1] == 4'h7 ? 1'b1 : 1'b0;
    assign mawg_8_ctrl_we = mawg_ctrl_addr_in[4:1] == 4'h8 ? 1'b1 : 1'b0;
    assign mawg_9_ctrl_we = mawg_ctrl_addr_in[4:1] == 4'h9 ? 1'b1 : 1'b0;
    assign mawg_a_ctrl_we = mawg_ctrl_addr_in[4:1] == 4'ha ? 1'b1 : 1'b0;
    assign mawg_b_ctrl_we = mawg_ctrl_addr_in[4:1] == 4'hb ? 1'b1 : 1'b0;
    assign mawg_c_ctrl_we = mawg_ctrl_addr_in[4:1] == 4'hc ? 1'b1 : 1'b0;
    assign mawg_d_ctrl_we = mawg_ctrl_addr_in[4:1] == 4'hd ? 1'b1 : 1'b0;
    assign mawg_e_ctrl_we = mawg_ctrl_addr_in[4:1] == 4'he ? 1'b1 : 1'b0;
    assign mawg_f_ctrl_we = mawg_ctrl_addr_in[4:1] == 4'hf ? 1'b1 : 1'b0;

    assign mawg_0_wave_we = mawg_wave_addr_in[13:10] == 4'h0 ? 1'b1 : 1'b0;
    assign mawg_1_wave_we = mawg_wave_addr_in[13:10] == 4'h1 ? 1'b1 : 1'b0;
    assign mawg_2_wave_we = mawg_wave_addr_in[13:10] == 4'h2 ? 1'b1 : 1'b0;
    assign mawg_3_wave_we = mawg_wave_addr_in[13:10] == 4'h3 ? 1'b1 : 1'b0;
    assign mawg_4_wave_we = mawg_wave_addr_in[13:10] == 4'h4 ? 1'b1 : 1'b0;
    assign mawg_5_wave_we = mawg_wave_addr_in[13:10] == 4'h5 ? 1'b1 : 1'b0;
    assign mawg_6_wave_we = mawg_wave_addr_in[13:10] == 4'h6 ? 1'b1 : 1'b0;
    assign mawg_7_wave_we = mawg_wave_addr_in[13:10] == 4'h7 ? 1'b1 : 1'b0;
    assign mawg_8_wave_we = mawg_wave_addr_in[13:10] == 4'h8 ? 1'b1 : 1'b0;
    assign mawg_9_wave_we = mawg_wave_addr_in[13:10] == 4'h9 ? 1'b1 : 1'b0;
    assign mawg_a_wave_we = mawg_wave_addr_in[13:10] == 4'ha ? 1'b1 : 1'b0;
    assign mawg_b_wave_we = mawg_wave_addr_in[13:10] == 4'hb ? 1'b1 : 1'b0;
    assign mawg_c_wave_we = mawg_wave_addr_in[13:10] == 4'hc ? 1'b1 : 1'b0;
    assign mawg_d_wave_we = mawg_wave_addr_in[13:10] == 4'hd ? 1'b1 : 1'b0;
    assign mawg_e_wave_we = mawg_wave_addr_in[13:10] == 4'he ? 1'b1 : 1'b0;
    assign mawg_f_wave_we = mawg_wave_addr_in[13:10] == 4'hf ? 1'b1 : 1'b0;

    assign mawg_force_stop = mawg_cr[1];
    assign mawg_repetition = mawg_cr[17:2];
    assign mawg_ctrl_length = mawg_cr[21:18];

    reg mawg_cr_0_d;
    always @(posedge AD3542_CLK) begin
	mawg_cr_0_d <= mawg_cr[0];
    end
    assign mawg_kick = mawg_cr[0] == 1 && mawg_cr_0_d == 0 ? 1'b1 : 1'b0;

    assign mawg_status[0]  = mawg_0_busy;
    assign mawg_status[1]  = mawg_1_busy;
    assign mawg_status[2]  = mawg_2_busy;
    assign mawg_status[3]  = mawg_3_busy;
    assign mawg_status[4]  = mawg_4_busy;
    assign mawg_status[5]  = mawg_5_busy;
    assign mawg_status[6]  = mawg_6_busy;
    assign mawg_status[7]  = mawg_7_busy;
    assign mawg_status[8]  = mawg_8_busy;
    assign mawg_status[9]  = mawg_9_busy;
    assign mawg_status[10] = mawg_a_busy;
    assign mawg_status[11] = mawg_b_busy;
    assign mawg_status[12] = mawg_c_busy;
    assign mawg_status[13] = mawg_d_busy;
    assign mawg_status[14] = mawg_e_busy;
    assign mawg_status[15] = mawg_f_busy;

    assign AD3542_CLK = FCLK_CLK0_0;

endmodule

`default_nettype wire
