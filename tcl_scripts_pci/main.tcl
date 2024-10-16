
##################################################
# Import memory routines and create memory class
##################################################

source ../mem.tcl

set PCI_CONTROLLER_INDX         0
set PCI_CONTROLLER_BASE_ADDR    0x40000
set PCI_CONTROLLER_REGION_SIZE  0x20000

MEM_IO create pci_mem $PCI_CONTROLLER_INDX $PCI_CONTROLLER_BASE_ADDR $PCI_CONTROLLER_REGION_SIZE

##################################################
# CSR regs
##################################################

set CONTROL                 0
set RT_MSG_PTR_TABLE_ADDR   1
set BASIC_STATUS            2
set INTERRUPT_MASK          3
set CFG_REG1                9

##################################################
# RT constants
##################################################

set RT_ADDR 10

set SZ_RT_RX_BLOCK    35
set SZ_RT_TX_BLOCK    35
set SZ_RT_CODE_BLOCK  4

set RCV_IDX     0
set XMT_IDX     32
set MODE_IDX    64
set BRDCST_IDX  96

set rtMsgPtrTable 0x100

set recvTableAddr 0x500
set begRecvData   0x2000

set txTableAddr   0x800
set begTxData     0x3000

set codeTableAddr 0x1000
set begCodeData   0x4000

source init.tcl
source rt_utilities.tcl

##################################################
# Main
##################################################

init_rt_memory_layout

rtputw   10 0xABCD
rtputblk 20 {0xAAAA 0xBBBB 0xCCCC 0xDDDD} 3

puts [rtgetw   10]
puts [rtgetblk 20 4]

puts "\n\n"
puts "### RECEIVE TABLES ####"
for {set i 0x500} {$i < 0x600} {incr i} {
  puts "[format 0x%x $i] [pci_mem read16 $i]"
}
for {set i 0x2000} {$i < 0x2300} {incr i} {
  puts "[format 0x%x $i] [pci_mem read16 $i]"
}
puts "\n\n"
puts "### TRANSMIT TABLES ####"
for {set i 0x800} {$i < 0x900} {incr i} {
  puts "[format 0x%x $i] [pci_mem read16 $i]"
}
for {set i 0x3000} {$i < 0x3300} {incr i} {
  puts "[format 0x%x $i] [pci_mem read16 $i]"
}
puts "\n\n"

#for {set i 0x1000} {$i < 0x1100} {incr i} {
#  puts "[format 0x%x $i] [pci_mem read16 $i]"
#}
#for {set i 0x4000} {$i < 0x4300} {incr i} {
#  puts "[format 0x%x $i] [pci_mem read16 $i]"
#}

#proc main {} {
#
#  pci_mem write16 $CFG_REG1 0x0
#
#  init_rt_memory_layout
#
#  pci_mem write16 $CONTROL 0x0084
#  pci_mem write16 $INTERRUPT_MASK 0x0
#
#  pci_mem write16 $RESET_RT 0x0
#  pci_mem write16 $BASIC_STATUS [expr $RT_ADDR << 11]
#
#  pci_mem mem16_dump
#
#}

