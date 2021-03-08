CLASS zcl_app_alv_table DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    CONSTANTS: BEGIN OF mc_colors,
                 background TYPE i VALUE cl_gui_resources=>list_col_background,
                 blue       TYPE i VALUE cl_gui_resources=>list_col_heading,
                 gray       TYPE i VALUE cl_gui_resources=>list_col_normal,
                 yellow     TYPE i VALUE cl_gui_resources=>list_col_total,
                 gray_blue  TYPE i VALUE cl_gui_resources=>list_col_key,
                 green      TYPE i VALUE cl_gui_resources=>list_col_positive,
                 red        TYPE i VALUE cl_gui_resources=>list_col_negative,
                 orange     TYPE i VALUE cl_gui_resources=>list_col_group,
               END OF mc_colors,

               BEGIN OF mc_celltypes,
                 hotspot  TYPE salv_de_celltype VALUE if_salv_c_cell_type=>hotspot,
                 button   TYPE salv_de_celltype VALUE if_salv_c_cell_type=>button,
                 checkbox TYPE salv_de_celltype VALUE if_salv_c_cell_type=>checkbox,
                 dropdown TYPE salv_de_celltype VALUE if_salv_c_cell_type=>dropdown,
                 link     TYPE salv_de_celltype VALUE if_salv_c_cell_type=>link,
                 text     TYPE salv_de_celltype VALUE if_salv_c_cell_type=>text,
               END OF mc_celltypes,

               BEGIN OF mc_selmodes,
                 single     TYPE char1 VALUE 'B',
                 cell       TYPE char1 VALUE 'A',
                 multiple   TYPE char1 VALUE 'C',
                 row_column TYPE char1 VALUE 'D',
               END OF mc_selmodes.

    EVENTS: on_extension
              EXPORTING VALUE(io_table) TYPE REF TO zcl_app_container_table,
            on_double_click
              EXPORTING VALUE(iv_row) TYPE int4
                        VALUE(iv_column) TYPE string,
            on_link_click
              EXPORTING VALUE(iv_row) TYPE int4
                        VALUE(iv_column) TYPE string,
            on_added_function
              EXPORTING VALUE(iv_function) TYPE string,
            on_before_function
              EXPORTING VALUE(iv_function) TYPE string,
            on_after_function
              EXPORTING VALUE(iv_function) TYPE string.

    CLASS-METHODS:
      factory
        IMPORTING
                  io_parent         TYPE REF TO cl_gui_container OPTIONAL
                  iv_container_name TYPE string OPTIONAL
        CHANGING
                  ct_table          TYPE table
        RETURNING VALUE(ro_result)  TYPE REF TO zcl_app_alv_table
        RAISING   zcx_app.

    METHODS:
      display,
      get_columns
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_table_columns,
      get_layout
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_table_layout,
      get_display_settings
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_table_settings,
      get_functions
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_table_functions,
      get_selections
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_table_selections,
      get_filters
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_table_filters,
      handle_f1 FOR EVENT onf1 OF cl_gui_alv_grid
        IMPORTING
          e_fieldname
          es_row_no
          er_event_data,
      handle_f4 FOR EVENT onf4 OF cl_gui_alv_grid
        IMPORTING
          e_fieldname
          e_fieldvalue
          es_row_no
          er_event_data
          et_bad_cells
          e_display,
      handle_data_changed FOR EVENT data_changed OF cl_gui_alv_grid
        IMPORTING
          er_data_changed
          e_onf4
          e_onf4_before
          e_onf4_after
          e_ucomm,
      handle_drop_get_flavor FOR EVENT ondropgetflavor OF cl_gui_alv_grid
        IMPORTING
          e_row
          e_column
          es_row_no
          e_dragdropobj
          e_flavors,
      handle_drag FOR EVENT ondrag OF cl_gui_alv_grid
        IMPORTING
          e_row
          e_column
          es_row_no
          e_dragdropobj,
      handle_drop FOR EVENT ondrop OF cl_gui_alv_grid
        IMPORTING
          e_row
          e_column
          es_row_no
          e_dragdropobj,
      handle_drop_complete FOR EVENT ondropcomplete OF cl_gui_alv_grid
        IMPORTING
          e_row
          e_column
          es_row_no
          e_dragdropobj,
      handle_subtotal_text FOR EVENT subtotal_text OF cl_gui_alv_grid
        IMPORTING
          es_subtottxt_info
          ep_subtot_line
          e_event_data,
      handle_before_usercommand FOR EVENT before_user_command OF cl_gui_alv_grid
        IMPORTING
          e_ucomm,
      handle_usercommand FOR EVENT user_command OF cl_gui_alv_grid
        IMPORTING
          e_ucomm,
      handle_after_usercommand FOR EVENT after_user_command OF cl_gui_alv_grid
        IMPORTING
          e_ucomm
          e_saved
          e_not_processed,
      handle_double_click FOR EVENT double_click OF cl_gui_alv_grid
        IMPORTING
          e_row
          e_column
          es_row_no,
      handle_delayed_callback FOR EVENT delayed_callback OF cl_gui_alv_grid,
      handle_delayed_c_sel_cb FOR EVENT delayed_changed_sel_callback OF cl_gui_alv_grid,
      handle_ctx_request FOR EVENT context_menu_request OF cl_gui_alv_grid
        IMPORTING
          e_object,
      handle_menu_button FOR EVENT menu_button OF cl_gui_alv_grid
        IMPORTING
          e_object
          e_ucomm,
      handle_toolbar FOR EVENT toolbar OF cl_gui_alv_grid
        IMPORTING
          e_object
          e_interactive,
      handle_hotspot_click FOR EVENT hotspot_click OF cl_gui_alv_grid
        IMPORTING
          e_row_id
          e_column_id
          es_row_no,
      handle_after_refresh FOR EVENT after_refresh  OF cl_gui_alv_grid,
      handle_button_click FOR EVENT button_click OF cl_gui_alv_grid
        IMPORTING
          es_col_id
          es_row_no,
      handle_data_changed_finish FOR EVENT data_changed_finished OF cl_gui_alv_grid
        IMPORTING
          e_modified
          et_good_cells,
      handle_drop_ext_files FOR EVENT drop_external_files OF cl_gui_alv_grid
        IMPORTING
          files,
      refresh
        IMPORTING
          is_stable TYPE lvc_s_stbl
          iv_mode   TYPE salv_de_constant DEFAULT if_salv_c_refresh=>soft.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: mo_alv        TYPE REF TO cl_gui_alv_grid,
          mo_salv       TYPE REF TO cl_salv_table,
          mo_columns    TYPE REF TO zcl_app_table_columns,
          mo_selections TYPE REF TO zcl_app_table_selections,
          mo_filters    TYPE REF TO zcl_app_table_filters,
          mo_functions  TYPE REF TO zcl_app_table_functions,
          mo_layout     TYPE REF TO zcl_app_table_layout,
          mo_settings   TYPE REF TO zcl_app_table_settings,
          mr_output     TYPE REF TO data,
          ms_layout     TYPE lvc_s_layo,
          mt_fieldcat   TYPE lvc_t_fcat.

    METHODS:
      constructor
        IMPORTING
          iv_name   TYPE string
          ir_output TYPE REF TO data
          io_parent TYPE REF TO cl_gui_container.

