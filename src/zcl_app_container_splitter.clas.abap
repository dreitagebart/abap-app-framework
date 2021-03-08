CLASS zcl_app_container_splitter DEFINITION
  PUBLIC
  INHERITING FROM zca_app_container
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    CONSTANTS: BEGIN OF mc_split_modes,
                 vertical   TYPE char1 VALUE 'V',
                 horizontal TYPE char1 VALUE 'H',
               END OF mc_split_modes.

    CLASS-METHODS:
      create
        IMPORTING
                  iv_name          TYPE string
                  iv_side          TYPE int4 DEFAULT mc_sides-custom
                  iv_split_mode    TYPE char1 DEFAULT mc_split_modes-vertical
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_container_splitter.

    METHODS:
      add_container
        IMPORTING
          io_container TYPE REF TO zca_app_container,
      create_instance REDEFINITION,
      get_container
        IMPORTING
                  iv_name          TYPE string
        RETURNING VALUE(ro_result) TYPE REF TO zca_app_container
        RAISING   zcx_app,
      register_events REDEFINITION,
      set_size
        IMPORTING
          iv_name TYPE string
          iv_size TYPE i.

  PROTECTED SECTION.

  PRIVATE SECTION.
    TYPES: BEGIN OF ts_size,
             name TYPE string,
             size TYPE i,
           END OF ts_size,

           tt_size TYPE TABLE OF ts_size.

    DATA: mo_splitter TYPE REF TO cl_gui_splitter_container,
          mv_mode     TYPE char1,
          mt_children TYPE tt_children,
          mt_sizes    TYPE tt_size.

    METHODS:
      constructor
        IMPORTING
          iv_mode TYPE char1
          iv_name TYPE string
          iv_side TYPE int4.

ENDCLASS.



CLASS zcl_app_container_splitter IMPLEMENTATION.
  METHOD set_size.
    IF mo_splitter IS NOT BOUND.
      TRY.
          DATA(lr_size) = REF #( mt_sizes[ name  = iv_name ] ).

          lr_size->size = iv_size.
        CATCH cx_sy_itab_line_not_found.
          APPEND VALUE ts_size( name = iv_name
                                size = iv_size ) TO mt_sizes.
      ENDTRY.
    ELSE.
      LOOP AT mt_children REFERENCE INTO DATA(lr_child).
        DATA(lv_index) = sy-tabix.

        IF lr_child->*->mv_name = iv_name.
          CASE mv_mode.
            WHEN mc_split_modes-horizontal.
              mo_splitter->set_column_width(
                id    = lv_index
                width = iv_size
              ).
            WHEN mc_split_modes-vertical.
              mo_splitter->set_row_height(
                id                = lv_index
                height            = iv_size
              ).
          ENDCASE.

          EXIT.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

  METHOD get_container.
    LOOP AT mt_children REFERENCE INTO DATA(lr_child).
      IF lr_child->*->get_name( ) = iv_name.
        DATA(lv_match) = abap_true.

        ro_result = lr_child->*.
      ENDIF.
    ENDLOOP.

    IF lv_match = abap_false.
      RAISE EXCEPTION TYPE zcx_app
        MESSAGE e011 WITH iv_name.
    ENDIF.
  ENDMETHOD.

  METHOD add_container.
    APPEND io_container TO mt_children.
  ENDMETHOD.

  METHOD create.
    ro_result = NEW zcl_app_container_splitter(
      iv_name = iv_name
      iv_side = iv_side
      iv_mode = iv_split_mode
    ).
  ENDMETHOD.

  METHOD constructor.
    super->constructor(
      iv_name = iv_name
      iv_side = iv_side
    ).

    mv_mode = iv_mode.
  ENDMETHOD.

  METHOD create_instance.
    DATA(lv_child_count) = lines( mt_children ).

    mo_splitter = NEW cl_gui_splitter_container(
*     link_dynnr              =
*     link_repid              =
*     shellstyle              =
*     left                    =
*     top                     =
*     width                   =
*     height                  =
      metric                  = cntl_metric_dynpro
*     align                   = 15
      parent                  = get_parent( )
      rows                    = SWITCH #( mv_mode WHEN mc_split_modes-horizontal THEN 1
                                                  ELSE lv_child_count )
      columns                 = SWITCH #( mv_mode WHEN mc_split_modes-horizontal THEN lv_child_count
                                                  ELSE 1 )
      no_autodef_progid_dynnr = abap_true
*     name                    =
    ).

    register_events( ).

    LOOP AT mt_children REFERENCE INTO DATA(lr_child).
      DATA(lv_index) = sy-tabix.

      lr_child->*->mo_parent = mo_splitter->get_container(
                                 row    = SWITCH #( mv_mode WHEN mc_split_modes-horizontal THEN 1
                                                            ELSE lv_index )
                                 column = SWITCH #( mv_mode WHEN mc_split_modes-horizontal THEN lv_index
                                                            ELSE 1 )
                               ).

      lr_child->*->create_instance( ).

      TRY.
          DATA(lr_size) = REF #( mt_sizes[ name = lr_child->*->mv_name ] ).

          set_size(
            iv_name = lr_size->name
            iv_size = lr_size->size
          ).
        CATCH cx_sy_itab_line_not_found.
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.

  METHOD register_events.

  ENDMETHOD.
ENDCLASS.
