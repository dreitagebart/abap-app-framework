CLASS zca_app_container DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC
  GLOBAL FRIENDS zca_app
                 zcl_app_container_bar
                 zcl_app_container_table
                 zcl_app_container_tree.

  PUBLIC SECTION.
    TYPES: tt_children TYPE TABLE OF REF TO zca_app_container.

    CONSTANTS: BEGIN OF mc_sides,
                 custom TYPE i VALUE 1,
                 left   TYPE i VALUE 2,
                 top    TYPE i VALUE 3,
                 bottom TYPE i VALUE 4,
                 right  TYPE i VALUE 5,
                 popup  TYPE i VALUE 6,
               END OF mc_sides.

    METHODS:
      constructor
        IMPORTING
          iv_name TYPE string
          iv_side TYPE i,
      create_parent,
      create ABSTRACT,
      get_parent
        RETURNING VALUE(ro_result) TYPE REF TO cl_gui_container,
      get_side
        RETURNING VALUE(rv_result) TYPE i,
      get_name
        RETURNING VALUE(rv_result) TYPE string.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mv_name   TYPE string,
          mv_side   TYPE i,
          mo_parent TYPE REF TO cl_gui_container.

ENDCLASS.



CLASS zca_app_container IMPLEMENTATION.
  METHOD get_parent.
    ro_result = mo_parent.
  ENDMETHOD.

  METHOD create_parent.
    CASE mv_side.
      WHEN mc_sides-custom.
        mo_parent = NEW cl_gui_custom_container(
*  parent                  =
          container_name          = CONV char100( mv_name )
*  style                   =
*  lifetime                = lifetime_default
*  repid                   =
*  dynnr                   =
*  no_autodef_progid_dynnr =
        ).
      WHEN mc_sides-top
        OR mc_sides-left
        OR mc_sides-right
        OR mc_sides-bottom.
        mo_parent = NEW cl_gui_docking_container(
*    parent                  =
*    repid                   =
*    dynnr                   =
*    side                    = dock_at_left
*    extension               = 50
*    style                   =
*    lifetime                = lifetime_default
*    caption                 =
*    metric                  = 0
*    ratio                   =
*    no_autodef_progid_dynnr =
*    name                    =
        ).
    ENDCASE.
  ENDMETHOD.

  METHOD constructor.
    mv_name = iv_name.
    mv_side = iv_side.
  ENDMETHOD.

  METHOD get_side.
    rv_result = mv_side.
  ENDMETHOD.

  METHOD get_name.
    rv_result = mv_name.
  ENDMETHOD.
ENDCLASS.
