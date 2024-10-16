
proc rtputw {subaddr data} {
  global begTxData
  global SZ_RT_TX_BLOCK
  set begSubDataAddr [expr $begTxData + $SZ_RT_TX_BLOCK*$subaddr]
  for {set i 0} {$i < 1000} {incr i} {
    if { [expr [pci_mem read16 $begSubDataAddr] & 0x80] == 0 } {
      break
    }
    after 1
  }
  pci_mem write16 [expr $begSubDataAddr+3] $data
  pci_mem write16 $begSubDataAddr [expr [pci_mem read16 $begSubDataAddr] | 0x8000]
}

proc rtgetw {subaddr} {
  global begRecvData
  global SZ_RT_RX_BLOCK
  set begSubDataAddr [expr $begRecvData + $SZ_RT_RX_BLOCK*$subaddr]
  for {set i 0} {$i < 1000} {incr i} {
    if { [expr [pci_mem read16 $begSubDataAddr] & 0x80] == 0 } {
      break
    }
    after 1
  }
  set word [pci_mem read16 [expr $begSubDataAddr+3]]
  pci_mem write16 $begSubDataAddr [expr [pci_mem read16 $begSubDataAddr] & ~0x8000]
  return $word
}

proc rtputblk {subaddr data length} {
  global begTxData
  global SZ_RT_TX_BLOCK
  set begSubDataAddr [expr $begTxData + $SZ_RT_TX_BLOCK*$subaddr]
  for {set i 0} {$i < 1000} {incr i} {
    if { [expr [pci_mem read16 $begSubDataAddr] & 0x80] == 0 } {
      break
    }
    after 1
  }
  for {set i 0} {$i < $length} {incr i} {
    pci_mem write16 [expr $begSubDataAddr+3+$i] [lindex $data $i]
  }
  pci_mem write16 $begSubDataAddr [expr [pci_mem read16 $begSubDataAddr] | 0x8000]
}

proc rtgetblk {subaddr length} {
  global begRecvData
  global SZ_RT_RX_BLOCK
  set begSubDataAddr [expr $begRecvData + $SZ_RT_RX_BLOCK*$subaddr]
  for {set i 0} {$i < 1000} {incr i} {
    if { [expr [pci_mem read16 $begSubDataAddr] & 0x80] == 0 } {
      break
    }
    after 1
  }
  set word_list {}
  for {set i 0} {$i < $length} {incr i} {
    lappend word_list [pci_mem read16 [expr $begSubDataAddr+3+$i]]
  }
  pci_mem write16 $begSubDataAddr [expr [pci_mem read16 $begSubDataAddr] & ~0x8000]
  return $word_list
}

