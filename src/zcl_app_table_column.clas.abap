CLASS zcl_app_table_column DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    CONSTANTS: BEGIN OF mc_cell_types,
                 button           TYPE salv_de_celltype VALUE if_salv_c_cell_type=>button,
                 checkbox         TYPE salv_de_celltype VALUE if_salv_c_cell_type=>checkbox,
                 checkbox_hotspot TYPE salv_de_celltype VALUE if_salv_c_cell_type=>checkbox_hotspot,
                 dropdown         TYPE salv_de_celltype VALUE if_salv_c_cell_type=>dropdown,
                 hotspot          TYPE salv_de_celltype VALUE if_salv_c_cell_type=>hotspot,
                 link             TYPE salv_de_celltype VALUE if_salv_c_cell_type=>link,
                 text             TYPE salv_de_celltype VALUE if_salv_c_cell_type=>text,
               END OF mc_cell_types,

               BEGIN OF mc_alignment,
                 left   TYPE salv_de_alignment VALUE if_salv_c_alignment=>left,
                 center TYPE salv_de_alignment VALUE if_salv_c_alignment=>centered,
                 right  TYPE salv_de_alignment VALUE if_salv_c_alignment=>right,
               END OF mc_alignment.

    METHODS:
      constructor
        IMPORTING
          ir_column TYPE REF TO lvc_s_fcat,
      get_specific_group
        RETURNING VALUE(rv_result) TYPE lvc_spgrp,
      set_specific_group
        IMPORTING
          iv_id TYPE lvc_spgrp,
      get_cell_type
        RETURNING VALUE(rv_result) TYPE salv_de_celltype,
      get_color
        RETURNING VALUE(rs_result) TYPE lvc_s_colo,
      get_f4_checktable
        RETURNING VALUE(rv_result) TYPE tabname,
      get_text_column
        RETURNING VALUE(rv_result) TYPE lvc_fname,
      has_f4
        RETURNING VALUE(rv_result) TYPE abap_bool,
      is_active_for_rep_interface
        RETURNING VALUE(rv_result) TYPE abap_bool,
      is_icon
        RETURNING VALUE(rv_result) TYPE abap_bool,
      is_key
        RETURNING VALUE(rv_result) TYPE abap_bool,
      is_key_presence_required
        RETURNING VALUE(rv_result) TYPE abap_bool,
      is_symbol
        RETURNING VALUE(rv_result) TYPE abap_bool,
      set_active_for_rep_interface
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      set_cell_type
        IMPORTING
          iv_value TYPE salv_de_celltype DEFAULT mc_cell_types-text,
      set_color
        IMPORTING
          is_value TYPE lvc_s_colo,
      set_dropdown_entry
        IMPORTING
          iv_value TYPE salv_de_constant,
      set_hyperlink_entry
        IMPORTING
          iv_value TYPE salv_de_constant,
      set_f4
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      set_f4_checktable
        IMPORTING
          iv_value TYPE tabname,
      set_icon
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      set_key
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      set_key_presence_required
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      set_symbol
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      set_text_column
        IMPORTING
          iv_value TYPE lvc_fname
        RAISING
          cx_salv_not_found
          cx_salv_data_error,
      set_fixed_header_text
        IMPORTING
          iv_value TYPE lvc_ddict,
      set_leading_spaces
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      has_leading_spaces
        RETURNING VALUE(rv_result) TYPE abap_bool,
      get_alignment
        RETURNING VALUE(rv_result) TYPE salv_de_alignment,
      get_columnname
        RETURNING VALUE(rv_result) TYPE string,
      get_currency
        RETURNING VALUE(rv_result) TYPE lvc_curr,
      get_currency_column
        RETURNING VALUE(rv_result) TYPE string,
      get_ddic_datatype
        RETURNING VALUE(rv_result) TYPE datatype_d,
      get_ddic_decimals
        RETURNING VALUE(rv_result) TYPE int4,
      get_ddic_domain
        RETURNING VALUE(rv_result) TYPE domname,
      get_ddic_intlen
        RETURNING VALUE(rv_result) TYPE decimals,
      get_ddic_inttype
        RETURNING VALUE(rv_result) TYPE inttype,
      get_ddic_outputlen
        RETURNING VALUE(rv_result) TYPE outputlen,
      get_ddic_reference
        RETURNING VALUE(rs_result) TYPE salv_s_ddic_reference,
      get_ddic_rollname
        RETURNING VALUE(rv_result) TYPE rollname,
      get_decimals_column
        RETURNING VALUE(rv_result) TYPE lvc_dfname,
      get_decimals
        RETURNING VALUE(rv_result) TYPE lvc_decmls,
      get_edit_mask
        RETURNING VALUE(rv_result) TYPE lvc_edtmsk,
      get_f1_rollname
        RETURNING VALUE(rv_result) TYPE lvc_roll,
      get_long_text
        RETURNING VALUE(rv_result) TYPE scrtext_l,
      get_medium_text
        RETURNING VALUE(rv_result) TYPE scrtext_m,
      get_output_length
        RETURNING VALUE(rv_result) TYPE lvc_outlen,
      get_quantity
        RETURNING VALUE(rv_result) TYPE lvc_quan,
      get_quantity_column
        RETURNING VALUE(rv_result) TYPE lvc_qfname,
      get_round
        RETURNING VALUE(rv_result) TYPE lvc_round,
      get_round_column
        RETURNING VALUE(rv_result) TYPE lvc_rndfn,
      get_row
        RETURNING VALUE(rv_result) TYPE lvc_colpos,
      get_short_text
        RETURNING VALUE(rv_result) TYPE scrtext_s,
      get_tooltip
        RETURNING VALUE(rv_result) TYPE lvc_tip,
      has_leading_zero
        RETURNING VALUE(rv_result) TYPE abap_bool,
      has_sign
        RETURNING VALUE(rv_result) TYPE abap_bool,
      is_lowercase
        RETURNING VALUE(rv_result) TYPE abap_bool,
      is_optimized
        RETURNING VALUE(rv_result) TYPE abap_bool,
      is_technical
        RETURNING VALUE(rv_result) TYPE abap_bool,
      is_visible
        RETURNING VALUE(rv_result) TYPE abap_bool,
      is_zero
        RETURNING VALUE(rv_result) TYPE abap_bool,
      set_alignment
        IMPORTING
          iv_value TYPE salv_de_alignment DEFAULT mc_alignment-left,
      set_editable
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      set_currency
        IMPORTING
          iv_value TYPE lvc_curr,
      set_currency_column
        IMPORTING
          iv_value TYPE lvc_cfname
        RAISING
          cx_salv_not_found
          cx_salv_data_error,
      set_ddic_reference
        IMPORTING
          is_value TYPE salv_s_ddic_reference,
      set_decimals_column
        IMPORTING
          iv_value TYPE lvc_dfname
        RAISING
          cx_salv_not_found
          cx_salv_data_error,
      set_decimals
        IMPORTING
          iv_value TYPE lvc_decmls,
      set_edit_mask
        IMPORTING
          iv_value TYPE lvc_edtmsk,
      set_f1_rollname
        IMPORTING
          iv_value TYPE lvc_roll,
      set_leading_zero
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      set_long_text
        IMPORTING
          iv_value TYPE scrtext_l,
      set_lowercase
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      set_medium_text
        IMPORTING
          iv_value TYPE scrtext_m,
      set_optimized
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      set_output_length
        IMPORTING
          iv_value TYPE lvc_outlen,
      set_quantity
        IMPORTING
          iv_value TYPE lvc_quan,
      set_quantity_column
        IMPORTING
          iv_value TYPE lvc_qfname
        RAISING
          cx_salv_not_found
          cx_salv_data_error,
      set_round
        IMPORTING
          iv_value TYPE lvc_round,
      set_round_column
        IMPORTING
          iv_value TYPE lvc_rndfn
        RAISING
          cx_salv_not_found
          cx_salv_data_error,
      set_row
        IMPORTING
          iv_value TYPE lvc_rowpos,
      set_short_text
        IMPORTING
          iv_value TYPE scrtext_s,
      set_sign
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      set_technical
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      set_tooltip
        IMPORTING
          iv_value TYPE lvc_tip,
      set_visible
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      set_zero
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      set_decfloat_style
        IMPORTING
          iv_value TYPE outputstyle,
      get_decfloat_style
        RETURNING VALUE(rv_result) TYPE lvc_rowpos.


  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mr_column TYPE REF TO lvc_s_fcat.

