
//`define ENABLE_HPS

module top(

      ///////// ADC /////////
      inout              ADC_CS_N,
      output             ADC_DIN,
      input              ADC_DOUT,
      output             ADC_SCLK,

      ///////// AUD /////////
      input              AUD_ADCDAT,
      inout              AUD_ADCLRCK,
      inout              AUD_BCLK,
      output             AUD_DACDAT,
      inout              AUD_DACLRCK,
      output             AUD_XCK,

      ///////// CLOCK2 /////////
      input              CLOCK2_50,

      ///////// CLOCK3 /////////
      input              CLOCK3_50,

      ///////// CLOCK4 /////////
      input              CLOCK4_50,

      ///////// CLOCK /////////
      input              CLOCK_50,

      ///////// DRAM /////////
      output      [12:0] DRAM_ADDR,
      output      [1:0]  DRAM_BA,
      output             DRAM_CAS_N,
      output             DRAM_CKE,
      output             DRAM_CLK,
      output             DRAM_CS_N,
      inout       [15:0] DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_RAS_N,
      output             DRAM_UDQM,
      output             DRAM_WE_N,

      ///////// FAN /////////
      output             FAN_CTRL,

      ///////// FPGA /////////
      output             FPGA_I2C_SCLK,
      inout              FPGA_I2C_SDAT,

      ///////// GPIO /////////
      input      [35:0]  GPIO_0,
      input      [35:0]  GPIO_1,

      ///////// HEX0 /////////
      output      [6:0]  HEX0,

      ///////// HEX1 /////////
      output      [6:0]  HEX1,

      ///////// HEX2 /////////
      output      [6:0]  HEX2,

      ///////// HEX3 /////////
      output      [6:0]  HEX3,

      ///////// HEX4 /////////
      output      [6:0]  HEX4,

      ///////// HEX5 /////////
      output      [6:0]  HEX5,

`ifdef ENABLE_HPS
      ///////// HPS /////////
      inout              HPS_CONV_USB_N,
      output      [14:0] HPS_DDR3_ADDR,
      output      [2:0]  HPS_DDR3_BA,
      output             HPS_DDR3_CAS_N,
      output             HPS_DDR3_CKE,
      output             HPS_DDR3_CK_N,
      output             HPS_DDR3_CK_P,
      output             HPS_DDR3_CS_N,
      output      [3:0]  HPS_DDR3_DM,
      inout       [31:0] HPS_DDR3_DQ,
      inout       [3:0]  HPS_DDR3_DQS_N,
      inout       [3:0]  HPS_DDR3_DQS_P,
      output             HPS_DDR3_ODT,
      output             HPS_DDR3_RAS_N,
      output             HPS_DDR3_RESET_N,
      input              HPS_DDR3_RZQ,
      output             HPS_DDR3_WE_N,
      output             HPS_ENET_GTX_CLK,
      inout              HPS_ENET_INT_N,
      output             HPS_ENET_MDC,
      inout              HPS_ENET_MDIO,
      input              HPS_ENET_RX_CLK,
      input       [3:0]  HPS_ENET_RX_DATA,
      input              HPS_ENET_RX_DV,
      output      [3:0]  HPS_ENET_TX_DATA,
      output             HPS_ENET_TX_EN,
      inout       [3:0]  HPS_FLASH_DATA,
      output             HPS_FLASH_DCLK,
      output             HPS_FLASH_NCSO,
      inout              HPS_GSENSOR_INT,
      inout              HPS_I2C1_SCLK,
      inout              HPS_I2C1_SDAT,
      inout              HPS_I2C2_SCLK,
      inout              HPS_I2C2_SDAT,
      inout              HPS_I2C_CONTROL,
      inout              HPS_KEY,
      inout              HPS_LED,
      inout              HPS_LTC_GPIO,
      output             HPS_SD_CLK,
      inout              HPS_SD_CMD,
      inout       [3:0]  HPS_SD_DATA,
      output             HPS_SPIM_CLK,
      input              HPS_SPIM_MISO,
      output             HPS_SPIM_MOSI,
      inout              HPS_SPIM_SS,
      input              HPS_UART_RX,
      output             HPS_UART_TX,
      input              HPS_USB_CLKOUT,
      inout       [7:0]  HPS_USB_DATA,
      input              HPS_USB_DIR,
      input              HPS_USB_NXT,
      output             HPS_USB_STP,
`endif /*ENABLE_HPS*/

      ///////// IRDA /////////
      input              IRDA_RXD,
      output             IRDA_TXD,

      ///////// KEY /////////
      input       [3:0]  KEY,

      ///////// LEDR /////////
      output      [9:0]  LEDR,

      ///////// PS2 /////////
      inout              PS2_CLK,
      inout              PS2_CLK2,
      inout              PS2_DAT,
      inout              PS2_DAT2,

      ///////// SW /////////
      input       [9:0]  SW,

      ///////// TD /////////
      input              TD_CLK27,
      input       [7:0]  TD_DATA,
      input              TD_HS,
      output             TD_RESET_N,
      input              TD_VS,

      ///////// VGA /////////
      output      [7:0]  VGA_B,
      output             VGA_BLANK_N,
      output             VGA_CLK,
      output      [7:0]  VGA_G,
      output             VGA_HS,
      output      [7:0]  VGA_R,
      output             VGA_SYNC_N,
      output             VGA_VS
);

