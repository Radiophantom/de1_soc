
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
# Import memory routines and create memory class
##################################################

source ../mem.tcl

set MIL_STD_CONTROLLER_INDX         0
set MIL_STD_CONTROLLER_BASE_ADDR    0x20000
set MIL_STD_CONTROLLER_REGION_SIZE  1024

MEM_IO create mil_std_mem $MIL_STD_CONTROLLER_INDX $MIL_STD_CONTROLLER_BASE_ADDR $MIL_STD_CONTROLLER_REGION_SIZE

##################################################
# Simple commands (low-level CSR drivers)
##################################################

proc send_word {cmd data} {
  mil_std_mem write16 2 $data
  mil_std_mem write16 3 $cmd
  mil_std_mem write16 4 0x0
  mil_std_mem write16 1 0x1
  for {set i 0} {$i < 1000} {incr i} {
    if { [expr [mil_std_mem read16 1] & (1 << 0)] == 0 } {
      break
    }
    after 1
  }
  if { $cmd == 0 } {
    puts "SEND 'COMMAND WORD': DATA - [format 0x%x $data]"
  } else {
    puts "SEND 'DATA WORD': DATA - [format 0x%x $data]"
  }
}

proc rcv_word {} {
  for {set i 0} {$i < 1000} {incr i} {
    if { [expr [mil_std_mem read16 6] & (1 << 0)] } {
      break
    }
    after 1
  }
  set rcv_word_data [mil_std_mem read16 7]
  set rcv_word_sync [expr [mil_std_mem read16 8] & (1 << 0)]
  mil_std_mem write16 6 0x0
  if {$rcv_word_sync == 0x0} {
    puts "RECEIVED COMMAND WORD: $rcv_word_data"
  } else {
    puts "RECEIVED DATA WORD: $rcv_word_data"
  }
  set response [dict create sync $rcv_word_sync data $rcv_word_data]
  dict for {key value} $response {
    puts "$key $value"
  }
  return $response
}

##################################################
# Functions implementation
##################################################

proc rcv_data {RT_ADDRESS SUB_ADDRESS WORDS_COUNT} {
  set DATA 0x00
  set CMD_WORD [expr ($RT_ADDRESS << 11) + ($SUB_ADDRESS << 5) + $WORDS_COUNT]
  send_word 0 $CMD_WORD
  for {set i 0} {$i < $WORDS_COUNT} {incr i} {
    send_word 1 $DATA
    incr DATA
  }
  rcv_word
}

proc rcv_mcode_data {RT_ADDRESS CODE WORD} {
  set CMD_WORD [expr ($RT_ADDRESS << 11) + (31 << 5) + $CODE]
  send_word 0 $CMD_WORD
  send_word 1 $WORD
  rcv_word
}

proc rcv_mcode_no_data {RT_ADDRESS CODE} {
  set CMD_WORD [expr ($RT_ADDRESS << 11) + (31 << 5) + $CODE]
  send_word 0 $CMD_WORD
  rcv_word
}

proc rcv_data_bc {SUB_ADDRESS WORDS_COUNT} {
  set DATA 0x00
  set CMD_WORD [expr (31 << 11) + ($SUB_ADDRESS << 5) + $WORDS_COUNT]
  send_word 0 $CMD_WORD
  for {set i 0} {$i < $WORDS_COUNT} {incr i} {
    send_word 1 $DATA
    incr DATA
  }
}

proc rcv_mcode_data_bc {CODE} {
  set CMD_WORD [expr (31 << 11) + (31 << 5) + $CODE]
  send_word 0 $CMD_WORD
  send_word 1 $CODE
}

proc rcv_mcode_no_data_bc {CODE} {
  set CMD_WORD [expr (31 << 11) + (31 << 5) + $CODE]
  send_word 0 $CMD_WORD
}

#proc rcv_rt_rt {rt_address0 rt_address1 sub_address0 sub_address1 words_count} {
#  send_word 0 {}
#  send_word 0 {}
#  send_word 0 {}
#  for {set i 0} {$i < $words_count} {incr i} {
#    send_word 1 {}
#  }
#  puts [rcv_word]
#}
#
#proc xmt_rt_rt {rt_address0 rt_address1 sub_address0 sub_address1 words_count} {
#  send_word 0 {}
#  send_word 0 {}
#  puts [rcv_word]
#  for {set i 0} {$i < $words_count} {incr i} {
#    puts [rcv_word]
#  }
#  send_word 0 {}
#}
#
#proc rcv_rt_rt_bc {rt_address0 rt_address1 sub_address0 sub_address1 words_count} {
#  send_word 0 {}
#  send_word 0 {}
#  send_word 0 {}
#  for {set i 0} {$i < $words_count} {incr i} {
#    send_word 1 {}
#  }
#}
#
#proc xmt_rt_rt_bc {rt_address0 rt_address1 sub_address0 sub_address1 words_count} {
#  send_word 0 {}
#  send_word 0 {}
#  puts [rcv_word]
#  for {set i 0} {$i < $words_count} {incr i} {
#    puts [rcv_word]
#  }
#}

proc xmt_data {RT_ADDRESS SUB_ADDRESS WORDS_COUNT} {
  set CMD_WORD [expr ($RT_ADDRESS << 11) + (1 << 10) + ($SUB_ADDRESS << 5) + $WORDS_COUNT]
  send_word 0 $CMD_WORD
  rcv_word
  for {set i 0} {$i < $WORDS_COUNT} {incr i} {
    rcv_word
  }
}

proc xmt_mcode_data {RT_ADDRESS CODE} {
  set CMD_WORD [expr ($RT_ADDRESS << 11) + (1 << 10) + (31 << 5) + $CODE]
  send_word 0 $CMD_WORD
  rcv_word
  rcv_word
}

proc xmt_mcode_no_data {RT_ADDRESS CODE} {
  set CMD_WORD [expr ($RT_ADDRESS << 11) + (1 << 10) + (31 << 5) + $CODE]
  send_word 0 $CMD_WORD
  rcv_word
}

