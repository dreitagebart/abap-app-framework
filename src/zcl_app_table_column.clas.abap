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
          io_column TYPE REF TO cl_salv_column_table,
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
    DATA: mo_column TYPE REF TO cl_salv_column_table.

ENDCLASS.



CLASS zcl_app_table_column IMPLEMENTATION.
  METHOD constructor.
    mo_column = io_column.
  ENDMETHOD.

  METHOD get_alignment.
    rv_result = mo_column->get_alignment( ).
  ENDMETHOD.

  METHOD get_cell_type.
    rv_result = mo_column->get_cell_type( ).
  ENDMETHOD.

  METHOD get_color.
    rs_result = mo_column->get_color( ).
  ENDMETHOD.

  METHOD get_columnname.
    rv_result = mo_column->get_columnname( ).
  ENDMETHOD.

  METHOD get_currency.
    rv_result = mo_column->get_currency( ).
  ENDMETHOD.

  METHOD get_currency_column.
    rv_result = mo_column->get_currency_column( ).
  ENDMETHOD.

  METHOD get_ddic_datatype.
    rv_result = mo_column->get_ddic_datatype( ).
  ENDMETHOD.

  METHOD get_ddic_decimals.
    rv_result = mo_column->get_ddic_decimals( ).
  ENDMETHOD.

  METHOD get_ddic_domain.
    rv_result = mo_column->get_ddic_domain( ).
  ENDMETHOD.

  METHOD get_ddic_intlen.
    rv_result = mo_column->get_ddic_intlen( ).
  ENDMETHOD.

  METHOD get_ddic_inttype.
    rv_result = mo_column->get_ddic_inttype( ).
  ENDMETHOD.

  METHOD get_ddic_outputlen.
    rv_result = mo_column->get_ddic_outputlen( ).
  ENDMETHOD.

  METHOD get_ddic_reference.
    rs_result = mo_column->get_ddic_reference( ).
  ENDMETHOD.

  METHOD get_ddic_rollname.
    rv_result = mo_column->get_ddic_rollname( ).
  ENDMETHOD.

  METHOD get_decfloat_style.
    rv_result = mo_column->get_decfloat_style( ).
  ENDMETHOD.

  METHOD get_decimals.
    rv_result = mo_column->get_decimals( ).
  ENDMETHOD.

  METHOD get_decimals_column.
    rv_result = get_decimals_column( ).
  ENDMETHOD.

  METHOD get_edit_mask.
    rv_result = mo_column->get_edit_mask( ).
  ENDMETHOD.

  METHOD get_f1_rollname.
    rv_result = mo_column->get_f1_rollname( ).
  ENDMETHOD.

  METHOD get_f4_checktable.
    rv_result = mo_column->get_f4_checktable( ).
  ENDMETHOD.

  METHOD get_long_text.
    rv_result = mo_column->get_long_text( ).
  ENDMETHOD.

  METHOD get_medium_text.
    rv_result = mo_column->get_medium_text( ).
  ENDMETHOD.

  METHOD get_output_length.
    rv_result = mo_column->get_output_length( ).
  ENDMETHOD.

  METHOD get_quantity.
    rv_result = mo_column->get_quantity( ).
  ENDMETHOD.

  METHOD get_quantity_column.
    rv_result = mo_column->get_quantity_column( ).
  ENDMETHOD.

  METHOD get_round.
    rv_result = mo_column->get_round( ).
  ENDMETHOD.

  METHOD get_round_column.
    rv_result = mo_column->get_round_column( ).
  ENDMETHOD.

  METHOD get_row.
    rv_result = mo_column->get_row( ).
  ENDMETHOD.

  METHOD get_short_text.
    rv_result = mo_column->get_short_text( ).
  ENDMETHOD.

  METHOD get_specific_group.
    rv_result = mo_column->get_specific_group( ).
  ENDMETHOD.

  METHOD get_text_column.
    rv_result = mo_column->get_text_column( ).
  ENDMETHOD.

  METHOD get_tooltip.
    rv_result = mo_column->get_tooltip( ).
  ENDMETHOD.

  METHOD has_f4.
    rv_result = mo_column->has_f4( ).
  ENDMETHOD.

  METHOD has_leading_spaces.
    rv_result = mo_column->has_leading_spaces( ).
  ENDMETHOD.

  METHOD has_leading_zero.
    rv_result = mo_column->has_leading_zero( ).
  ENDMETHOD.

  METHOD has_sign.
    rv_result = mo_column->has_sign( ).
  ENDMETHOD.

  METHOD is_active_for_rep_interface.
    rv_result = mo_column->is_active_for_rep_interface( ).
  ENDMETHOD.

  METHOD is_icon.
    rv_result = mo_column->is_icon( ).
  ENDMETHOD.

  METHOD is_key.
    rv_result = mo_column->is_key( ).
  ENDMETHOD.

  METHOD is_key_presence_required.
    rv_result = mo_column->is_key_presence_required( ).
  ENDMETHOD.

  METHOD is_lowercase.
    rv_result = mo_column->is_lowercase( ).
  ENDMETHOD.

  METHOD is_optimized.
    rv_result = mo_column->is_optimized( ).
  ENDMETHOD.

  METHOD is_symbol.
    rv_result = mo_column->is_symbol( ).
  ENDMETHOD.

  METHOD is_technical.
    rv_result = mo_column->is_technical( ).
  ENDMETHOD.

  METHOD is_visible.
    rv_result = mo_column->is_visible( ).
  ENDMETHOD.

  METHOD is_zero.
    rv_result = mo_column->is_zero( ).
  ENDMETHOD.

  METHOD set_active_for_rep_interface.
    mo_column->set_active_for_rep_interface( iv_value ).
  ENDMETHOD.

  METHOD set_alignment.
    mo_column->set_alignment( iv_value ).
  ENDMETHOD.

  METHOD set_cell_type.
    mo_column->set_cell_type( iv_value ).
  ENDMETHOD.

  METHOD set_color.
    mo_column->set_color( is_value ).
  ENDMETHOD.

  METHOD set_currency.
    mo_column->set_currency( iv_value ).
  ENDMETHOD.

  METHOD set_currency_column.
    TRY.
        mo_column->set_currency_column( iv_value ).
      CATCH cx_salv_not_found INTO DATA(lx_not_found).
        RAISE EXCEPTION lx_not_found.
      CATCH cx_salv_data_error INTO DATA(lx_error).
        RAISE EXCEPTION lx_error.
    ENDTRY.
  ENDMETHOD.

  METHOD set_ddic_reference.
    mo_column->set_ddic_reference( is_value ).
  ENDMETHOD.

  METHOD set_decfloat_style.
    mo_column->set_decfloat_style( iv_value ).
  ENDMETHOD.

  METHOD set_decimals.
    mo_column->set_decimals( iv_value ).
  ENDMETHOD.

  METHOD set_decimals_column.
    TRY.
        mo_column->set_decimals_column( iv_value ).
      CATCH cx_salv_not_found INTO DATA(lx_not_found).
        RAISE EXCEPTION lx_not_found.
      CATCH cx_salv_data_error INTO DATA(lx_error).
        RAISE EXCEPTION lx_error.
    ENDTRY.
  ENDMETHOD.

  METHOD set_dropdown_entry.
    mo_column->set_dropdown_entry( iv_value ).
  ENDMETHOD.

  METHOD set_edit_mask.
    mo_column->set_edit_mask( iv_value ).
  ENDMETHOD.

  METHOD set_f1_rollname.
    mo_column->set_f1_rollname( iv_value ).
  ENDMETHOD.

  METHOD set_f4.
    mo_column->set_f4( iv_value ).
  ENDMETHOD.

  METHOD set_f4_checktable.
    mo_column->set_f4_checktable( iv_value ).
  ENDMETHOD.

  METHOD set_fixed_header_text.
    mo_column->set_fixed_header_text( iv_value ).
  ENDMETHOD.

  METHOD set_hyperlink_entry.
    mo_column->set_hyperlink_entry( iv_value ).
  ENDMETHOD.

  METHOD set_icon.
    mo_column->set_icon( iv_value ).
  ENDMETHOD.

  METHOD set_key.
    mo_column->set_key( iv_value ).
  ENDMETHOD.

  METHOD set_key_presence_required.
    mo_column->set_key_presence_required( iv_value ).
  ENDMETHOD.

  METHOD set_leading_spaces.
    mo_column->set_leading_spaces( iv_value ).
  ENDMETHOD.

  METHOD set_leading_zero.
    mo_column->set_leading_zero( iv_value ).
  ENDMETHOD.

  METHOD set_long_text.
    mo_column->set_long_text( iv_value ).
  ENDMETHOD.

  METHOD set_lowercase.
    mo_column->set_lowercase( iv_value ).
  ENDMETHOD.

  METHOD set_medium_text.
    mo_column->set_medium_text( iv_value ).
  ENDMETHOD.

  METHOD set_optimized.
    mo_column->set_optimized( iv_value ).
  ENDMETHOD.

  METHOD set_output_length.
    mo_column->set_output_length( iv_value ).
  ENDMETHOD.

  METHOD set_quantity.
    mo_column->set_quantity( iv_value ).
  ENDMETHOD.

  METHOD set_quantity_column.
    mo_column->set_quantity_column( iv_value ).
  ENDMETHOD.

  METHOD set_round.
    mo_column->set_round( iv_value ).
  ENDMETHOD.

  METHOD set_round_column.
    mo_column->set_round_column( iv_value ).
  ENDMETHOD.

  METHOD set_row.
    mo_column->set_row( iv_value ).
  ENDMETHOD.

  METHOD set_short_text.
    mo_column->set_short_text( iv_value ).
  ENDMETHOD.

  METHOD set_sign.
    mo_column->set_sign( iv_value ).
  ENDMETHOD.

  METHOD set_specific_group.
    mo_column->set_specific_group( iv_id ).
  ENDMETHOD.

  METHOD set_symbol.
    mo_column->set_symbol( iv_value ).
  ENDMETHOD.

  METHOD set_technical.
    mo_column->set_technical( iv_value ).
  ENDMETHOD.

  METHOD set_text_column.
    mo_column->set_text_column( iv_value ).
  ENDMETHOD.

  METHOD set_tooltip.
    mo_column->set_tooltip( iv_value ).
  ENDMETHOD.

  METHOD set_visible.
    mo_column->set_visible( iv_value ).
  ENDMETHOD.

  METHOD set_zero.
    mo_column->set_zero( iv_value ).
  ENDMETHOD.
ENDCLASS.
