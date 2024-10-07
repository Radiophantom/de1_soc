
proc list_masters {} {
  set masters [get_service_paths master]
  for {set i 0} {$i < [llength $masters]} {incr i} {
    puts "$i: [lindex $masters $i]"
  }
}

##################################################
# Memory IO class declaration
##################################################

oo::class create MEM_IO

oo::define MEM_IO {
  variable MASTER_NAME
  variable ADDRESS_SPACE_START
  variable ADDRESS_SPACE_END
}

oo::define MEM_IO {
  constructor {master_index address_space_start address_space_size} {
    set ADDRESS_SPACE_START $address_space_start
    set ADDRESS_SPACE_END   [expr $address_space_start + $address_space_size - 1]
    set MASTER_NAME         [lindex [get_service_paths master] $master_index]
    if { $MASTER_NAME == "" } {
      puts "\[ERROR\] No master with $master_index index exists! Exiting..."
      my destroy
    }
  }
}

oo::define MEM_IO {export read8}
oo::define MEM_IO {export read16}
oo::define MEM_IO {export read32}
oo::define MEM_IO {export write8}
oo::define MEM_IO {export write16}
oo::define MEM_IO {export write32}
oo::define MEM_IO {export mem8_dump}
oo::define MEM_IO {export mem16_dump}
oo::define MEM_IO {export mem32_dump}

##################################################
# Memory IO class implementation
##################################################

# READ operations
oo::define MEM_IO {

  method read8 {addr} {
    set rd_addr [expr $addr*1]
    if { ($rd_addr < $ADDRESS_SPACE_START) || ([expr $rd_addr + 0] > $ADDRESS_SPACE_END) } {
      return "\[ERROR\]: 'read8()' - out of address range!"
    }
    open_service master $MASTER_NAME
    set rd_res [master_read_8 $MASTER_NAME $rd_addr 1]
    close_service master $MASTER_NAME
    return [format 0x%x $rd_res]
  }

  method read16 {addr} {
    set rd_addr [expr $addr*2]
    if { ($rd_addr < $ADDRESS_SPACE_START) || ([expr $rd_addr + 1] > $ADDRESS_SPACE_END) } {
      return "\[ERROR\]: 'read16()' - out of address range!"
    }
    open_service master $MASTER_NAME
    set rd_res [master_read_8 $MASTER_NAME $rd_addr 2]
    set res [expr ([lindex $rd_res 0] << 8) + \
                  ([lindex $rd_res 1] << 0)]
    close_service master $MASTER_NAME
    return [format 0x%x $res]
  }

  method read32 {addr} {
    set rd_addr [expr $addr*4]
    if { ($rd_addr < $ADDRESS_SPACE_START) || ([expr $rd_addr + 3] > $ADDRESS_SPACE_END) } {
      return "\[ERROR\]: 'read32()' - out of address range!"
    }
    open_service master $MASTER_NAME
    set rd_res [master_read_8 $MASTER_NAME $rd_addr 4]
    set res [expr ([lindex $rd_res 0] << 24) + \
                  ([lindex $rd_res 1] << 16) + \
                  ([lindex $rd_res 2] << 8 ) + \
                  ([lindex $rd_res 3] << 0 )]
    close_service master $MASTER_NAME
    return [format 0x%x $res]
  }

}

# WRITE operations
oo::define MEM_IO {

  method write8 {addr data} {
    set wr_addr [expr $addr*1]
    if { ($wr_addr < $ADDRESS_SPACE_START) || ([expr $wr_addr + 0] > $ADDRESS_SPACE_END) } {
      return "\[ERROR\]: 'write8()' - out of address range!"
    }
    open_service master $MASTER_NAME
    master_write_8 $MASTER_NAME [expr $wr_addr + 0] [expr ($data >> 0) & (2**8-1)]
    close_service master $MASTER_NAME
  }
  
  method write16 {addr data} {
    set wr_addr [expr $addr*2]
    if { ($wr_addr < $ADDRESS_SPACE_START) || ([expr $wr_addr + 1] > $ADDRESS_SPACE_END) } {
      return "\[ERROR\]: 'write16()' - out of address range!"
    }
    open_service master $MASTER_NAME
    master_write_8 $MASTER_NAME [expr $wr_addr + 1] [expr ($data >> 0) & (2**8-1)]
    master_write_8 $MASTER_NAME [expr $wr_addr + 0] [expr ($data >> 8) & (2**8-1)]
    close_service master $MASTER_NAME
  }
  
  method write32 {addr data} {
    set wr_addr [expr $addr*4]
    if { ($wr_addr < $ADDRESS_SPACE_START) || ([expr $wr_addr + 3] > $ADDRESS_SPACE_END) } {
      return "\[ERROR\]: 'write32()' - out of address range!"
    }
    open_service master $MASTER_NAME
    master_write_8 $MASTER_NAME [expr $wr_addr + 3] [expr ($data >> 0)  & (2**8-1)]
    master_write_8 $MASTER_NAME [expr $wr_addr + 2] [expr ($data >> 8)  & (2**8-1)]
    master_write_8 $MASTER_NAME [expr $wr_addr + 1] [expr ($data >> 16) & (2**8-1)]
    master_write_8 $MASTER_NAME [expr $wr_addr + 0] [expr ($data >> 24) & (2**8-1)]
    close_service master $MASTER_NAME
  }

}

# DUMP operations
oo::define MEM_IO {

  method mem8_dump {} {
    for {set i $ADDRESS_SPACE_START} {$i <= $ADDRESS_SPACE_END} {incr i} {
      puts "$i : [my read8 $i]"
    }
  }
  
  method mem16_dump {} {
    for {set i $ADDRESS_SPACE_START} {$i <= [expr $ADDRESS_SPACE_END/2]} {incr i} {
      puts "$i : [my read16 $i]"
    }
  }
  
  method mem32_dump {} {
    for {set i $ADDRESS_SPACE_START} {$i <= [expr $ADDRESS_SPACE_END/4]} {incr i} {
      puts "$i : [my read32 $i]"
    }
  }

}