ENDCLASS.



CLASS zcl_app_alv_table IMPLEMENTATION.
  METHOD get_columns.
    IF mo_columns IS NOT BOUND.
      GET REFERENCE OF mt_fieldcat INTO DATA(lr_fieldcat).
      GET REFERENCE OF ms_layout INTO DATA(lr_layout).

      mo_columns = NEW zcl_app_table_columns(
        ir_layout   = lr_layout
        ir_fieldcat = lr_fieldcat
      ).
    ENDIF.

    ro_result = mo_columns.
  ENDMETHOD.

  METHOD get_display_settings.
*    ro_result = mo_settings.
  ENDMETHOD.

  METHOD get_filters.
    ro_result = mo_filters.
  ENDMETHOD.

  METHOD get_selections.
    IF mo_selections IS NOT BOUND.
      GET REFERENCE OF ms_layout INTO DATA(lr_layout).

      mo_selections = NEW zcl_app_table_selections(
        ir_layout = lr_layout
        io_alv    = mo_alv
      ).
    ENDIF.

    ro_result = mo_selections.
  ENDMETHOD.

  METHOD get_layout.
    ro_result = mo_layout.
  ENDMETHOD.

  METHOD get_functions.
    ro_result = mo_functions.
  ENDMETHOD.

  METHOD factory.
    DATA lr_ref TYPE REF TO data.

    GET REFERENCE OF ct_table INTO lr_ref.

    ro_result = NEW zcl_app_alv_table(
      iv_name   = iv_container_name
      ir_output = lr_ref
      io_parent = io_parent
    ).
  ENDMETHOD.

  METHOD display.
    FIELD-SYMBOLS: <output> TYPE ANY TABLE.

    ASSIGN mr_output->* TO <output>.

    mo_alv->set_table_for_first_display(
      EXPORTING
*    i_buffer_active               =                  " Buffering Active
*    i_bypassing_buffer            =                  " Switch Off Buffer
*    i_consistency_check           =                  " Starting Consistency Check for Interface Error Recognition
*    i_structure_name              =                  " Internal Output Table Structure Name
*    is_variant                    =                  " Layout
*    i_save                        =                  " Save Layout
*    i_default                     = 'X'              " Default Display Variant
     is_layout                     = ms_layout                 " Layout
*    is_print                      =                  " Print Control
*    it_special_groups             =                  " Field Groups
*    it_toolbar_excluding          =                  " Excluded Toolbar Standard Functions
*    it_hyperlink                  =                  " Hyperlinks
*    it_alv_graphics               =                  " Table of Structure DTC_S_TC
*    it_except_qinfo               =                  " Table for Exception Quickinfo
*    ir_salv_adapter               =                  " Interface ALV Adapter
      CHANGING
        it_outtab                     = <output>
        it_fieldcatalog               = mt_fieldcat                 " Field Catalog
*    it_sort                       =                  " Sort Criteria
*    it_filter                     =                  " Filter Criteria
      EXCEPTIONS
        invalid_parameter_combination = 1                " Wrong Parameter
        program_error                 = 2                " Program Errors
        too_many_lines                = 3                " Too many Rows in Ready for Input Grid
        OTHERS                        = 4
    ).

    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    SET HANDLER handle_after_refresh FOR mo_alv.
    SET HANDLER handle_after_usercommand FOR mo_alv.
    SET HANDLER handle_before_usercommand FOR mo_alv.
    SET HANDLER handle_button_click FOR mo_alv.
    SET HANDLER handle_ctx_request FOR mo_alv.
    SET HANDLER handle_data_changed FOR mo_alv.
    SET HANDLER handle_data_changed_finish FOR mo_alv.
    SET HANDLER handle_delayed_callback FOR mo_alv.
    SET HANDLER handle_delayed_c_sel_cb FOR mo_alv.
    SET HANDLER handle_double_click FOR mo_alv.
    SET HANDLER handle_drag FOR mo_alv.
    SET HANDLER handle_drop FOR mo_alv.
    SET HANDLER handle_drop_complete FOR mo_alv.
    SET HANDLER handle_drop_ext_files FOR mo_alv.
    SET HANDLER handle_f1 FOR mo_alv.
    SET HANDLER handle_f4 FOR mo_alv.
    SET HANDLER handle_hotspot_click FOR mo_alv.
    SET HANDLER handle_menu_button FOR mo_alv.
    SET HANDLER handle_subtotal_text FOR mo_alv.
    SET HANDLER handle_toolbar FOR mo_alv.
    SET HANDLER handle_usercommand FOR mo_alv.

    mo_alv->set_toolbar_interactive( ).
  ENDMETHOD.

  METHOD refresh.
    mo_alv->set_frontend_fieldcatalog( mt_fieldcat ).
    mo_alv->set_frontend_layout( ms_layout ).

    mo_alv->refresh_table_display(
      EXPORTING
        is_stable      = is_stable
        i_soft_refresh = SWITCH #( iv_mode WHEN if_salv_c_refresh=>full THEN abap_false
                                           WHEN if_salv_c_refresh=>none THEN abap_false
                                           WHEN if_salv_c_refresh=>soft THEN abap_true )
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2
    ).

    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDMETHOD.

  METHOD constructor.
    FIELD-SYMBOLS: <output> TYPE ANY TABLE.

    mr_output = ir_output.

    mo_alv = NEW cl_gui_alv_grid(
*     i_shellstyle     = 0
*     i_lifetime       =
      i_parent         = io_parent
*     i_appl_events    = space
*     i_parentdbg      =
*     i_applogparent   =
*     i_graphicsparent =
      i_name           = iv_name
      i_fcat_complete  = abap_false
    ).

    TRY.
        ASSIGN mr_output->* TO <output>.

        cl_salv_table=>factory(
          IMPORTING
            r_salv_table   = mo_salv
          CHANGING
            t_table        = <output>
        ).

        mt_fieldcat = cl_salv_controller_metadata=>get_lvc_fieldcatalog(
                        EXPORTING
                          r_columns      = mo_salv->get_columns( )
                          r_aggregations = mo_salv->get_aggregations( )
                      ).
      CATCH cx_salv_msg.
    ENDTRY.

    mo_functions = NEW zcl_app_table_functions( ).
  ENDMETHOD.

  METHOD handle_after_refresh.

  ENDMETHOD.

  METHOD handle_after_usercommand.
    RAISE EVENT on_after_function
      EXPORTING
        iv_function = CONV #( e_ucomm ).
  ENDMETHOD.

  METHOD handle_before_usercommand.
    RAISE EVENT on_before_function
      EXPORTING
        iv_function = CONV #( e_ucomm ).
  ENDMETHOD.

  METHOD handle_button_click.
    RAISE EVENT on_link_click
      EXPORTING
        iv_row    = es_row_no-row_id
        iv_column = CONV #( es_col_id-fieldname ).
  ENDMETHOD.

  METHOD handle_ctx_request.

  ENDMETHOD.

  METHOD handle_data_changed.

  ENDMETHOD.

  METHOD handle_data_changed_finish.

  ENDMETHOD.

  METHOD handle_delayed_callback.

  ENDMETHOD.

  METHOD handle_delayed_c_sel_cb.

  ENDMETHOD.

  METHOD handle_double_click.
    RAISE EVENT on_double_click
      EXPORTING
        iv_row    = CONV #( e_row-index )
        iv_column = CONV #( e_column-fieldname ).
  ENDMETHOD.

  METHOD handle_drag.

  ENDMETHOD.

  METHOD handle_drop.

  ENDMETHOD.

  METHOD handle_drop_complete.

  ENDMETHOD.

  METHOD handle_drop_ext_files.

  ENDMETHOD.

  METHOD handle_drop_get_flavor.

  ENDMETHOD.

  METHOD handle_f1.

  ENDMETHOD.

  METHOD handle_f4.

  ENDMETHOD.

  METHOD handle_hotspot_click.
    RAISE EVENT on_link_click
      EXPORTING
        iv_row    = CONV #( e_row_id-index )
        iv_column = CONV #( e_column_id-fieldname ).
  ENDMETHOD.

  METHOD handle_menu_button.
    BREAK developer.
  ENDMETHOD.

  METHOD handle_subtotal_text.

  ENDMETHOD.

  METHOD handle_toolbar.
    BREAK developer.

    LOOP AT mo_functions->get_functions( ) REFERENCE INTO DATA(lr_function).
      IF lr_function->function->mv_visible = abap_false.
        CONTINUE.
      ENDIF.

      APPEND INITIAL LINE TO e_object->mt_toolbar REFERENCE INTO DATA(lr_toolbar).
      lr_toolbar->butn_type = cntb_btype_button.
      lr_toolbar->function  = lr_function->name.
      lr_toolbar->disabled  = SWITCH #( lr_function->function->mv_enabled WHEN abap_true THEN abap_false ELSE abap_true ).
      lr_toolbar->icon      = lr_function->function->mv_icon.
      lr_toolbar->quickinfo = lr_function->function->mv_tooltip.
      lr_toolbar->text      = lr_function->function->mv_text.
    ENDLOOP.
  ENDMETHOD.

  METHOD handle_usercommand.
    BREAK developer.
    RAISE EVENT on_added_function
      EXPORTING
        iv_function = CONV #( e_ucomm ).
  ENDMETHOD.
ENDCLASS.
