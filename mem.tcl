
# MEMORY parameters in bytes
set ADDRESS_SPACE_START 0x0
set ADDRESS_SPACE_SIZE  4096
set ADDRESS_SPACE_STOP  [expr $ADDRESS_SPACE_START + $ADDRESS_SPACE_SIZE]

proc list_masters {} {
  return [get_service_paths master]
}

proc open {master_index} {
  global master
  set masters [get_service_paths master]
  set master [lindex $masters $master_index]
  open_service master $master
}

proc close {master_index} {
  global master
  set masters [get_service_paths master]
  set master [lindex $masters $master_index]
  close_service master $master
}

proc read8 {master addr} {
  set rd_addr $addr
  if { [expr $rd_addr + 0] >= $::ADDRESS_SPACE_STOP } {
    return "ERROR: 'read8()' - out of address range!"
  } else {
    set res [master_read_8 $master $rd_addr 1]
    return [format 0x%x $res]
  }
}

proc read16 {master addr} {
  set rd_addr [expr $addr*2]
  if { [expr $rd_addr + 1] >= $::ADDRESS_SPACE_STOP } {
    return "ERROR: 'read16()' - out of address range!"
  } else {
    set rd_res [master_read_8 $master $rd_addr 2]
    set res [expr ([lindex $rd_res 0] << 8) + \
                  ([lindex $rd_res 1] << 0)]
    return [format 0x%x $res]
  }
}

proc read32 {master addr} {
  set rd_addr [expr $addr*4]
  if { [expr $rd_addr + 3] >= $::ADDRESS_SPACE_STOP } {
    return "ERROR: 'read32()' - out of address range!"
  } else {
    set rd_res [master_read_8 $master $rd_addr 4]
    set res [expr ([lindex $rd_res 0] << 24) + \
                  ([lindex $rd_res 1] << 16) + \
                  ([lindex $rd_res 2] << 8 ) + \
                  ([lindex $rd_res 3] << 0 )]
    return [format 0x%x $res]
  }
}

proc write8 {master addr data} {
  set wr_addr [expr $addr*1]
  if { [expr $wr_addr + 0] >= $::ADDRESS_SPACE_STOP } {
    return "ERROR: 'write8()' - out of address range!"
  } else {
    master_write_8 $master [expr $wr_addr + 0] [expr ($data >> 0) & (2**8-1)]
  }
}

proc write16 {master addr data} {
  set wr_addr [expr $addr*2]
  if { [expr $wr_addr + 1] >= $::ADDRESS_SPACE_STOP } {
    return "ERROR: 'write16()' - out of address range!"
  } else {
    master_write_8 $master [expr $wr_addr + 1] [expr ($data >> 0) & (2**8-1)]
    master_write_8 $master [expr $wr_addr + 0] [expr ($data >> 8) & (2**8-1)]
  }
}

proc write32 {master addr data} {
  set wr_addr [expr $addr*4]
  if { [expr $wr_addr + 3] >= $::ADDRESS_SPACE_STOP } {
    return "ERROR: 'write32()' - out of address range!"
  } else {
    master_write_8 $master [expr $wr_addr + 3] [expr ($data >> 0)  & (2**8-1)]
    master_write_8 $master [expr $wr_addr + 2] [expr ($data >> 8)  & (2**8-1)]
    master_write_8 $master [expr $wr_addr + 1] [expr ($data >> 16) & (2**8-1)]
    master_write_8 $master [expr $wr_addr + 0] [expr ($data >> 24) & (2**8-1)]
  }
}

proc mem8_dump {master} {
  global ADDRESS_SPACE_STOP
  for {set i 0} {$i < $ADDRESS_SPACE_STOP} {incr i} {
    puts "$i : [read8 $master]"
  }
}

proc mem16_dump {master} {
  global ADDRESS_SPACE_STOP
  for {set i 0} {$i < [expr $ADDRESS_SPACE_STOP/2]} {incr i} {
    puts "$i : [read16 $master]"
  }
}

proc mem32_dump {master} {
  global ADDRESS_SPACE_STOP
  for {set i 0} {$i < [expr $ADDRESS_SPACE_STOP/4]} {incr i} {
    puts "$i : [read32 $master]"
  }
}

