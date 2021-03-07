CLASS zcl_app_test_report DEFINITION
  PUBLIC
  INHERITING FROM zcl_app_report
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES: BEGIN OF ts_selscreen,
             s_carrid TYPE RANGE OF sflight-carrid,
             s_connid TYPE RANGE OF sflight-connid,
             s_pltype TYPE RANGE OF sflight-planetype,
           END OF ts_selscreen,

           tt_table  TYPE TABLE OF sflight,
           tt_tree   TYPE TABLE OF sflight,
           tt_output TYPE TABLE OF sflight.

    CONSTANTS: BEGIN OF mc_container,
                 bar   TYPE string VALUE 'BAR',
                 table TYPE string VALUE 'TABLE',
                 tree  TYPE string VALUE 'TREE',
               END OF mc_container,

               BEGIN OF mc_functions,
                 BEGIN OF output,
                   test TYPE string VALUE '/TEST',
                 END OF output,
               END OF mc_functions,

               BEGIN OF mc_columns,
                 BEGIN OF output,
                   mandt      TYPE string VALUE 'MANDT',
                   carrid     TYPE string VALUE 'CARRID',
                   connid     TYPE string VALUE 'CONNID',
                   fldate     TYPE string VALUE 'FLDATE',
                   price      TYPE string VALUE 'PRICE',
                   currency   TYPE string VALUE 'CURRENCY',
                   planetype  TYPE string VALUE 'PLANETYPE',
                   seatsmax   TYPE string VALUE 'SEATSMAX',
                   seatsocc   TYPE string VALUE 'SEATSOCC',
                   paymentsum TYPE string VALUE 'PAYMENTSUM',
                   seatsmax_b TYPE string VALUE 'SEATSMAX_B',
                   seatsocc_b TYPE string VALUE 'SEATSOCC_B',
                   seatsmax_f TYPE string VALUE 'SEATSMAX_F',
                   seatsocc_f TYPE string VALUE 'SEATSOCC_F',
                 END OF output,
               END OF mc_columns.

    DATA: BEGIN OF ms_selopts,
            sflight TYPE sflight,
          END OF ms_selopts.

    METHODS:
      check_selection REDEFINITION,
      extend_output REDEFINITION,
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
  METHOD check_selection.
    IF ms_selscreen-s_carrid[] IS INITIAL.
      MESSAGE 'Airline should not be empty' TYPE 'S' DISPLAY LIKE 'E'.

      rv_skip = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD extend_output.
    DATA(lo_functions) = io_table->get_functions( ).

    lo_functions->add_function(
      iv_name      = mc_functions-output-test
      iv_icon      = icon_okay
      iv_text      = 'Test'
      iv_quickinfo = ''
      iv_position  = if_salv_c_function_position=>right_of_salv_functions
    ).

    LOOP AT io_table->get_columns( )->get( ) REFERENCE INTO DATA(lr_column).
      CASE lr_column->name.
        WHEN mc_columns-output-price.
          lr_column->column->set_editable( ).
          lr_column->column->set_optimized( ).
        WHEN OTHERS.
          lr_column->column->set_optimized( ).
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.

  METHOD on_init.
    CASE io_dynpro->get_screen( ).
      WHEN 2000.
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
    ENDCASE.
  ENDMETHOD.

  METHOD on_pai.
    CASE io_dynpro->get_screen( ).
      WHEN 1000.

      WHEN 2000.
        CASE io_dynpro->reduce_command( ).
          WHEN io_dynpro->mc_commands-back
            OR io_dynpro->mc_commands-exit
            OR io_dynpro->mc_commands-cancel.
            LEAVE TO SCREEN 0.
        ENDCASE.
    ENDCASE.
  ENDMETHOD.

  METHOD on_pbo.
    CASE io_dynpro->get_screen( ).
      WHEN 1000.

      WHEN 2000.

    ENDCASE.
  ENDMETHOD.

  METHOD selection_get_data.
    SELECT * FROM sflight INTO TABLE @mt_output
      WHERE carrid    IN @ms_selscreen-s_carrid
        AND connid    IN @ms_selscreen-s_connid
        AND planetype IN @ms_selscreen-s_pltype.
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
