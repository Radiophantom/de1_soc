#**************************************************************
# This .sdc file is created by Terasic Tool.
# Users are recommended to modify this file to match users logic.
#**************************************************************

#**************************************************************
# Create Clock
#**************************************************************
create_clock -period 20 [get_ports CLOCK_50]
create_clock -period 20 [get_ports CLOCK2_50]
create_clock -period 20 [get_ports CLOCK3_50]
create_clock -period 20 [get_ports CLOCK4_50]

create_clock -period "27 MHz"  -name tv_27m [get_ports TD_CLK27]
create_clock -period "100 MHz" -name clk_dram [get_ports DRAM_CLK]
# AUDIO : 48kHz 384fs 32-bit data
create_clock -period "18.432 MHz" -name clk_audxck [get_ports AUD_XCK]
create_clock -period "1.536 MHz" -name clk_audbck [get_ports AUD_BCLK]
# VGA : 640x480@60Hz
#create_clock -period "25.18 MHz" -name clk_vga [get_ports VGA_CLK]
# VGA : 800x600@60Hz
#create_clock -period "40.0 MHz" -name clk_vga [get_ports VGA_CLK]
# VGA : 1024x768@60Hz
#create_clock -period "65.0 MHz" -name clk_vga [get_ports VGA_CLK]
# VGA : 1280x1024@60Hz
create_clock -period "108.0 MHz" -name clk_vga [get_ports VGA_CLK]

# for enhancing USB BlasterII to be reliable, 25MHz
create_clock -name {altera_reserved_tck} -period 40 {altera_reserved_tck}
set_input_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tdi]
set_input_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tms]
set_output_delay -clock altera_reserved_tck 3 [get_ports altera_reserved_tdo]

#**************************************************************
# Create Generated Clock
#**************************************************************
derive_pll_clocks



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************
derive_clock_uncertainty



#**************************************************************
# Set Input Delay
#**************************************************************
# Board Delay (Data) + Propagation Delay - Board Delay (Clock)
set_input_delay -max -clock clk_dram -0.048 [get_ports DRAM_DQ*]
set_input_delay -min -clock clk_dram -0.057 [get_ports DRAM_DQ*]

set_input_delay -max -clock tv_27m 3.692 [get_ports TD_DATA*]
set_input_delay -min -clock tv_27m 2.492 [get_ports TD_DATA*]
set_input_delay -max -clock tv_27m 3.654 [get_ports TD_HS]
set_input_delay -min -clock tv_27m 2.454 [get_ports TD_HS]
set_input_delay -max -clock tv_27m 3.656 [get_ports TD_VS]
set_input_delay -min -clock tv_27m 2.456 [get_ports TD_VS]




#**************************************************************
# Set Output Delay
#**************************************************************
# max : Board Delay (Data) - Board Delay (Clock) + tsu (External Device)
# min : Board Delay (Data) - Board Delay (Clock) - th (External Device)
set_output_delay -max -clock clk_dram 1.452  [get_ports DRAM_DQ*]
set_output_delay -min -clock clk_dram -0.857 [get_ports DRAM_DQ*]
set_output_delay -max -clock clk_dram 1.531 [get_ports DRAM_ADDR*]
set_output_delay -min -clock clk_dram -0.805 [get_ports DRAM_ADDR*]
set_output_delay -max -clock clk_dram 1.533  [get_ports DRAM_*DQM]
set_output_delay -min -clock clk_dram -0.805 [get_ports DRAM_*DQM]
set_output_delay -max -clock clk_dram 1.510  [get_ports DRAM_BA*]
set_output_delay -min -clock clk_dram -0.800 [get_ports DRAM_BA*]
set_output_delay -max -clock clk_dram 1.520  [get_ports DRAM_RAS_N]
set_output_delay -min -clock clk_dram -0.780 [get_ports DRAM_RAS_N]
set_output_delay -max -clock clk_dram 1.5000  [get_ports DRAM_CAS_N]
set_output_delay -min -clock clk_dram -0.800 [get_ports DRAM_CAS_N]
set_output_delay -max -clock clk_dram 1.545 [get_ports DRAM_WE_N]
set_output_delay -min -clock clk_dram -0.755 [get_ports DRAM_WE_N]
set_output_delay -max -clock clk_dram 1.496  [get_ports DRAM_CKE]
set_output_delay -min -clock clk_dram -0.804 [get_ports DRAM_CKE]
set_output_delay -max -clock clk_dram 1.508  [get_ports DRAM_CS_N]
set_output_delay -min -clock clk_dram -0.792 [get_ports DRAM_CS_N]

set_output_delay -max -clock clk_vga 0.220 [get_ports VGA_R*]
set_output_delay -min -clock clk_vga -1.506 [get_ports VGA_R*]
set_output_delay -max -clock clk_vga 0.212 [get_ports VGA_G*]
set_output_delay -min -clock clk_vga -1.519 [get_ports VGA_G*]
set_output_delay -max -clock clk_vga 0.264 [get_ports VGA_B*]
set_output_delay -min -clock clk_vga -1.519 [get_ports VGA_B*]
set_output_delay -max -clock clk_vga 0.215 [get_ports VGA_BLANK]
set_output_delay -min -clock clk_vga -1.485 [get_ports VGA_BLANK]