ENDCLASS.



CLASS zcl_app_table_column IMPLEMENTATION.
  METHOD constructor.
    mr_column = ir_column.
*    mo_column = io_column.
  ENDMETHOD.

  METHOD get_alignment.
    rv_result = mr_column->just.

*    rv_result = mo_column->get_alignment( ).
  ENDMETHOD.

  METHOD get_cell_type.


*    rv_result = mo_column->get_cell_type( ).
  ENDMETHOD.

  METHOD get_color.
*    rs_result = mo_column->get_color( ).
  ENDMETHOD.

  METHOD get_columnname.
    rv_result = mr_column->fieldname.

*    rv_result = mo_column->get_columnname( ).
  ENDMETHOD.

  METHOD get_currency.
    rv_result = mr_column->currency.

*    rv_result = mo_column->get_currency( ).
  ENDMETHOD.

  METHOD get_currency_column.
    rv_result = mr_column->cfieldname.
*    rv_result = mo_column->get_currency_column( ).
  ENDMETHOD.

  METHOD get_ddic_datatype.
    rv_result = mr_column->datatype.
*    rv_result = mo_column->get_ddic_datatype( ).
  ENDMETHOD.

  METHOD get_ddic_decimals.

*    rv_result = mo_column->get_ddic_decimals( ).
  ENDMETHOD.

  METHOD get_ddic_domain.
    rv_result = mr_column->domname.
