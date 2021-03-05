*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 05.03.2021 at 12:51:32
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZAPP_CUST.......................................*
DATA:  BEGIN OF STATUS_ZAPP_CUST                     .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZAPP_CUST                     .
CONTROLS: TCTRL_ZAPP_CUST
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZAPP_CUST                     .
TABLES: ZAPP_CUST                      .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
