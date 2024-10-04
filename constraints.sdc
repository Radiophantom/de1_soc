
##Constraining JTAG interface
##TCK port
#create_clock -name altera_reserved_tck -period 100 [get_ports altera_reserved_tck]
##cut all paths to and from tck
#set_clock_groups -exclusive -group [get_clocks altera_reserved_tck]
##constrain the TDI port
#set_input_delay -clock altera_reserved_tck 20 [get_ports altera_reserved_tdi]
##constrain the TMS port
#set_input_delay -clock altera_reserved_tck 20 [get_ports altera_reserved_tms]
##constrain the TDO port
#set_output_delay -clock altera_reserved_tck 20 [get_ports altera_reserved_tdo]

# Input source clock
create_clock -name sys_clk -period 20.000 [get_ports {clk_i}]

# False paths
set_false_path -from [get_ports {rst_n_i}]
set_false_path -to   [get_ports led_o[*]]

