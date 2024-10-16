
proc init_rt_memory_layout {} {

  global RT_MSG_PTR_TABLE_ADDR

  global SZ_RT_RX_BLOCK
  global SZ_RT_TX_BLOCK
  global SZ_RT_CODE_BLOCK

  global RCV_IDX
  global XMT_IDX
  global MODE_IDX
  global BRDCST_IDX

  global rtMsgPtrTable

  global recvTableAddr
  global begRecvData

  global txTableAddr
  global begTxData

  global codeTableAddr
  global begCodeData

  variable  tableAddr
  variable  begSubDataAddr;
  variable  cmdDataAddr;

  pci_mem write16 $RT_MSG_PTR_TABLE_ADDR $rtMsgPtrTable

  for {set subaddr 1} {$subaddr < 31} {incr subaddr} {

    set tableAddr [expr $recvTableAddr+($subaddr << 2)]
    set begSubDataAddr [expr $begRecvData+$SZ_RT_RX_BLOCK*$subaddr] 

    pci_mem write16 [expr $rtMsgPtrTable+$RCV_IDX+$subaddr] $tableAddr
    pci_mem write16 $tableAddr 0x1;
    incr tableAddr
    pci_mem write16 $tableAddr $begSubDataAddr
    pci_mem write16 $begSubDataAddr 0x1000

    set tableAddr [expr $txTableAddr+($subaddr<<2)]
    set begSubDataAddr [expr $begTxData+$SZ_RT_TX_BLOCK*$subaddr] 

    pci_mem write16 [expr $rtMsgPtrTable+$XMT_IDX+$subaddr] $tableAddr
    pci_mem write16 $tableAddr 0x1;
    incr tableAddr
    pci_mem write16 $tableAddr $begSubDataAddr
    pci_mem write16 $begSubDataAddr 0x1000
  }

  for {set code 0} {$code < 32} {incr code} {

    set tableAddr [expr $codeTableAddr+($code<<2)]
    set cmdDataAddr [expr $begCodeData+$SZ_RT_CODE_BLOCK*$code]

    pci_mem write16 [expr $rtMsgPtrTable+$MODE_IDX+$code] $tableAddr
    pci_mem write16 $tableAddr 0x1;
    incr tableAddr
    pci_mem write16 $tableAddr $cmdDataAddr
    pci_mem write16 $cmdDataAddr 0x1000
   }
}