*    rv_result = mo_column->get_ddic_domain( ).
  ENDMETHOD.

  METHOD get_ddic_intlen.
    rv_result = mr_column->intlen.
*    rv_result = mo_column->get_ddic_intlen( ).
  ENDMETHOD.

  METHOD get_ddic_inttype.
    rv_result = mr_column->inttype.
*    rv_result = mo_column->get_ddic_inttype( ).
  ENDMETHOD.

  METHOD get_ddic_outputlen.
    rv_result = mr_column->dd_outlen.
*    rv_result = mo_column->get_ddic_outputlen( ).
  ENDMETHOD.

  METHOD get_ddic_reference.
    rs_result-field = mr_column->ref_field.
    rs_result-table = mr_column->ref_table.
*    rs_result = mo_column->get_ddic_reference( ).
  ENDMETHOD.

  METHOD get_ddic_rollname.
    rv_result = mr_column->dd_roll.
*    rv_result = mo_column->get_ddic_rollname( ).
  ENDMETHOD.

  METHOD get_decfloat_style.
    rv_result = mr_column->decfloat_style.
*    rv_result = mo_column->get_decfloat_style( ).
  ENDMETHOD.

  METHOD get_decimals.
    rv_result = mr_column->decimals.
*    rv_result = mo_column->get_decimals( ).
  ENDMETHOD.

  METHOD get_decimals_column.
    rv_result = mr_column->decmlfield.
*    rv_result = get_decimals_column( ).
  ENDMETHOD.

  METHOD get_edit_mask.
    rv_result = mr_column->edit_mask.
*    rv_result = mo_column->get_edit_mask( ).
  ENDMETHOD.

  METHOD get_f1_rollname.
    rv_result = mr_column->rollname.
*    rv_result = mo_column->get_f1_rollname( ).
  ENDMETHOD.

  METHOD get_f4_checktable.
    rv_result = mr_column->checktable.
*    rv_result = mo_column->get_f4_checktable( ).
  ENDMETHOD.

  METHOD get_long_text.
    rv_result = mr_column->scrtext_l.
*    rv_result = mo_column->get_long_text( ).
  ENDMETHOD.

  METHOD get_medium_text.
    rv_result = mr_column->scrtext_m.
