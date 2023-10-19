module ad5342_iface_top (
   input wire GCLK, // MAX 132MHz

   input wire[7:0] SW,
   output wire[7:0] LD,

   output wire spi_sclk_0, // MAX 66MHz
   output wire spi_cs_0,
   output wire spi_sdio0_0,
   output wire spi_sdio1_0,

   output wire spi_sclk_1, // MAX 66MHz
   output wire spi_cs_1,
   output wire spi_sdio0_1,
   output wire spi_sdio1_1,

   output wire ad3542_reset_x,
   output wire ldac_0,
   output wire ldac_1
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

reg [15:0] dac_0_0;
reg [15:0] dac_1_0;

reg [15:0] dac_0_1;
reg [15:0] dac_1_1;

reg sw0_d;
reg sw0_dd;
always @(posedge AD3524_CLK) begin
    sw0_d <= SW[0];
    sw0_dd <= sw0_d;
end

reg [6:0] mode_d;
reg [6:0] mode_dd;

always @(posedge AD3524_CLK) begin
   mode_d <= SW[7:1];
   mode_dd <= mode_d;
end

always @(posedge AD3524_CLK) begin
   if(mode_dd == 7'd1) begin
      dac_0_0 <= 16'hFFFF;
      dac_1_0 <= 16'hFFFF;
      dac_0_1 <= 16'hFFFF;
      dac_1_1 <= 16'hFFFF;
   end else if(mode_dd == 7'd2) begin
      dac_0_0 <= 16'h7FFF;
      dac_1_0 <= 16'h7FFF;
      dac_0_1 <= 16'h7FFF;
      dac_1_1 <= 16'h7FFF;
   end else if(mode_dd == 7'd3) begin
      dac_0_0 <= 16'h0FFF;
      dac_1_0 <= 16'h0FFF;
      dac_0_1 <= 16'h0FFF;
      dac_1_1 <= 16'h0FFF;
   end else if(mode_dd == 7'd4) begin
      dac_0_0 <= 16'h07FF;
      dac_1_0 <= 16'h07FF;
      dac_0_1 <= 16'h07FF;
      dac_1_1 <= 16'h07FF;
   end else if(mode_dd == 7'd5) begin
      dac_0_0 <= 16'h8000;
      dac_1_0 <= 16'h8000;
      dac_0_1 <= 16'h8000;
      dac_1_1 <= 16'h8000;
   end else if(mode_dd == 7'd6) begin
      dac_0_0 <= 16'h8800;
      dac_1_0 <= 16'h8800;
      dac_0_1 <= 16'h8800;
      dac_1_1 <= 16'h8800;
   end else begin
      dac_0_0 <= 16'h0000;
      dac_1_0 <= 16'h0000;
      dac_0_1 <= 16'h0000;
      dac_1_1 <= 16'h0000;
   end
end

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

endmodule
