
##################################################
# Functions prototype
##################################################
#
#   ### Receive commands ###
#   proc rcv_data {}
#   proc rcv_mcode_data {}
#   proc rcv_mcode_no_data {}
#
#   ### Receive (broadcast) commands ###
#   proc rcv_data_bc {}
#   proc rcv_mcode_data_bc {}
#   proc rcv_mcode_no_data_bc {}
#
#   ### RT-RT commands ###
#   proc rcv_rt_rt {}
#   proc xmt_rt_rt {}
#
#   ### RT-RT (broadcast) commands ###
#   proc rcv_rt_rt_bc {}
#   proc xmt_rt_rt_bc {}
#
#   ### Transmit commands ###
#   proc xmt_data {}
#   proc xmt_mcode_data {}
#   proc xmt_mcode_no_data {}

##################################################
# Simple commands (low-level CSR drivers)
##################################################

proc send_command_word {data} {
  puts "SEND 'COMMAND WORD': DATA - [format 0x%x $data]"
}

proc send_data_word {data} {
  puts "SEND 'DATA WORD': DATA - [format 0x%x $data]"
}

proc rcv_word {} {
  puts "RECEIVE WORD:"
  return "0xXXXX"
}

##################################################
# Functions implementation
##################################################

proc rcv_data {RT_ADDRESS SUB_ADDRESS WORDS_COUNT} {
  set DATA 0x00
  set CMD_WORD [expr ($RT_ADDRESS << 11) + ($SUB_ADDRESS << 5) + $WORDS_COUNT]
  send_command_word $CMD_WORD
  for {set i 0} {$i < $WORDS_COUNT} {incr i} {
    send_data_word $DATA
    incr DATA
  }
  puts [rcv_word]
}

proc rcv_mcode_data {RT_ADDRESS CODE WORD} {
  set CMD_WORD [expr ($RT_ADDRESS << 11) + (31 << 5) + $CODE]
  send_command_word $CMD_WORD
  send_data_word $WORD
  puts [rcv_word]
}

proc rcv_mcode_no_data {RT_ADDRESS CODE} {
  set CMD_WORD [expr ($RT_ADDRESS << 11) + (31 << 5) + $CODE]
  send_command_word $CMD_WORD
  puts [rcv_word]
}

proc rcv_data_bc {SUB_ADDRESS WORDS_COUNT} {
  set DATA 0x00
  set CMD_WORD [expr (31 << 11) + ($SUB_ADDRESS << 5) + $WORDS_COUNT]
  send_command_word $CMD_WORD
  for {set i 0} {$i < $WORDS_COUNT} {incr i} {
    send_data_word $DATA
    incr DATA
  }
}

proc rcv_mcode_data_bc {CODE} {
  set CMD_WORD [expr (31 << 11) + (31 << 5) + $CODE]
  send_command_word $CMD_WORD
  send_data_word $WORD
}

proc rcv_mcode_no_data_bc {CODE} {
  set CMD_WORD [expr (31 << 11) + (31 << 5) + $CODE]
  send_command_word $CMD_WORD
}

#proc rcv_rt_rt {rt_address0 rt_address1 sub_address0 sub_address1 words_count} {
#  send_command_word {}
#  send_command_word {}
#  send_command_word {}
#  for {set i 0} {$i < $words_count} {incr i} {
#    send_data_word {}
#  }
#  puts [rcv_word]
#}
#
#proc xmt_rt_rt {rt_address0 rt_address1 sub_address0 sub_address1 words_count} {
#  send_command_word {}
#  send_command_word {}
#  puts [rcv_word]
#  for {set i 0} {$i < $words_count} {incr i} {
#    puts [rcv_word]
#  }
#  send_command_word {}
#}
#
#proc rcv_rt_rt_bc {rt_address0 rt_address1 sub_address0 sub_address1 words_count} {
#  send_command_word {}
#  send_command_word {}
#  send_command_word {}
#  for {set i 0} {$i < $words_count} {incr i} {
#    send_data_word {}
#  }
#}
#
#proc xmt_rt_rt_bc {rt_address0 rt_address1 sub_address0 sub_address1 words_count} {
#  send_command_word {}
#  send_command_word {}
#  puts [rcv_word]
#  for {set i 0} {$i < $words_count} {incr i} {
#    puts [rcv_word]
#  }
#}

proc xmt_data {RT_ADDRESS SUB_ADDRESS WORDS_COUNT} {
  set CMD_WORD [expr ($RT_ADDRESS << 11) + (1 << 10) + ($SUB_ADDRESS << 5) + $WORDS_COUNT]
  send_command_word $CMD_WORD
  puts [rcv_word]
  for {set i 0} {$i < $WORDS_COUNT} {incr i} {
    puts [rcv_word]
  }
}

proc xmt_mcode_data {RT_ADDRESS CODE} {
  set CMD_WORD [expr ($RT_ADDRESS << 11) + (1 << 10) + (31 << 5) + $CODE]
  send_command_word $CMD_WORD
  puts [rcv_word]
  puts [rcv_word]
}

proc xmt_mcode_no_data {rt_address sub_address code} {
  set CMD_WORD [expr ($RT_ADDRESS << 11) + (1 << 10) + (31 << 5) + $CODE]
  send_command_word $CMD_WORD
  puts [rcv_word]
}

