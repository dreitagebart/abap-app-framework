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

           BEGIN OF ts_output,
             material    TYPE matnr,
             description TYPE maktx,
             type        TYPE mtart,
           END OF ts_output,

           tt_output TYPE TABLE OF ts_output.

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
          ms_selscreen TYPE ts_selscreen.

ENDCLASS.



CLASS zcl_app_test_report IMPLEMENTATION.
  METHOD on_init.
    BREAK developer.
    DATA(lo_bar) = NEW zcl_app_container_bar(
                     iv_name     = mc_container-bar
                     iv_side     = zca_app_container=>mc_sides-right
                   ).

    lo_bar->add_container(
      iv_title     = 'Table Container'
      iv_icon      = icon_order
      io_container = NEW zcl_app_container_table(
                       iv_name = mc_container-table
                       iv_side = zca_app_container=>mc_sides-custom
                     ) ).

    lo_bar->add_container(
      iv_title     = 'Tree Container'
      iv_icon      = icon_okay
      io_container = NEW zcl_app_container_tree(
                       iv_name = mc_container-tree
                       iv_side = zca_app_container=>mc_sides-custom
                     )
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
