
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

      ///////// PCI  /////////
      input              PCI_RSTn,
      input              PCI_CLK,
      input              PCI_IDSEL,
      input              PCI_LOCKn,

      inout     [31:0]   PCI_AD,
      inout              PCI_PAR,
      inout     [3:0]    PCI_CBEn,
      inout              PCI_FRAMEn,
      inout              PCI_IRDYn,
      inout              PCI_TRDYn,
      inout              PCI_STOPn,
      inout              PCI_DEVSELn,
      inout              PCI_PERRn,

      output             PCI_SERRn,  // Open-drain
      output             PCI_INTAn, // Open-drain

      ///////// GPIO /////////
      //inout      [35:0]  GPIO_0,
      //inout      [35:0]  GPIO_1,

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
// PCI controller
//------------------------------------------------------------------------------

logic pci_rst;
logic pci_clk;

assign pci_rst = !PCI_RSTn; // NOTE: RESETn is inverted signal
assign pci_clk =  PCI_CLK;

logic [1:0]            frame_o;
logic [1:0][3:0][7:0]  ad_o;
logic [1:0][3:0]       cbe_o;
logic [1:0]            par_o;
logic [1:0]            irdy_o;
logic [1:0]            trdy_o;
logic [1:0]            stop_o;
logic [1:0]            devsel_o;
logic [1:0]            perr_o  = '1;
logic [1:0]            serr_o  = '0;
//logic             int_o   = 1'b0;

logic             frame;
logic [3:0][7:0]  ad;
logic [3:0]       cbe;
logic             par;
logic             irdy;
logic             trdy;
logic             stop;
logic             devsel;
logic             perr;

logic [1:0]            frame_o_en;
logic [1:0]            ad_o_en;
logic [1:0]            cbe_o_en;
logic [1:0]            par_o_en;
logic [1:0]            irdy_o_en;
logic [1:0]            trdy_o_en;
logic [1:0]            stop_o_en;
logic [1:0]            devsel_o_en;
logic [1:0]            perr_o_en = '0;

assign frame  = frame_o_en[0]  ? frame_o[0]  : frame_o[1]  ;
assign ad     = ad_o_en[0]     ? ad_o[0]     : ad_o[1]     ;
assign cbe    = cbe_o_en[0]    ? cbe_o[0]    : cbe_o[1]    ;
assign par    = par_o_en[0]    ? par_o[0]    : par_o[1]    ;
assign irdy   = irdy_o_en[0]   ? irdy_o[0]   : irdy_o[1]   ;
assign trdy   = trdy_o_en[0]   ? trdy_o[0]   : trdy_o[1]   ;
assign stop   = stop_o_en[0]   ? stop_o[0]   : stop_o[1]   ;
assign devsel = devsel_o_en[0] ? devsel_o[0] : devsel_o[1] ;
assign perr   = perr_o_en[0]   ? perr_o[0]   : perr_o[1]   ;

logic int_o;

vio vio_inst (
  .source(int_o)
);

assign PCI_FRAMEn   = |frame_o_en  ? frame   : 'Z;
assign PCI_AD       = |ad_o_en     ? ad      : 'Z;
assign PCI_CBEn     = |cbe_o_en    ? cbe     : 'Z;
assign PCI_PAR      = |par_o_en    ? par     : 'Z;
assign PCI_IRDYn    = |irdy_o_en   ? irdy    : 'Z;
assign PCI_TRDYn    = |trdy_o_en   ? trdy    : 'Z;
assign PCI_STOPn    = |stop_o_en   ? stop    : 'Z;
assign PCI_DEVSELn  = |devsel_o_en ? devsel  : 'Z;
assign PCI_PERRn    = |perr_o_en   ? perr    : 'Z;

// Not used signals now
assign PCI_SERRn  = serr_o[0] ? 1'b0 : 'Z;
assign PCI_INTAn  = int_o  ? 1'b0 : 'Z;

avalon_mm_if #(32,32) mem0_if (pci_clk);
avalon_mm_if #(32,32) mem1_if (pci_clk);

parameter int IDSEL0_IDX = 16;
parameter int IDSEL1_IDX = 17;

