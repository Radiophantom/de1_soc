
package mil_std_csr_pkg;

//------------------------------------------------------------------------------
// Receiver
//------------------------------------------------------------------------------

parameter RCV_CONTROL         = 0;
        parameter RCV_CONTROL_ENABLE = 0;
        parameter RCV_CONTROL_BUSY   = 15;

parameter RCV_IRQ_ENABLE      = 1;
parameter RCV_IRQ_VECTOR      = 2;
        parameter RCV_IRQ_VECTOR_MSG_VALID = 0;

parameter RCV_DATA_WORD       = 3;

parameter RCV_DATA_STATUS     = 4;
        parameter RCV_DATA_STATUS_SYNC_C = 0;

parameter RCV_DATA_ERRORS     = 5;
        parameter RCV_DATA_ERRORS_PARITY = 0;

//------------------------------------------------------------------------------
// Transmitter
//------------------------------------------------------------------------------

parameter XMT_CONTROL         = 6;
        parameter XMT_CONTROL_ENABLE  = 0;
        parameter XMT_CONTROL_BUSY    = 15;

parameter XMT_IRQ_ENABLE      = 7;
parameter XMT_IRQ_VECTOR      = 8;

parameter XMT_DATA_SEND       = 9;
        parameter XMT_DATA_SEND_STB     = 0;

parameter XMT_DATA_WORD       = 10;
parameter XMT_DATA_STATUS     = 11;
        parameter XMT_DATA_STATUS_SYNC_C  = 15;

//------------------------------------------------------------------------------
// Service info
//------------------------------------------------------------------------------

parameter CSR_CNT = 12;

parameter logic [15:0] REGS_RO_MASK [CSR_CNT] = '{
  16'hFFFE,
  16'h0000,
  16'hFFFF,
  16'hFFFF,
  16'hFFFF,
  16'hFFFF,
  16'hFFFE,
  16'h0000,
  16'hFFFF,
  16'hFFFF,
  16'h0000,
  16'hFFFE
};

endpackage

