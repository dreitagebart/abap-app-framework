CLASS zcl_app_output DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          io_app TYPE REF TO zcl_app_report.

  PROTECTED SECTION.

  PRIVATE SECTION.
    CONSTANTS: BEGIN OF mc_container,
                 splitter         TYPE string VALUE 'SPLITTER',
                 footer_container TYPE string VALUE 'FOOTER',
                 output           TYPE string VALUE 'OUTPUT',
                 BEGIN OF footer,
                   left   TYPE string VALUE 'LEFT',
                   middle TYPE string VALUE 'MIDDLE',
                   right  TYPE string VALUE 'RIGHT',
                 END OF footer,
               END OF mc_container.

    DATA: mo_app TYPE REF TO zcl_app_report,
          mo_alv TYPE REF TO zcl_app_alv_table.

    METHODS:
      create.

ENDCLASS.



CLASS zcl_app_output IMPLEMENTATION.
  METHOD constructor.
    mo_app = io_app.

    create( ).
  ENDMETHOD.

  METHOD create.
    FIELD-SYMBOLS: <output> TYPE ANY TABLE.

    ASSIGN mo_app->mr_output->* TO <output>.

    DATA(lo_splitter) = zcl_app_container_splitter=>create(
                          iv_name       = mc_container-splitter
                          iv_side       = zca_app_container=>mc_sides-default
                          iv_split_mode = zcl_app_container_splitter=>mc_split_modes-vertical
                        ).

    DATA(lo_output) = zcl_app_container_table=>create(
                        EXPORTING
                          iv_name  = mc_container-output
                        CHANGING
                          ct_table = <output>
                      ).

    DATA(lo_footer) = zcl_app_container_splitter=>create(
                        iv_name       = mc_container-footer_container
                        iv_split_mode = zcl_app_container_splitter=>mc_split_modes-horizontal
                      ).

    BREAK developer.
    lo_splitter->set_size(
      iv_name = mc_container-footer_container
      iv_size = 5
    ).

    lo_splitter->add_container( lo_output ).
    lo_splitter->add_container( lo_footer ).

    DATA(lo_left) = zcl_app_container_document=>create( mc_container-footer-left ).
    DATA(lo_middle) = zcl_app_container_document=>create( mc_container-footer-middle ).
    DATA(lo_right) = zcl_app_container_document=>create( mc_container-footer-right ).

    lo_footer->add_container( lo_left ).
    lo_footer->add_container( lo_middle ).
    lo_footer->add_container( lo_right ).

    mo_app->add_container( lo_splitter ).
  ENDMETHOD.
ENDCLASS.
