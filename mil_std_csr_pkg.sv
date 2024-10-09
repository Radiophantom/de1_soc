package mil_std_csr_pkg;

  //////////////////////////////////////////////////////////////////////////////
  // Receiver
  //////////////////////////////////////////////////////////////////////////////

  parameter RCV_CONTROL       = 0;
          parameter RCV_CONTROL_ENABLE  = 0;
          parameter RCV_CONTROL_IRQ_EN  = 1;
          parameter RCV_CONTROL_BUSY    = 15;

  parameter RCV_IRQ_VECTOR    = 1;
          parameter RCV_IRQ_VECTOR_RCV = 0;

  parameter RCV_DATA_WORD     = 2;

  parameter RCV_DATA_STATUS   = 3;
          parameter RCV_DATA_STATUS_SYNC_C = 0;

  parameter RCV_DATA_ERRORS   = 4;
          parameter RCV_DATA_ERRORS_PARITY = 0;

  //////////////////////////////////////////////////////////////////////////////
  // Transmitter
  //////////////////////////////////////////////////////////////////////////////

  parameter XMT_CONTROL       = 5;
          parameter XMT_CONTROL_ENABLE  = 0;
          parameter XMT_CONTROL_IRQ_EN  = 1;
          parameter XMT_CONTROL_SEND    = 2;
          parameter XMT_CONTROL_BUSY    = 15;

  parameter XMT_IRQ_VECTOR    = 6;
          parameter XMT_IRQ_VECTOR_TRS = 0;

  parameter XMT_DATA_WORD     = 7;

  parameter XMT_DATA_STATUS   = 8;
          parameter XMT_DATA_STATUS_SYNC_C = 0;

endpackage