*    rv_result = mo_column->get_medium_text( ).
  ENDMETHOD.

  METHOD get_output_length.
    rv_result = mr_column->outputlen.
*    rv_result = mo_column->get_output_length( ).
  ENDMETHOD.

  METHOD get_quantity.
    rv_result = mr_column->quantity.
*    rv_result = mo_column->get_quantity( ).
  ENDMETHOD.

  METHOD get_quantity_column.
    rv_result = mr_column->qfieldname.
*    rv_result = mo_column->get_quantity_column( ).
  ENDMETHOD.

  METHOD get_round.
    rv_result = mr_column->round.
*    rv_result = mo_column->get_round( ).
  ENDMETHOD.

  METHOD get_round_column.
    rv_result = mr_column->roundfield.
*    rv_result = mo_column->get_round_column( ).
  ENDMETHOD.

  METHOD get_row.
    rv_result = mr_column->row_pos.
*    rv_result = mo_column->get_row( ).
  ENDMETHOD.

  METHOD get_short_text.
    rv_result = mr_column->scrtext_s.
*    rv_result = mo_column->get_short_text( ).
  ENDMETHOD.

  METHOD get_specific_group.
    rv_result = mr_column->sp_group.
*    rv_result = mo_column->get_specific_group( ).
  ENDMETHOD.

  METHOD get_text_column.
    rv_result = mr_column->txt_field.
*    rv_result = mo_column->get_text_column( ).
  ENDMETHOD.

  METHOD get_tooltip.
    rv_result = mr_column->tooltip.
*    rv_result = mo_column->get_tooltip( ).
  ENDMETHOD.

  METHOD has_f4.
    rv_result = mr_column->f4availabl.
*    rv_result = mo_column->has_f4( ).
  ENDMETHOD.

  METHOD has_leading_spaces.
    rv_result = mr_column->lzero.
*    rv_result = mo_column->has_leading_spaces( ).
  ENDMETHOD.

  METHOD has_leading_zero.
    rv_result = SWITCH #( mr_column->no_zero WHEN abap_true  THEN abap_false
                                             WHEN abap_false THEN abap_true ).
*    rv_result = mo_column->has_leading_zero( ).
  ENDMETHOD.

  METHOD has_sign.
    rv_result = SWITCH #( mr_column->no_sign WHEN abap_true  THEN abap_false
                                             WHEN abap_false THEN abap_true ).
*    rv_result = mo_column->has_sign( ).
  ENDMETHOD.

  METHOD is_active_for_rep_interface.
    rv_result = mr_column->reprep.
*    rv_result = mo_column->is_active_for_rep_interface( ).
  ENDMETHOD.

  METHOD is_icon.
    rv_result = mr_column->icon.
*    rv_result = mo_column->is_icon( ).
  ENDMETHOD.

  METHOD is_key.
    rv_result = mr_column->key.
*    rv_result = mo_column->is_key( ).
  ENDMETHOD.

  METHOD is_key_presence_required.
    rv_result = mr_column->fix_column.
*    rv_result = mo_column->is_key_presence_required( ).
  ENDMETHOD.

  METHOD is_lowercase.
    rv_result = mr_column->lowercase.
*    rv_result = mo_column->is_lowercase( ).
  ENDMETHOD.

  METHOD is_optimized.
    rv_result = mr_column->col_opt.
*    rv_result = mo_column->is_optimized( ).
  ENDMETHOD.

  METHOD is_symbol.
    rv_result = mr_column->symbol.
*    rv_result = mo_column->is_symbol( ).
  ENDMETHOD.

  METHOD is_technical.
    rv_result = mr_column->tech.
*    rv_result = mo_column->is_technical( ).
  ENDMETHOD.

  METHOD is_visible.
    rv_result = SWITCH #( mr_column->no_out WHEN abap_true  THEN abap_false
                                            WHEN abap_false THEN abap_true ).
*    rv_result = mo_column->is_visible( ).
  ENDMETHOD.

  METHOD is_zero.
    rv_result = mr_column->no_zero.
