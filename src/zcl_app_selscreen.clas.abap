CLASS zcl_app_selscreen DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
                  ir_data    TYPE REF TO data
                  iv_program TYPE syrepid
        RAISING   zcx_app,
      get_selscreen_data.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mr_selscreen TYPE REF TO data,
          mv_program   TYPE syrepid,
          mo_structure TYPE REF TO cl_abap_structdescr,
          mt_fields    TYPE TABLE OF rsparams.

    METHODS:
      refresh_from_selscreen
        RAISING zcx_app.

ENDCLASS.



CLASS zcl_app_selscreen IMPLEMENTATION.
  METHOD refresh_from_selscreen.
    CALL FUNCTION 'RS_REFRESH_FROM_SELECTOPTIONS'
      EXPORTING
        curr_report     = mv_program
      TABLES
        selection_table = mt_fields
      EXCEPTIONS
        not_found       = 1                " Program does not exist
        no_report       = 2                " Program is not type 1
        OTHERS          = 3.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_app
        MESSAGE a006.
    ENDIF.
  ENDMETHOD.

  METHOD get_selscreen_data.
    FIELD-SYMBOLS: <selopt>    TYPE STANDARD TABLE,
                   <parameter> TYPE any.

    TRY.
        refresh_from_selscreen( ).
      CATCH zcx_app.
    ENDTRY.
    BREAK developer.
    ASSIGN mr_selscreen->* TO FIELD-SYMBOL(<selscreen>).

    CLEAR <selscreen>.

    LOOP AT mt_fields REFERENCE INTO DATA(lr_field).
      CASE lr_field->kind.
        WHEN 'S'.
          ASSIGN COMPONENT lr_field->selname OF STRUCTURE <selscreen> TO <selopt>.

          APPEND INITIAL LINE TO <selopt> ASSIGNING FIELD-SYMBOL(<line>).
          ASSIGN COMPONENT 'SIGN' OF STRUCTURE <line> TO FIELD-SYMBOL(<value>).
          <value> = lr_field->sign.

          ASSIGN COMPONENT 'OPTION' OF STRUCTURE <line> TO <value>.
          <value> = lr_field->option.

          ASSIGN COMPONENT 'LOW' OF STRUCTURE <line> TO <value>.
          <value> = lr_field->low.

          ASSIGN COMPONENT 'HIGH' OF STRUCTURE <line> TO <value>.
          <value> = lr_field->high.
        WHEN 'P'.
          ASSIGN COMPONENT lr_field->selname OF STRUCTURE <selscreen> TO <parameter>.
          <parameter> = lr_field->low.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.

  METHOD constructor.
    mr_selscreen = ir_data.
    mv_program = iv_program.

    TRY.
        refresh_from_selscreen( ).
      CATCH zcx_app INTO DATA(lx_error).
        RAISE EXCEPTION lx_error.
    ENDTRY.

    DATA(lo_type) = cl_abap_structdescr=>describe_by_data_ref( ir_data ).

    CASE lo_type->kind.
      WHEN lo_type->kind_struct.
        mo_structure = CAST #( lo_type ).
      WHEN OTHERS.
        RAISE EXCEPTION TYPE zcx_app
          MESSAGE a007.
    ENDCASE.

    LOOP AT mt_fields REFERENCE INTO DATA(lr_field).
      TRY.
          DATA(lr_component) = REF #( mo_structure->components[ name = lr_field->selname ] ).

          CASE lr_field->kind.
            WHEN 'S'.
              IF lr_component->type_kind <> cl_abap_datadescr=>typekind_table.
                RAISE EXCEPTION TYPE zcx_app
                  MESSAGE a010 WITH lr_field->selname.
              ENDIF.
            WHEN 'P'.
              "do nothing
          ENDCASE.
        CATCH cx_sy_itab_line_not_found.
          RAISE EXCEPTION TYPE zcx_app
            MESSAGE a008 WITH lr_field->selname.
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