pci_core_top #(64*1024) pci_core_top0_inst (
  .clk_i          ( pci_clk             ),
  .rst_i          ( pci_rst             ),

  .FRAMEn_in      ( PCI_FRAMEn          ),
  .AD_in          ( PCI_AD              ),
  .PAR_in         ( PCI_PAR             ),
  .CBEn_in        ( PCI_CBEn            ),
  .IRDYn_in       ( PCI_IRDYn           ),
  .TRDYn_in       ( PCI_TRDYn           ),
  .DEVSELn_in     ( PCI_DEVSELn         ),
  .STOPn_in       ( PCI_STOPn           ),
  .IDSEL_in       ( PCI_AD[IDSEL0_IDX]  ),

  .FRAMEn_out     ( frame_o[0]          ),
  .AD_out         ( ad_o[0]             ),
  .PAR_out        ( par_o[0]            ),
  .CBEn_out       ( cbe_o[0]            ),
  .IRDYn_out      ( irdy_o[0]           ),
  .TRDYn_out      ( trdy_o[0]           ),
  .DEVSELn_out    ( devsel_o[0]         ),
  .STOPn_out      ( stop_o[0]           ),

  .FRAMEn_out_en  ( frame_o_en[0]       ),
  .AD_out_en      ( ad_o_en[0]          ),
  .PAR_out_en     ( par_o_en[0]         ),
  .CBEn_out_en    ( cbe_o_en[0]         ),
  .IRDYn_out_en   ( irdy_o_en[0]        ),
  .TRDYn_out_en   ( trdy_o_en[0]        ),
  .DEVSELn_out_en ( devsel_o_en[0]      ),
  .STOPn_out_en   ( stop_o_en[0]        ),

  .mem_if         ( mem0_if              )
);

pci_core_top #(128*1024) pci_core_top1_inst (
  .clk_i          ( pci_clk             ),
  .rst_i          ( pci_rst             ),

  .FRAMEn_in      ( PCI_FRAMEn          ),
  .AD_in          ( PCI_AD              ),
  .PAR_in         ( PCI_PAR             ),
  .CBEn_in        ( PCI_CBEn            ),
  .IRDYn_in       ( PCI_IRDYn           ),
  .TRDYn_in       ( PCI_TRDYn           ),
  .DEVSELn_in     ( PCI_DEVSELn         ),
  .STOPn_in       ( PCI_STOPn           ),
  .IDSEL_in       ( PCI_AD[IDSEL1_IDX]  ),

  .FRAMEn_out     ( frame_o[1]          ),
  .AD_out         ( ad_o[1]             ),
  .PAR_out        ( par_o[1]            ),
  .CBEn_out       ( cbe_o[1]            ),
  .IRDYn_out      ( irdy_o[1]           ),
  .TRDYn_out      ( trdy_o[1]           ),
  .DEVSELn_out    ( devsel_o[1]         ),
  .STOPn_out      ( stop_o[1]           ),

  .FRAMEn_out_en  ( frame_o_en[1]       ),
  .AD_out_en      ( ad_o_en[1]          ),
  .PAR_out_en     ( par_o_en[1]         ),
  .CBEn_out_en    ( cbe_o_en[1]         ),
  .IRDYn_out_en   ( irdy_o_en[1]        ),
  .TRDYn_out_en   ( trdy_o_en[1]        ),
  .DEVSELn_out_en ( devsel_o_en[1]      ),
  .STOPn_out_en   ( stop_o_en[1]        ),

  .mem_if         ( mem1_if              )
);

amm_memory #(
  .MEM_DEPTH          ( 64*1024               )
) amm_memory_inst0_64KB (
  .rst_i              ( pci_rst               ),
  .clk_i              ( pci_clk               ),
  .amm_address        ( mem0_if.address       ),
  .amm_read           ( mem0_if.read          ),
  .amm_byteenable     ( mem0_if.byteenable    ),
  .amm_write          ( mem0_if.write         ),
  .amm_writedata      ( mem0_if.writedata     ),
  .amm_readdatavalid  ( mem0_if.readdatavalid ),
  .amm_readdata       ( mem0_if.readdata      ),
  .amm_waitrequest    ( mem0_if.waitrequest   )
);

amm_memory #(
  .MEM_DEPTH          ( 128*1024               )
) amm_memory_inst1_64KB (
  .rst_i              ( pci_rst               ),
  .clk_i              ( pci_clk               ),
  .amm_address        ( mem1_if.address       ),
  .amm_read           ( mem1_if.read          ),
  .amm_byteenable     ( mem1_if.byteenable    ),
  .amm_write          ( mem1_if.write         ),
  .amm_writedata      ( mem1_if.writedata     ),
  .amm_readdatavalid  ( mem1_if.readdatavalid ),
  .amm_readdata       ( mem1_if.readdata      ),
  .amm_waitrequest    ( mem1_if.waitrequest   )
);

endmodule

