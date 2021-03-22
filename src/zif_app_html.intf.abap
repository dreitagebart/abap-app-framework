INTERFACE zif_app_html
  PUBLIC.

  CONSTANTS: BEGIN OF events,
               on_change   TYPE string VALUE 'onChange',
               on_key_down TYPE string VALUE 'onKeyDown',
               on_click    TYPE string VALUE 'onClick',
             END OF events,

             BEGIN OF tags,
               textarea   TYPE string VALUE 'textarea',
               textinput  TYPE string VALUE 'input',
               html       TYPE string VALUE 'html',
               form       TYPE string VALUE 'form',
               body       TYPE string VALUE 'body',
               button     TYPE string VALUE 'button',
               table      TYPE string VALUE 'table',
               table_row  TYPE string VALUE 'tr',
               table_cell TYPE string VALUE 'td',
               row_header TYPE string VALUE 'th',
               break_line TYPE string VALUE 'br',
               paragraph  TYPE string VALUE 'p',
               list       TYPE string VALUE 'ul',
               list_item  TYPE string VALUE 'li',
             END OF tags.

ENDINTERFACE.
