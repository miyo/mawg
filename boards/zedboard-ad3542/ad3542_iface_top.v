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

   output wire [7:0] JA,
  
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

    (* mark_debug = "true" *) wire [15:0] dac_0_0;
    (* mark_debug = "true" *) wire [15:0] dac_1_0;
    
    (* mark_debug = "true" *) wire [15:0] dac_0_1;
    (* mark_debug = "true" *) wire [15:0] dac_1_1;

    (* mark_debug = "true" *) wire [15:0] dac_0_2;
    (* mark_debug = "true" *) wire [15:0] dac_1_2;

    (* mark_debug = "true" *) wire [15:0] dac_0_3;
    (* mark_debug = "true" *) wire [15:0] dac_1_3;

    (* mark_debug = "true" *) wire [15:0] dac_0_4;
    (* mark_debug = "true" *) wire [15:0] dac_1_4;

    (* mark_debug = "true" *) wire [15:0] dac_0_5;
    (* mark_debug = "true" *) wire [15:0] dac_1_5;

    (* mark_debug = "true" *) wire [15:0] dac_0_6;
    (* mark_debug = "true" *) wire [15:0] dac_1_6;

    (* mark_debug = "true" *) wire [15:0] dac_0_7;
    (* mark_debug = "true" *) wire [15:0] dac_1_7;

    reg [7:0] sw_d;
    reg [7:0] sw_dd;
    always @(posedge AD3542_CLK) begin
	sw_d <= SW;
	sw_dd <= sw_d;
    end

    (* mark_debug = "true" *) wire sys_reset;
    assign sys_reset = sw_dd[0];

    (* mark_debug = "true" *) wire debug_mode;
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
    assign FMC_LED = ad3524_clk_counter[23];

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

    (* mark_debug = "true" *) wire [8:0] mawg_wave_addr;
    (* mark_debug = "true" *) wire [15:0] mawg_wave_data;

    (* mark_debug = "true" *) wire mawg_kick;
    (* mark_debug = "true" *) wire mawg_force_stop;
    (* mark_debug = "true" *) wire [8:0] mawg_data_num;
    (* mark_debug = "true" *) wire [22:0] mawg_repetition;
    (* mark_debug = "true" *) wire [31:0] mawg_wait_num;

    (* mark_debug = "true" *) wire mawg_0_wave_we;
    (* mark_debug = "true" *) wire mawg_0_busy;
    (* mark_debug = "true" *) wire wave_0_valid;
    (* mark_debug = "true" *) wire [15:0] wave_0_out;

    sequencer sequencer_0 (
			   .clk(AD3542_CLK),
			   .reset(sys_reset),
			   .write_addr(mawg_wave_addr),
			   .write_data(mawg_wave_data),
			   .write_en(mawg_0_wave_we),
			   .data_num(mawg_data_num),
			   .repetition(mawg_repetition),
			   .wait_num(mawg_wait_num),
			   .kick(mawg_kick),
			   .stop(mawg_force_stop),
			   .busy(mawg_0_busy),
			   .data_out(wave_0_out),
			   .valid_out(wave_0_valid)
			   );

    (* mark_debug = "true" *) wire mawg_1_wave_we;
    (* mark_debug = "true" *) wire mawg_1_busy;
    (* mark_debug = "true" *) wire wave_1_valid;
    (* mark_debug = "true" *) wire [15:0] wave_1_out;
    
    sequencer sequencer_1 (
			   .clk(AD3542_CLK),
			   .reset(sys_reset),
			   .write_addr(mawg_wave_addr),
			   .write_data(mawg_wave_data),
			   .write_en(mawg_1_wave_we),
			   .data_num(mawg_data_num),
			   .repetition(mawg_repetition),
			   .wait_num(mawg_wait_num),
			   .kick(mawg_kick),
			   .stop(mawg_force_stop),
			   .busy(mawg_1_busy),
			   .data_out(wave_1_out),
			   .valid_out(wave_1_valid)
			   );

    (* mark_debug = "true" *) wire mawg_2_wave_we;
    (* mark_debug = "true" *) wire mawg_2_busy;
    (* mark_debug = "true" *) wire wave_2_valid;
    (* mark_debug = "true" *) wire [15:0] wave_2_out;

    sequencer sequencer_2 (
			   .clk(AD3542_CLK),
			   .reset(sys_reset),
			   .write_addr(mawg_wave_addr),
			   .write_data(mawg_wave_data),
			   .write_en(mawg_2_wave_we),
			   .data_num(mawg_data_num),
			   .repetition(mawg_repetition),
			   .wait_num(mawg_wait_num),
			   .kick(mawg_kick),
			   .stop(mawg_force_stop),
			   .busy(mawg_2_busy),
			   .data_out(wave_2_out),
			   .valid_out(wave_2_valid)
			   );

    (* mark_debug = "true" *) wire mawg_3_wave_we;
    (* mark_debug = "true" *) wire mawg_3_busy;
    (* mark_debug = "true" *) wire wave_3_valid;
    (* mark_debug = "true" *) wire [15:0] wave_3_out;

    sequencer sequencer_3 (
			   .clk(AD3542_CLK),
			   .reset(sys_reset),
			   .write_addr(mawg_wave_addr),
			   .write_data(mawg_wave_data),
			   .write_en(mawg_3_wave_we),
			   .data_num(mawg_data_num),
			   .repetition(mawg_repetition),
			   .wait_num(mawg_wait_num),
			   .kick(mawg_kick),
			   .stop(mawg_force_stop),
			   .busy(mawg_3_busy),
			   .data_out(wave_3_out),
			   .valid_out(wave_3_valid)
			   );

    (* mark_debug = "true" *) wire mawg_4_wave_we;
    (* mark_debug = "true" *) wire mawg_4_busy;
    (* mark_debug = "true" *) wire wave_4_valid;
    (* mark_debug = "true" *) wire [15:0] wave_4_out;

    sequencer sequencer_4 (
			   .clk(AD3542_CLK),
			   .reset(sys_reset),
			   .write_addr(mawg_wave_addr),
			   .write_data(mawg_wave_data),
			   .write_en(mawg_4_wave_we),
			   .data_num(mawg_data_num),
			   .repetition(mawg_repetition),
			   .wait_num(mawg_wait_num),
			   .kick(mawg_kick),
			   .stop(mawg_force_stop),
			   .busy(mawg_4_busy),
			   .data_out(wave_4_out),
			   .valid_out(wave_4_valid)
			   );

    (* mark_debug = "true" *) wire mawg_5_wave_we;
    (* mark_debug = "true" *) wire mawg_5_busy;
    (* mark_debug = "true" *) wire wave_5_valid;
    (* mark_debug = "true" *) wire [15:0] wave_5_out;

    sequencer sequencer_5 (
			   .clk(AD3542_CLK),
			   .reset(sys_reset),
			   .write_addr(mawg_wave_addr),
			   .write_data(mawg_wave_data),
			   .write_en(mawg_5_wave_we),
			   .data_num(mawg_data_num),
			   .repetition(mawg_repetition),
			   .wait_num(mawg_wait_num),
			   .kick(mawg_kick),
			   .stop(mawg_force_stop),
			   .busy(mawg_5_busy),
			   .data_out(wave_5_out),
			   .valid_out(wave_5_valid)
			   );

    (* mark_debug = "true" *) wire mawg_6_wave_we;
    (* mark_debug = "true" *) wire mawg_6_busy;
    (* mark_debug = "true" *) wire wave_6_valid;
    (* mark_debug = "true" *) wire [15:0] wave_6_out;
    
    sequencer sequencer_6 (
			   .clk(AD3542_CLK),
			   .reset(sys_reset),
			   .write_addr(mawg_wave_addr),
			   .write_data(mawg_wave_data),
			   .write_en(mawg_6_wave_we),
			   .data_num(mawg_data_num),
			   .repetition(mawg_repetition),
			   .wait_num(mawg_wait_num),
			   .kick(mawg_kick),
			   .stop(mawg_force_stop),
			   .busy(mawg_6_busy),
			   .data_out(wave_6_out),
			   .valid_out(wave_6_valid)
			   );

    (* mark_debug = "true" *) wire mawg_7_wave_we;
    (* mark_debug = "true" *) wire mawg_7_busy;
    (* mark_debug = "true" *) wire wave_7_valid;
    (* mark_debug = "true" *) wire [15:0] wave_7_out;

    sequencer sequencer_7 (
			   .clk(AD3542_CLK),
			   .reset(sys_reset),
			   .write_addr(mawg_wave_addr),
			   .write_data(mawg_wave_data),
			   .write_en(mawg_7_wave_we),
			   .data_num(mawg_data_num),
			   .repetition(mawg_repetition),
			   .wait_num(mawg_wait_num),
			   .kick(mawg_kick),
			   .stop(mawg_force_stop),
			   .busy(mawg_7_busy),
			   .data_out(wave_7_out),
			   .valid_out(wave_7_valid)
			   );

    (* mark_debug = "true" *) wire mawg_8_wave_we;
    (* mark_debug = "true" *) wire mawg_8_busy;
    (* mark_debug = "true" *) wire wave_8_valid;
    (* mark_debug = "true" *) wire [15:0] wave_8_out;

    sequencer sequencer_8 (
			   .clk(AD3542_CLK),
			   .reset(sys_reset),
			   .write_addr(mawg_wave_addr),
			   .write_data(mawg_wave_data),
			   .write_en(mawg_8_wave_we),
			   .data_num(mawg_data_num),
			   .repetition(mawg_repetition),
			   .wait_num(mawg_wait_num),
			   .kick(mawg_kick),
			   .stop(mawg_force_stop),
			   .busy(mawg_8_busy),
			   .data_out(wave_8_out),
			   .valid_out(wave_8_valid)
			   );

    (* mark_debug = "true" *) wire mawg_9_wave_we;
    (* mark_debug = "true" *) wire mawg_9_busy;
    (* mark_debug = "true" *) wire wave_9_valid;
    (* mark_debug = "true" *) wire [15:0] wave_9_out;

    sequencer sequencer_9 (
			   .clk(AD3542_CLK),
			   .reset(sys_reset),
			   .write_addr(mawg_wave_addr),
			   .write_data(mawg_wave_data),
			   .write_en(mawg_9_wave_we),
			   .data_num(mawg_data_num),
			   .repetition(mawg_repetition),
			   .wait_num(mawg_wait_num),
			   .kick(mawg_kick),
			   .stop(mawg_force_stop),
			   .busy(mawg_9_busy),
			   .data_out(wave_9_out),
			   .valid_out(wave_9_valid)
			   );

    (* mark_debug = "true" *) wire mawg_a_wave_we;
    (* mark_debug = "true" *) wire mawg_a_busy;
    (* mark_debug = "true" *) wire wave_a_valid;
    (* mark_debug = "true" *) wire [15:0] wave_a_out;

    sequencer sequencer_a (
			   .clk(AD3542_CLK),
			   .reset(sys_reset),
			   .write_addr(mawg_wave_addr),
			   .write_data(mawg_wave_data),
			   .write_en(mawg_a_wave_we),
			   .data_num(mawg_data_num),
			   .repetition(mawg_repetition),
			   .wait_num(mawg_wait_num),
			   .kick(mawg_kick),
			   .stop(mawg_force_stop),
			   .busy(mawg_a_busy),
			   .data_out(wave_a_out),
			   .valid_out(wave_a_valid)
			   );

    (* mark_debug = "true" *) wire mawg_b_wave_we;
    (* mark_debug = "true" *) wire mawg_b_busy;
    (* mark_debug = "true" *) wire wave_b_valid;
    (* mark_debug = "true" *) wire [15:0] wave_b_out;

    sequencer sequencer_b (
			   .clk(AD3542_CLK),
			   .reset(sys_reset),
			   .write_addr(mawg_wave_addr),
			   .write_data(mawg_wave_data),
			   .write_en(mawg_b_wave_we),
			   .data_num(mawg_data_num),
			   .repetition(mawg_repetition),
			   .wait_num(mawg_wait_num),
			   .kick(mawg_kick),
			   .stop(mawg_force_stop),
			   .busy(mawg_b_busy),
			   .data_out(wave_b_out),
			   .valid_out(wave_b_valid)
			   );

    (* mark_debug = "true" *) wire mawg_c_wave_we;
    (* mark_debug = "true" *) wire mawg_c_busy;
    (* mark_debug = "true" *) wire wave_c_valid;
    (* mark_debug = "true" *) wire [15:0] wave_c_out;

    sequencer sequencer_c (
			   .clk(AD3542_CLK),
			   .reset(sys_reset),
			   .write_addr(mawg_wave_addr),
			   .write_data(mawg_wave_data),
			   .write_en(mawg_c_wave_we),
			   .data_num(mawg_data_num),
			   .repetition(mawg_repetition),
			   .wait_num(mawg_wait_num),
			   .kick(mawg_kick),
			   .stop(mawg_force_stop),
			   .busy(mawg_c_busy),
			   .data_out(wave_c_out),
			   .valid_out(wave_c_valid)
			   );

    (* mark_debug = "true" *) wire mawg_d_wave_we;
    (* mark_debug = "true" *) wire mawg_d_busy;
    (* mark_debug = "true" *) wire wave_d_valid;
    (* mark_debug = "true" *) wire [15:0] wave_d_out;

    sequencer sequencer_d (
			   .clk(AD3542_CLK),
			   .reset(sys_reset),
			   .write_addr(mawg_wave_addr),
			   .write_data(mawg_wave_data),
			   .write_en(mawg_d_wave_we),
			   .data_num(mawg_data_num),
			   .repetition(mawg_repetition),
			   .wait_num(mawg_wait_num),
			   .kick(mawg_kick),
			   .stop(mawg_force_stop),
			   .busy(mawg_d_busy),
			   .data_out(wave_d_out),
			   .valid_out(wave_d_valid)
			   );

    (* mark_debug = "true" *) wire mawg_e_wave_we;
    (* mark_debug = "true" *) wire mawg_e_busy;
    (* mark_debug = "true" *) wire wave_e_valid;
    (* mark_debug = "true" *) wire [15:0] wave_e_out;

    sequencer sequencer_e (
			   .clk(AD3542_CLK),
			   .reset(sys_reset),
			   .write_addr(mawg_wave_addr),
			   .write_data(mawg_wave_data),
			   .write_en(mawg_e_wave_we),
			   .data_num(mawg_data_num),
			   .repetition(mawg_repetition),
			   .wait_num(mawg_wait_num),
			   .kick(mawg_kick),
			   .stop(mawg_force_stop),
			   .busy(mawg_e_busy),
			   .data_out(wave_e_out),
			   .valid_out(wave_e_valid)
			   );

    (* mark_debug = "true" *) wire mawg_f_wave_we;
    (* mark_debug = "true" *) wire mawg_f_busy;
    (* mark_debug = "true" *) wire wave_f_valid;
    (* mark_debug = "true" *) wire [15:0] wave_f_out;

    sequencer sequencer_f (
			   .clk(AD3542_CLK),
			   .reset(sys_reset),
			   .write_addr(mawg_wave_addr),
			   .write_data(mawg_wave_data),
			   .write_en(mawg_f_wave_we),
			   .data_num(mawg_data_num),
			   .repetition(mawg_repetition),
			   .wait_num(mawg_wait_num),
			   .kick(mawg_kick),
			   .stop(mawg_force_stop),
			   .busy(mawg_f_busy),
			   .data_out(wave_f_out),
			   .valid_out(wave_f_valid)
			   );

    (* mark_debug = "true" *) wire mawg_10_wave_we;
    (* mark_debug = "true" *) wire mawg_10_busy;
    (* mark_debug = "true" *) wire wave_10_valid;
    (* mark_debug = "true" *) wire [15:0] wave_10_out;

    sequencer sequencer_10 (
			   .clk(AD3542_CLK),
			   .reset(sys_reset),
			   .write_addr(mawg_wave_addr),
			   .write_data(mawg_wave_data),
			   .write_en(mawg_10_wave_we),
			   .data_num(mawg_data_num),
			   .repetition(mawg_repetition),
			   .wait_num(mawg_wait_num),
			   .kick(mawg_kick),
			   .stop(mawg_force_stop),
			   .busy(mawg_10_busy),
			   .data_out(wave_10_out),
			   .valid_out(wave_10_valid)
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

    reg [15:0] wave_10_out_r;

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

	if(wave_10_valid) wave_10_out_r <= wave_10_out;
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

    assign JA = wave_10_out_r[7:0];
    
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
    wire [3:0] bram_we_a_1;
    wire [31:0] bram_wrdata_a_0;
    wire [31:0] bram_wrdata_a_1;
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

    wire [13:0] mawg_wave_addr_in;
    wire [15:0] mawg_wave_data_in;

    assign mawg_wave_addr_in = bram_addr_a_0[15:2];
    assign mawg_wave_data_in = bram_wrdata_a_0[15:0];

    reg [63:0] mawg_ctrl_value;
    always @(posedge FCLK_CLK0_0) begin
	if(bram_we_a_1[0] == 1)begin
	    if(bram_addr_a_1[2] == 0) begin
		mawg_ctrl_value[31:0] = bram_wrdata_a_1;
	    end else begin
		mawg_ctrl_value[63:32] = bram_wrdata_a_1;
	    end
	end
    end

    assign mawg_data_num   = mawg_ctrl_value[8:0];
    assign mawg_repetition = mawg_ctrl_value[31:9];
    assign mawg_wait_num   = mawg_ctrl_value[63:32];

    wire [31:0] mawg_cr;
    wire [31:0] mawg_status;

    assign mawg_cr = gpio_io_o_0;
    assign gpio2_io_i_0 = mawg_status;

    assign mawg_wave_addr = mawg_wave_addr_in[8:0];
    assign mawg_wave_data = mawg_wave_data_in;

    assign mawg_0_wave_we = mawg_wave_addr_in[13:9] == 5'd0  ? bram_we_a_0[0] : 1'b0;
    assign mawg_1_wave_we = mawg_wave_addr_in[13:9] == 5'd1  ? bram_we_a_0[0] : 1'b0;
    assign mawg_2_wave_we = mawg_wave_addr_in[13:9] == 5'd2  ? bram_we_a_0[0] : 1'b0;
    assign mawg_3_wave_we = mawg_wave_addr_in[13:9] == 5'd3  ? bram_we_a_0[0] : 1'b0;
    assign mawg_4_wave_we = mawg_wave_addr_in[13:9] == 5'd4  ? bram_we_a_0[0] : 1'b0;
    assign mawg_5_wave_we = mawg_wave_addr_in[13:9] == 5'd5  ? bram_we_a_0[0] : 1'b0;
    assign mawg_6_wave_we = mawg_wave_addr_in[13:9] == 5'd6  ? bram_we_a_0[0] : 1'b0;
    assign mawg_7_wave_we = mawg_wave_addr_in[13:9] == 5'd7  ? bram_we_a_0[0] : 1'b0;
    assign mawg_8_wave_we = mawg_wave_addr_in[13:9] == 5'd8  ? bram_we_a_0[0] : 1'b0;
    assign mawg_9_wave_we = mawg_wave_addr_in[13:9] == 5'd9  ? bram_we_a_0[0] : 1'b0;
    assign mawg_a_wave_we = mawg_wave_addr_in[13:9] == 5'd10 ? bram_we_a_0[0] : 1'b0;
    assign mawg_b_wave_we = mawg_wave_addr_in[13:9] == 5'd11 ? bram_we_a_0[0] : 1'b0;
    assign mawg_c_wave_we = mawg_wave_addr_in[13:9] == 5'd12 ? bram_we_a_0[0] : 1'b0;
    assign mawg_d_wave_we = mawg_wave_addr_in[13:9] == 5'd13 ? bram_we_a_0[0] : 1'b0;
    assign mawg_e_wave_we = mawg_wave_addr_in[13:9] == 5'd14 ? bram_we_a_0[0] : 1'b0;
    assign mawg_f_wave_we = mawg_wave_addr_in[13:9] == 5'd15 ? bram_we_a_0[0] : 1'b0;

    assign mawg_10_wave_we = mawg_wave_addr_in[13:9] == 5'd16 ? bram_we_a_0[0] : 1'b0;

    assign mawg_force_stop = mawg_cr[1];

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
    assign mawg_status[16] = mawg_10_busy;

    assign AD3542_CLK = FCLK_CLK0_0;

    dac_data_ila dac_data_ila_i(
				.clk(AD3542_CLK),
				.probe0(dac_0_0),
				.probe1(dac_1_0),
				.probe2(dac_0_1),
				.probe3(dac_1_1),
				.probe4(dac_0_2),
				.probe5(dac_1_2),
				.probe6(dac_0_3),
				.probe7(dac_1_3),
				.probe8(dac_0_4),
				.probe9(dac_1_4),
				.probe10(dac_0_5),
				.probe11(dac_1_5),
				.probe12(dac_0_6),
				.probe13(dac_1_6),
				.probe14(dac_0_7),
				.probe15(dac_1_7)
				);

    sys_ila sys_ila_i(
		      .clk(AD3542_CLK),
		      .probe0({sys_reset, debug_mode}), // 2
		      .probe1({mawg_wave_addr, // 9
			       mawg_wave_data, // 16
			       mawg_0_wave_we, // 1
			       mawg_1_wave_we, // 1
			       mawg_2_wave_we, // 1
			       mawg_3_wave_we, // 1
			       mawg_4_wave_we, // 1
			       mawg_5_wave_we, // 1
			       mawg_6_wave_we, // 1
			       mawg_7_wave_we, // 1
			       mawg_8_wave_we, // 1
			       mawg_9_wave_we, // 1
			       mawg_a_wave_we, // 1
			       mawg_b_wave_we, // 1
			       mawg_c_wave_we, // 1
			       mawg_d_wave_we, // 1
			       mawg_e_wave_we, // 1
			       mawg_f_wave_we, // 1
			       mawg_10_wave_we // 1
			       }), // (+ 9 16 17)42
		      .probe2({mawg_kick, // 1
			       mawg_force_stop // 1
			       }), // (+ 1 1)2
		      .probe3({mawg_data_num, // 9
			       mawg_repetition, // 23
			       mawg_wait_num // 32
			       }), // (+ 9 23 32)64
		      .probe4({mawg_0_busy, wave_0_valid, wave_0_out}), // (+ 1 1 16)18
		      .probe5({mawg_1_busy, wave_1_valid, wave_1_out}), // (+ 1 1 16)18
		      .probe6({mawg_2_busy, wave_2_valid, wave_2_out}), // (+ 1 1 16)18
		      .probe7({mawg_3_busy, wave_3_valid, wave_3_out}), // (+ 1 1 16)18
		      .probe8({mawg_4_busy, wave_4_valid, wave_4_out}), // (+ 1 1 16)18
		      .probe9({mawg_5_busy, wave_5_valid, wave_5_out}), // (+ 1 1 16)18
		      .probe10({mawg_6_busy, wave_6_valid, wave_6_out}), // (+ 1 1 16)18
		      .probe11({mawg_7_busy, wave_7_valid, wave_7_out}), // (+ 1 1 16)18
		      .probe12({mawg_8_busy, wave_8_valid, wave_8_out}), // (+ 1 1 16)18
		      .probe13({mawg_9_busy, wave_9_valid, wave_9_out}), // (+ 1 1 16)18
		      .probe14({mawg_a_busy, wave_a_valid, wave_a_out}), // (+ 1 1 16)18
		      .probe15({mawg_b_busy, wave_b_valid, wave_b_out}), // (+ 1 1 16)18
		      .probe16({mawg_c_busy, wave_c_valid, wave_c_out}), // (+ 1 1 16)18
		      .probe17({mawg_d_busy, wave_d_valid, wave_d_out}), // (+ 1 1 16)18
		      .probe18({mawg_e_busy, wave_e_valid, wave_e_out}), // (+ 1 1 16)18
		      .probe19({mawg_f_busy, wave_f_valid, wave_f_out}), // (+ 1 1 16)18
		      .probe20({mawg_10_busy, wave_10_valid, wave_10_out})  // (+ 1 1 16)18
		      );

endmodule

`default_nettype wire