*    rv_result = mo_column->is_zero( ).
  ENDMETHOD.

  METHOD set_active_for_rep_interface.
    mr_column->reprep = iv_value.
*    mo_column->set_active_for_rep_interface( iv_value ).
  ENDMETHOD.

  METHOD set_alignment.
    mr_column->just = SWITCH #( iv_value WHEN if_salv_c_alignment=>centered THEN 'C'
                                         WHEN if_salv_c_alignment=>left     THEN 'L'
                                         WHEN if_salv_c_alignment=>right    THEN 'R' ).
*    mo_column->set_alignment( iv_value ).
  ENDMETHOD.

  METHOD set_cell_type.
    BREAK developer.
    CASE iv_value.
      WHEN if_salv_c_cell_type=>button.
      WHEN if_salv_c_cell_type=>checkbox.
        mr_column->checkbox = abap_true.
      WHEN if_salv_c_cell_type=>text.
        CLEAR mr_column->hotspot.
      WHEN if_salv_c_cell_type=>link.
        mr_column->hotspot = abap_true.
      WHEN if_salv_c_cell_type=>dropdown.
    ENDCASE.

*    mo_column->set_cell_type( iv_value ).
  ENDMETHOD.

  METHOD set_color.
    DATA lv_color TYPE lvc_emphsz.

    lv_color = |C{ is_value-col }{ is_value-int }{ is_value-inv }|.

    mr_column->emphasize = lv_color.

*    mo_column->set_color( is_value ).
  ENDMETHOD.

  METHOD set_editable.
    mr_column->edit = iv_value.
  ENDMETHOD.

  METHOD set_currency.
    mr_column->currency = iv_value.
*    mo_column->set_currency( iv_value ).
  ENDMETHOD.

  METHOD set_currency_column.
    mr_column->cfieldname = iv_value.
*    TRY.
*        mo_column->set_currency_column( iv_value ).
*      CATCH cx_salv_not_found INTO DATA(lx_not_found).
*        RAISE EXCEPTION lx_not_found.
*      CATCH cx_salv_data_error INTO DATA(lx_error).
*        RAISE EXCEPTION lx_error.
*    ENDTRY.
  ENDMETHOD.

  METHOD set_ddic_reference.
    mr_column->ref_field = is_value-field.
    mr_column->ref_table = is_value-table.

*    mo_column->set_ddic_reference( is_value ).
  ENDMETHOD.

  METHOD set_decfloat_style.
    mr_column->decfloat_style = iv_value.
*    mo_column->set_decfloat_style( iv_value ).
  ENDMETHOD.

  METHOD set_decimals.
    mr_column->decimals = iv_value.
*    mo_column->set_decimals( iv_value ).
  ENDMETHOD.

  METHOD set_decimals_column.
    mr_column->decmlfield = iv_value.
*    TRY.
*        mo_column->set_decimals_column( iv_value ).
*      CATCH cx_salv_not_found INTO DATA(lx_not_found).
*        RAISE EXCEPTION lx_not_found.
*      CATCH cx_salv_data_error INTO DATA(lx_error).
*        RAISE EXCEPTION lx_error.
*    ENDTRY.
  ENDMETHOD.

  METHOD set_dropdown_entry.
*  mr_column->
*    mo_column->set_dropdown_entry( iv_value ).
  ENDMETHOD.

  METHOD set_edit_mask.
    mr_column->edit_mask = iv_value.
*    mo_column->set_edit_mask( iv_value ).
  ENDMETHOD.

  METHOD set_f1_rollname.
    mr_column->rollname = iv_value.
*    mo_column->set_f1_rollname( iv_value ).
  ENDMETHOD.

  METHOD set_f4.
    mr_column->f4availabl = iv_value.
*    mo_column->set_f4( iv_value ).
  ENDMETHOD.

  METHOD set_f4_checktable.
    mr_column->checktable = iv_value.
*    mo_column->set_f4_checktable( iv_value ).
  ENDMETHOD.

  METHOD set_fixed_header_text.

*    mo_column->set_fixed_header_text( iv_value ).
  ENDMETHOD.

  METHOD set_hyperlink_entry.