logic rst_n;
logic rst;
logic clk;

assign rst_n  = KEY[0];
assign rst    = !KEY[0];
assign clk    = CLOCK_50;

assign LEDR = '0;
assign HEX0 = '0;
assign HEX1 = '0;
assign HEX2 = '0;
assign HEX3 = '0;
assign HEX4 = '0;
assign HEX5 = '0;

//cpu_subsystem cpu_subsystem (
//  .clk_clk        ( clk   ),
//  .reset_reset_n  ( rst_n )
//);
//
//serial_flash_loader serial_flash_loader (
//  .noe_in ( 1'b0 )
//);

//------------------------------------------------------------------------------
// PCI signals
//------------------------------------------------------------------------------

logic pci_rst;
logic pci_clk;

assign pci_rst = !GPIO_0[0]; // NOTE: RESETn is inverted signal
assign pci_clk =  GPIO_0[2];

(* noprune *) logic [3:0][7:0]  ad;
(* noprune *) logic [3:0]       cbe;

always_ff @(posedge pci_clk)
  begin
    ad[0] <= {GPIO_0[17],GPIO_0[15],GPIO_0[13],GPIO_0[11],GPIO_0[ 9],GPIO_0[ 7],GPIO_0[ 5],GPIO_0[ 3]};
    ad[1] <= {GPIO_0[33],GPIO_0[31],GPIO_0[29],GPIO_0[27],GPIO_0[25],GPIO_0[23],GPIO_0[21],GPIO_0[19]};
    ad[2] <= {GPIO_0[14],GPIO_0[12],GPIO_0[10],GPIO_0[ 8],GPIO_0[ 6],GPIO_0[ 4],GPIO_0[32],GPIO_0[35]};
    ad[3] <= {GPIO_0[30],GPIO_0[28],GPIO_0[26],GPIO_0[24],GPIO_0[22],GPIO_0[20],GPIO_0[18],GPIO_0[16]};
  end

always_ff @(posedge pci_clk)
  begin
    cbe   <= {GPIO_1[6],GPIO_0[4],GPIO_0[2],GPIO_0[0]};
  end

(* noprune *) logic par;
(* noprune *) logic frame;
(* noprune *) logic irdy;
(* noprune *) logic trdy;
(* noprune *) logic stop;
(* noprune *) logic devsel;
(* noprune *) logic idsel;

always_ff @(posedge pci_clk)
  begin
    par     <= GPIO_1[ 1];
    frame   <= GPIO_1[ 5];
    irdy    <= GPIO_1[ 7];
    trdy    <= GPIO_1[ 9];
    stop    <= GPIO_1[11];
    devsel  <= GPIO_1[13];
    idsel   <= GPIO_1[ 8];
  end

//assign GPIO_0 = 'Z;
//assign GPIO_1 = 'Z;

endmodule

