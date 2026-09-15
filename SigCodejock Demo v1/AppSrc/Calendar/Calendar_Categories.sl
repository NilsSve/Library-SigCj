//==============================================================================
// Contributions
// =============
//
// When       Who          What
// ========== ============ =====================================================
// 2009-01-09 Nick Wright  Original Implementation
//
//==============================================================================

Use DFClient.pkg
Use DFSelLst.pkg
Use Windows.pkg

Use CAL_CATS.DD

Cd_Popup_Object Calendar_Categories_sl is a dbModalPanel
    Set Location to 5 5
    Set Size to 134 299
    Set Label to "Calendar Categories Lookup List"
    Set Border_Style to Border_Thick
    Set Minimize_Icon to False


    Object oCal_Cats_DD Is A Cal_Cats_DataDictionary
    End_Object // oCal_Cats_DD

    Set Main_DD To oCal_Cats_DD
    Set Server  To oCal_Cats_DD



    Object oSelList Is A dbList
        Set Size to 105 289
        Set Location to 5 5
        Set peAnchors to anAll
        Set Main_File to Cal_Cats.File_Number
        Set Ordering to 1
        Set peResizeColumn to rcAll
        Set Auto_Server_State to True
        Set pbHeaderTogglesDirection to True

        Begin_row
            Entry_Item Cal_Cats.Id
            Entry_Item Cal_Cats.Short_Desc
            Entry_Item Cal_Cats.Long_Desc
        End_row

        Set Form_Width 0 to 26
        Set Header_Label 0 to "Id"

        Set Form_Width 1 to 96
        Set Header_Label 1 to "Short Desc"

        Set Form_Width 2 to 150
        Set Header_Label 2 to "Long Desc"

    End_Object // oSelList

    Object oOk_bn Is A Button
        Set Label to "&Ok"
        Set Location to 115 135
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send OK of oSelList
        End_Procedure

    End_Object // oOk_bn

    Object oCancel_bn Is A Button
        Set Label to "&Cancel"
        Set Location to 115 189
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Cancel of oSelList
        End_Procedure

    End_Object // oCancel_bn

    Object oSearch_bn Is A Button
        Set Label to "&Search..."
        Set Location to 115 243
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Search of oSelList
        End_Procedure

    End_Object // oSearch_bn

    On_Key Key_Alt+Key_O Send KeyAction of oOk_bn
    On_Key Key_Alt+Key_C Send KeyAction of oCancel_bn
    On_Key Key_Alt+Key_S Send KeyAction of oSearch_bn


Cd_End_Object
