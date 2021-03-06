CLASS zcl_app_test_report DEFINITION
  PUBLIC
  INHERITING FROM zcl_app_report
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES: BEGIN OF ts_selscreen,
             s_matnr TYPE RANGE OF matnr,
             p_test  TYPE abap_bool,
             p_matnr TYPE matnr,
           END OF ts_selscreen,

           tt_table  TYPE TABLE OF sflight,
           tt_tree   TYPE TABLE OF sflight,
           tt_output TYPE TABLE OF sflight.

    CONSTANTS: BEGIN OF mc_container,
                 bar   TYPE string VALUE 'BAR',
                 table TYPE string VALUE 'TABLE',
                 tree  TYPE string VALUE 'TREE',
               END OF mc_container.

    DATA: BEGIN OF ms_selopts,
            s_matnr TYPE matnr,
          END OF ms_selopts.

    METHODS:
      on_init REDEFINITION,
      on_pai REDEFINITION,
      on_pbo REDEFINITION,
      setup_output REDEFINITION,
      setup_selscreen REDEFINITION,
      selection_get_data REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mt_output    TYPE tt_output,
          mt_table     TYPE tt_table,
          mt_tree      TYPE tt_tree,
          ms_selscreen TYPE ts_selscreen.

ENDCLASS.



CLASS zcl_app_test_report IMPLEMENTATION.


  METHOD on_init.
    BREAK developer.
    DATA(lo_bar) = zcl_app_container_bar=>create(
                     iv_name   = mc_container-bar
                     iv_side   = zcl_app_container_bar=>mc_sides-right
                   ).

    DATA(lo_table) = zcl_app_container_table=>create(
                       EXPORTING
                         iv_name  = mc_container-table
                         iv_side  = zcl_app_container_table=>mc_sides-custom
                       CHANGING
                         ct_table = mt_table
                     ).

    DATA(lo_tree) = zcl_app_container_tree=>create(
                      EXPORTING
                        iv_name  = mc_container-tree
                        iv_side  = zcl_app_container_tree=>mc_sides-custom
                      CHANGING
                        ct_table = mt_tree
                    ).

    lo_bar->add_container(
      iv_title     = 'Table Container'
      iv_icon      = icon_order
      io_container = lo_table
    ).

    lo_bar->add_container(
      iv_title     = 'Tree Container'
      iv_icon      = icon_okay
      io_container = lo_tree
    ).

    add_container( lo_bar ).
  ENDMETHOD.


  METHOD on_pai.
    CASE iv_screen.
      WHEN 1000.

      WHEN 2000.

    ENDCASE.
  ENDMETHOD.


  METHOD on_pbo.
    CASE iv_screen.
      WHEN 1000.

      WHEN 2000.

    ENDCASE.
  ENDMETHOD.


  METHOD selection_get_data.
    BREAK developer.
  ENDMETHOD.


  METHOD setup_output.
    set_output(
      CHANGING
        ct_data = mt_output
    ).
  ENDMETHOD.


  METHOD setup_selscreen.
    set_selscreen(
      CHANGING
        cs_data = ms_selscreen
    ).
  ENDMETHOD.
ENDCLASS.
