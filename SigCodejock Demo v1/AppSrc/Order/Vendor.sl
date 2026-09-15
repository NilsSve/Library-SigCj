Use DFClient.pkg
Use DFSelLst.pkg
Use Windows.pkg

Use Vendor.DD

CD_Popup_Object Vendor_sl is a dbModalPanel
    Set Label to "Vendor List"
    Set Size to 132 238
    Set Location to 4 5
    Set piMinSize to 132 238

    Object Vendor_DD is a Vendor_DataDictionary
    End_Object    // Vendor_DD

    Set Main_DD to Vendor_DD
    Set Server to Vendor_DD

    Object oSelList is a dbList
        Set Main_File to Vendor.File_Number
        Set Size to 105 227
        Set Location to 6 6
        Set peAnchors to anAll
        Set pbHeaderTogglesDirection to True

        Begin_Row
            Entry_Item Vendor.ID
            Entry_Item Vendor.Name
        End_Row

        Set Form_Width 0 to 36
        Set Header_Label 0 to "Vndr ID"
        
        Set Form_Width 1 to 183
        Set Header_Label 1 to "Vendor Name"
        
    End_Object    // oSelList

    Object oOK_bn is a Button
        Set Label to "&Ok"
        Set Location to 114 77
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send OK To oSelList
        End_Procedure

    End_Object    // oOK_bn

    Object oCancel_bn is a Button
        Set Label to "&Cancel"
        Set Location to 114 130
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Cancel To oSelList
        End_Procedure

    End_Object    // oCancel_bn

    Object oSearch_bn is a Button
        Set Label to "&Search..."
        Set Location to 114 183
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Search To oSelList
        End_Procedure

    End_Object    // oSearch_bn

    On_Key Key_Alt+Key_O Send KeyAction To oOk_bn
    On_Key Key_Alt+Key_C Send KeyAction To oCancel_bn
    On_Key Key_Alt+Key_S Send KeyAction To oSearch_bn

CD_End_Object    // Vendor_sl
