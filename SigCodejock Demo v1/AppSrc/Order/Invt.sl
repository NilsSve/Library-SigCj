Use DFClient.pkg
Use DFSelLst.pkg
Use Windows.pkg

Use Vendor.DD
Use Invt.DD

CD_Popup_Object Invt_sl is a dbModalPanel

    Set Minimize_Icon to False
    Set Label to "Inventory List"
    Set Size to 133 284
    Set Location to 4 4
    Set piMinSize to 97 174

    Object Vendor_DD is a Vendor_DataDictionary
    End_Object    // Vendor_DD

    Object Invt_DD is a Invt_DataDictionary
        Set DDO_Server to Vendor_DD
    End_Object    // Invt_DD

    Set Main_DD to Invt_DD
    Set Server to Invt_DD

    Object oSelList is a dbList
        Set Main_File to Invt.File_Number
        Set Ordering to 1
        Set Size to 105 273
        Set Location to 6 6
        Set peAnchors to anAll
        Set pbHeaderTogglesDirection to True

        Begin_Row
            Entry_Item Invt.Item_iD
            Entry_Item Invt.Description
            Entry_Item Invt.Unit_Price
            Entry_Item Invt.On_Hand
        End_Row

        Set Form_Width 0 to 55
        Set Header_Label 0 to "Item ID"
        
        Set Form_Width 1 to 125
        Set Header_Label 1 to "Description"
        
        Set Form_Width 2 to 48
        Set Header_Label 2 to "Unit Price"
        
        Set Form_Width 3 to 40
        Set Header_Label 3 to "On Hand"
        
        Set Currency_Mask 2 to 6 2
        Set Numeric_Mask 3 to 6 0

    End_Object    // oSelList

    Object oOK_bn is a Button
        Set Label to "&Ok"
        Set Location to 115 123
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send OK To oSelList
        End_Procedure

    End_Object    // oOK_bn

    Object oCancel_bn is a Button
        Set Label to "&Cancel"
        Set Location to 115 176
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Cancel To oSelList
        End_Procedure

    End_Object    // oCancel_bn

    Object oSearch_bn is a Button
        Set Label to "&Search..."
        Set Location to 115 229
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Search To oSelList
        End_Procedure

    End_Object    // oSearch_bn

    On_Key Key_Alt+Key_O Send KeyAction To oOk_bn
    On_Key Key_Alt+Key_C Send KeyAction To oCancel_bn
    On_Key Key_Alt+Key_S Send KeyAction To oSearch_bn

CD_End_Object    // Invt_sl