*    mo_column->set_hyperlink_entry( iv_value ).
  ENDMETHOD.

  METHOD set_icon.
    mr_column->icon = iv_value.
*    mo_column->set_icon( iv_value ).
  ENDMETHOD.

  METHOD set_key.
    mr_column->key = iv_value.
*    mo_column->set_key( iv_value ).
  ENDMETHOD.

  METHOD set_key_presence_required.
    mr_column->fix_column = iv_value.
*    mo_column->set_key_presence_required( iv_value ).
  ENDMETHOD.

  METHOD set_leading_spaces.
    mr_column->no_zero = iv_value.
*    mo_column->set_leading_spaces( iv_value ).
  ENDMETHOD.

  METHOD set_leading_zero.
    mr_column->lzero = iv_value.
*    mo_column->set_leading_zero( iv_value ).
  ENDMETHOD.

  METHOD set_long_text.
    mr_column->scrtext_l = iv_value.
*    mo_column->set_long_text( iv_value ).
  ENDMETHOD.

  METHOD set_lowercase.
    mr_column->lowercase = iv_value.
*    mo_column->set_lowercase( iv_value ).
  ENDMETHOD.

  METHOD set_medium_text.
    mr_column->scrtext_m = iv_value.
*    mo_column->set_medium_text( iv_value ).
  ENDMETHOD.

  METHOD set_optimized.
    mr_column->col_opt = iv_value.
*    mo_column->set_optimized( iv_value ).
  ENDMETHOD.

  METHOD set_output_length.
    mr_column->outputlen = iv_value.
*    mo_column->set_output_length( iv_value ).
  ENDMETHOD.

  METHOD set_quantity.
    mr_column->quantity = iv_value.
*    mo_column->set_quantity( iv_value ).
  ENDMETHOD.

  METHOD set_quantity_column.
    mr_column->qfieldname = iv_value.
*    mo_column->set_quantity_column( iv_value ).
  ENDMETHOD.

  METHOD set_round.
    mr_column->round = iv_value.
*    mo_column->set_round( iv_value ).
  ENDMETHOD.

  METHOD set_round_column.
    mr_column->roundfield = iv_value.
*    mo_column->set_round_column( iv_value ).
  ENDMETHOD.

  METHOD set_row.
    mr_column->row_pos = iv_value.
*    mo_column->set_row( iv_value ).
  ENDMETHOD.

  METHOD set_short_text.
    mr_column->scrtext_s = iv_value.
*    mo_column->set_short_text( iv_value ).
  ENDMETHOD.

  METHOD set_sign.
    mr_column->no_sign = SWITCH #( iv_value WHEN abap_true  THEN abap_false
                                            WHEN abap_false THEN abap_true ).
*    mo_column->set_sign( iv_value ).
  ENDMETHOD.

  METHOD set_specific_group.
    mr_column->sp_group = iv_id.
*    mo_column->set_specific_group( iv_id ).
  ENDMETHOD.

  METHOD set_symbol.
    mr_column->symbol = iv_value.
*    mo_column->set_symbol( iv_value ).
  ENDMETHOD.

  METHOD set_technical.
    mr_column->tech = iv_value.
*    mo_column->set_technical( iv_value ).
  ENDMETHOD.

  METHOD set_text_column.
    mr_column->txt_field = iv_value.
*    mo_column->set_text_column( iv_value ).
  ENDMETHOD.

  METHOD set_tooltip.
    mr_column->tooltip = iv_value.
*    mo_column->set_tooltip( iv_value ).
  ENDMETHOD.

  METHOD set_visible.
    mr_column->no_out = SWITCH #( iv_value WHEN abap_true  THEN abap_false
                                           WHEN abap_false THEN abap_true ).
*    mo_column->set_visible( iv_value ).
  ENDMETHOD.

  METHOD set_zero.
    mr_column->no_zero = SWITCH #( iv_value WHEN abap_true  THEN abap_false
                                            WHEN abap_false THEN abap_true ).
*    mo_column->set_zero( iv_value ).
  ENDMETHOD.
ENDCLASS.
