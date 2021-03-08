*&---------------------------------------------------------------------*
*& Include zapp_gui_connector
*&---------------------------------------------------------------------*
CLASS lcl_gui_connector DEFINITION CREATE PUBLIC.
  PUBLIC SECTION.
    CONSTANTS: connection TYPE abap_bool VALUE abap_true.

    METHODS:
      constructor
        IMPORTING
          io_app TYPE REF TO zca_app,
      call_screen
        IMPORTING
          iv_screen TYPE dynnr,
      call_modal
        IMPORTING
          iv_screen TYPE dynnr
*          iv_center TYPE abap_bool DEFAULT abap_true
          iv_x      TYPE i DEFAULT 26
          iv_y      TYPE i DEFAULT 5.

  PRIVATE SECTION.
    DATA: ms_metrics TYPE cntl_metric_factors,
          mv_program TYPE syrepid.

ENDCLASS.

CLASS lcl_gui_connector IMPLEMENTATION.
  METHOD constructor.
    ms_metrics = io_app->get_screen_resolution( ).
    mv_program = io_app->get_program_name( ).
  ENDMETHOD.

  METHOD call_modal.
    "not ready yet - can someone help me with that?
*    IF iv_center = abap_true.
*      SELECT SINGLE noli, noco FROM d020s INTO @DATA(ls_screen_size)
*        WHERE prog = @mv_program
*          AND dnum = @iv_screen.
*
*      IF sy-subrc <> 0.
*        RETURN.
*      ENDIF.
*      BREAK developer.
*      DATA(lv_x) = ms_metrics-dm-x - ls_screen_size-noco / 2.
*      DATA(lv_y) = ms_metrics-dm-y - ls_screen_size-noli / 2.
*
*      lv_x = cl_gui_cfw=>compute_dynp_from_pixels(
*        x_or_y = 'X'
*        in     = ms_metrics-screen-x
*      ).
*
*      lv_y = cl_gui_cfw=>compute_dynp_from_pixels(
*        x_or_y = 'Y'
*        in     = ms_metrics-screen-y
*      ).
*
*      lv_x = lv_x - ls_screen_size-noco / 2.
*      lv_y = lv_y - ls_screen_size-noli / 2.
*
*      CALL SCREEN iv_screen
*        STARTING AT lv_x
*                    lv_y.
*
*      RETURN.
*    ENDIF.

    CALL SCREEN iv_screen
      STARTING AT iv_x
                  iv_y.
  ENDMETHOD.

  METHOD call_screen.
    CALL SCREEN iv_screen.
  ENDMETHOD.
ENDCLASS.
