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
    ro_result = mo_settings.
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
  ENDMETHOD.
ENDCLASS.
