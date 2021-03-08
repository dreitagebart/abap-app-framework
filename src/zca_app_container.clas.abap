CLASS zca_app_container DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PRIVATE
  GLOBAL FRIENDS zca_app
                 zcl_app_container_splitter
                 zcl_app_container_document
                 zcl_app_container_bar
                 zcl_app_container_table
                 zcl_app_container_tree.

  PUBLIC SECTION.
    TYPES: tt_children TYPE TABLE OF REF TO zca_app_container.

    CONSTANTS: BEGIN OF mc_sides,
                 custom  TYPE i VALUE 1,
                 left    TYPE i VALUE 2,
                 top     TYPE i VALUE 3,
                 bottom  TYPE i VALUE 4,
                 right   TYPE i VALUE 5,
                 popup   TYPE i VALUE 6,
                 default TYPE i VALUE 7,
               END OF mc_sides.

    METHODS:
      constructor
        IMPORTING
          iv_name TYPE string
          iv_side TYPE i,
      register_events ABSTRACT,
      create_instance ABSTRACT,
      create_parent,
      get_parent
        RETURNING VALUE(ro_result) TYPE REF TO cl_gui_container,
      get_side
        RETURNING VALUE(rv_result) TYPE i,
      get_name
        RETURNING VALUE(rv_result) TYPE string.

  PROTECTED SECTION.
    DATA: mo_app    TYPE REF TO zca_app,
          mo_parent TYPE REF TO cl_gui_container.

  PRIVATE SECTION.
    DATA: mv_name TYPE string,
          mv_side TYPE i.

ENDCLASS.



CLASS zca_app_container IMPLEMENTATION.


  METHOD constructor.
    mv_name = iv_name.
    mv_side = iv_side.
    mo_app = zca_app=>get( ).
  ENDMETHOD.


  METHOD create_parent.
    CASE mv_side.
      WHEN mc_sides-default.
        mo_parent = cl_gui_container=>default_screen.
      WHEN mc_sides-custom.
        mo_parent = NEW cl_gui_custom_container(
*         parent                  =
          container_name          = CONV char100( mv_name )
*         style                   =
*         lifetime                = lifetime_default
*         repid                   = sy-cprog
*         dynnr                   = sy-dynnr
          no_autodef_progid_dynnr = abap_true
        ).
      WHEN mc_sides-top
        OR mc_sides-left
        OR mc_sides-right
        OR mc_sides-bottom.
        CASE mv_side.
          WHEN mc_sides-top.
            DATA(lv_dock) = cl_gui_docking_container=>dock_at_top.
          WHEN mc_sides-left.
            lv_dock = cl_gui_docking_container=>dock_at_left.
          WHEN mc_sides-right.
            lv_dock = cl_gui_docking_container=>dock_at_right.
          WHEN mc_sides-bottom.
            lv_dock = cl_gui_docking_container=>dock_at_bottom.
        ENDCASE.

        mo_parent = NEW cl_gui_docking_container(
*    parent                  =
*                      repid                   = sy-cprog
*                      dynnr                   = sy-dynnr
                      side                    = lv_dock
*                      extension               = 50
*    style                   =
*    lifetime                = lifetime_default
*    caption                 =
*    metric                  = 0
    ratio                   = 50
    no_autodef_progid_dynnr = abap_true
*                      name                    = mv_name
        ).
    ENDCASE.
  ENDMETHOD.


  METHOD get_name.
    rv_result = mv_name.
  ENDMETHOD.


  METHOD get_parent.
    ro_result = mo_parent.
  ENDMETHOD.


  METHOD get_side.
    rv_result = mv_side.
  ENDMETHOD.
ENDCLASS.