#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************



#**************************************************************
# Set Load
#**************************************************************

create_clock -name pci_clk -period 30.000 [get_ports {GPIO_0[2]}]

set_input_delay -clock { pci_clk } -min 0   [get_ports {GPIO_0[2] GPIO_0[3] GPIO_0[4] GPIO_0[5] GPIO_0[6] GPIO_0[7] GPIO_0[8] GPIO_0[9] GPIO_0[10] GPIO_0[11] GPIO_0[12] GPIO_0[13] GPIO_0[14] GPIO_0[15] GPIO_0[16] GPIO_0[17] GPIO_0[18] GPIO_0[19] GPIO_0[20] GPIO_0[21] GPIO_0[22] GPIO_0[23] GPIO_0[24] GPIO_0[25] GPIO_0[26] GPIO_0[27] GPIO_0[28] GPIO_0[29] GPIO_0[30] GPIO_0[31] GPIO_0[32] GPIO_0[33] GPIO_0[34] GPIO_0[35] GPIO_1[0] GPIO_1[1] GPIO_1[2] GPIO_1[3] GPIO_1[4] GPIO_1[5] GPIO_1[6] GPIO_1[7] GPIO_1[8] GPIO_1[9] GPIO_1[10] GPIO_1[11] GPIO_1[12] GPIO_1[13] GPIO_1[14] GPIO_1[15] GPIO_1[16] GPIO_1[17] GPIO_1[18] GPIO_1[19] GPIO_1[20] GPIO_1[21] GPIO_1[22] GPIO_1[23] GPIO_1[24] GPIO_1[25] GPIO_1[26] GPIO_1[27] GPIO_1[28] GPIO_1[29] GPIO_1[30] GPIO_1[31] GPIO_1[32] GPIO_1[33] GPIO_1[34] GPIO_1[35]}] -add_delay
#set_input_delay -clock { pci_clk } -min 2  [get_ports {GPIO_0[2] GPIO_0[3] GPIO_0[4] GPIO_0[5] GPIO_0[6] GPIO_0[7] GPIO_0[8] GPIO_0[9] GPIO_0[10] GPIO_0[11] GPIO_0[12] GPIO_0[13] GPIO_0[14] GPIO_0[15] GPIO_0[16] GPIO_0[17] GPIO_0[18] GPIO_0[19] GPIO_0[20] GPIO_0[21] GPIO_0[22] GPIO_0[23] GPIO_0[24] GPIO_0[25] GPIO_0[26] GPIO_0[27] GPIO_0[28] GPIO_0[29] GPIO_0[30] GPIO_0[31] GPIO_0[32] GPIO_0[33] GPIO_0[34] GPIO_0[35] GPIO_1[0] GPIO_1[1] GPIO_1[2] GPIO_1[3] GPIO_1[4] GPIO_1[5] GPIO_1[6] GPIO_1[7] GPIO_1[8] GPIO_1[9] GPIO_1[10] GPIO_1[11] GPIO_1[12] GPIO_1[13] GPIO_1[14] GPIO_1[15] GPIO_1[16] GPIO_1[17] GPIO_1[18] GPIO_1[19] GPIO_1[20] GPIO_1[21] GPIO_1[22] GPIO_1[23] GPIO_1[24] GPIO_1[25] GPIO_1[26] GPIO_1[27] GPIO_1[28] GPIO_1[29] GPIO_1[30] GPIO_1[31] GPIO_1[32] GPIO_1[33] GPIO_1[34] GPIO_1[35]}] -add_delay
set_input_delay -clock { pci_clk } -max 19  [get_ports {GPIO_0[2] GPIO_0[3] GPIO_0[4] GPIO_0[5] GPIO_0[6] GPIO_0[7] GPIO_0[8] GPIO_0[9] GPIO_0[10] GPIO_0[11] GPIO_0[12] GPIO_0[13] GPIO_0[14] GPIO_0[15] GPIO_0[16] GPIO_0[17] GPIO_0[18] GPIO_0[19] GPIO_0[20] GPIO_0[21] GPIO_0[22] GPIO_0[23] GPIO_0[24] GPIO_0[25] GPIO_0[26] GPIO_0[27] GPIO_0[28] GPIO_0[29] GPIO_0[30] GPIO_0[31] GPIO_0[32] GPIO_0[33] GPIO_0[34] GPIO_0[35] GPIO_1[0] GPIO_1[1] GPIO_1[2] GPIO_1[3] GPIO_1[4] GPIO_1[5] GPIO_1[6] GPIO_1[7] GPIO_1[8] GPIO_1[9] GPIO_1[10] GPIO_1[11] GPIO_1[12] GPIO_1[13] GPIO_1[14] GPIO_1[15] GPIO_1[16] GPIO_1[17] GPIO_1[18] GPIO_1[19] GPIO_1[20] GPIO_1[21] GPIO_1[22] GPIO_1[23] GPIO_1[24] GPIO_1[25] GPIO_1[26] GPIO_1[27] GPIO_1[28] GPIO_1[29] GPIO_1[30] GPIO_1[31] GPIO_1[32] GPIO_1[33] GPIO_1[34] GPIO_1[35]}] -add_delay 
