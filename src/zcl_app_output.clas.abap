CLASS zcl_app_output DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    CONSTANTS: BEGIN OF mc_functions,
                 BEGIN OF output,
                   selection TYPE string VALUE '&/APP/SELECTION',
                 END OF output,
               END OF mc_functions.

    METHODS:
      constructor
        IMPORTING
          io_app TYPE REF TO zcl_app_report.

  PROTECTED SECTION.

  PRIVATE SECTION.
    TYPES: BEGIN OF ts_selection,
             name TYPE string,
             icon TYPE icon_d,
             low  TYPE string,
             high TYPE string,
           END OF ts_selection,

           tt_selection TYPE TABLE OF ts_selection.

    CONSTANTS: BEGIN OF mc_container,
                 splitter            TYPE string VALUE 'SPLITTER',
                 selection_container TYPE string VALUE 'SELECTION',
                 footer_container    TYPE string VALUE 'FOOTER',
                 output              TYPE string VALUE 'OUTPUT',
                 BEGIN OF footer,
                   left   TYPE string VALUE 'LEFT',
                   middle TYPE string VALUE 'MIDDLE',
                   right  TYPE string VALUE 'RIGHT',
                 END OF footer,
               END OF mc_container.

    DATA: mo_app       TYPE REF TO zcl_app_report,
          mo_splitter  TYPE REF TO zcl_app_container_splitter,
          mo_footer    TYPE REF TO zcl_app_container_splitter,
          mo_left      TYPE REF TO zcl_app_container_document,
          mo_middle    TYPE REF TO zcl_app_container_document,
          mo_right     TYPE REF TO zcl_app_container_document,
          mo_output    TYPE REF TO zcl_app_container_table,
          mo_selection TYPE REF TO zcl_app_container_table,

          mt_selection TYPE tt_selection.

    METHODS:
      create,
      create_footer,
      create_output,
      create_selection,
      create_splitter,
      handle_default_function FOR EVENT on_default_function OF zcl_app_container_table
        IMPORTING
          iv_function.

ENDCLASS.



CLASS zcl_app_output IMPLEMENTATION.
  METHOD handle_default_function.
    CASE iv_function.
      WHEN mc_functions-output-selection.
        TRY.
            DATA(lv_size) = mo_splitter->get_size( mc_container-selection_container ).

            IF lv_size > 0.
              mo_splitter->set_size(
                iv_name = mc_container-selection_container
                iv_size = 0
              ).
            ELSE.
              mo_splitter->set_size(
                iv_name = mc_container-selection_container
                iv_size = 20
              ).
            ENDIF.
          CATCH zcx_app INTO DATA(lx_error).
        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD constructor.
    mo_app = io_app.

    create( ).
  ENDMETHOD.

  METHOD create_footer.
    mo_footer = zcl_app_container_splitter=>create(
                  iv_name       = mc_container-footer_container
                  iv_split_mode = zcl_app_container_splitter=>mc_split_modes-horizontal
                ).

    mo_left = zcl_app_container_document=>create( mc_container-footer-left ).
    mo_middle = zcl_app_container_document=>create( mc_container-footer-middle ).
    mo_right = zcl_app_container_document=>create( mc_container-footer-right ).

    mo_footer->add_container( mo_left ).
    mo_footer->add_container( mo_middle ).
    mo_footer->add_container( mo_right ).
  ENDMETHOD.

  METHOD create_selection.
    mo_selection = zcl_app_container_table=>create(
                     EXPORTING
                       iv_name  = mc_container-selection_container
                     CHANGING
                       ct_table = mt_selection
                   ).
  ENDMETHOD.

  METHOD create_splitter.
    mo_splitter = zcl_app_container_splitter=>create(
                    iv_name       = mc_container-splitter
                    iv_side       = zca_app_container=>mc_sides-default
                    iv_split_mode = zcl_app_container_splitter=>mc_split_modes-vertical
                  ).

    mo_splitter->set_size(
      iv_name = mc_container-footer_container
      iv_size = 5
    ).

    mo_splitter->set_size(
      iv_name = mc_container-selection_container
      iv_size = 0
    ).

    mo_splitter->add_container( mo_selection ).
    mo_splitter->add_container( mo_output ).
    mo_splitter->add_container( mo_footer ).

    mo_app->add_container( mo_splitter ).
  ENDMETHOD.

  METHOD create_output.
    FIELD-SYMBOLS: <output> TYPE ANY TABLE.

    ASSIGN mo_app->mr_output->* TO <output>.

    mo_output = zcl_app_container_table=>create(
                  EXPORTING
                    iv_name  = mc_container-output
                  CHANGING
                    ct_table = <output>
                ).
  ENDMETHOD.

  METHOD create.
    create_selection( ).
    create_output( ).
    create_footer( ).
    create_splitter( ).

    LOOP AT mo_app->mt_container REFERENCE INTO DATA(lr_container).
      IF lr_container->*->mo_parent IS NOT BOUND.
        lr_container->*->create_parent( ).
        lr_container->*->create_instance( ).
      ENDIF.
    ENDLOOP.

    MESSAGE s020 INTO DATA(lv_text).
    MESSAGE s021 INTO DATA(lv_tooltip).

    TRY.
        mo_output->get_functions( )->add_function(
          iv_name     = mc_functions-output-selection
          iv_icon     = icon_selection
          iv_text     = lv_text
          iv_tooltip  = lv_tooltip
          iv_position = if_salv_c_function_position=>right_of_salv_functions
        ).

        mo_output->refresh( ).
      CATCH zcx_app.
    ENDTRY.

    SET HANDLER handle_default_function FOR mo_output.
  ENDMETHOD.
ENDCLASS.
