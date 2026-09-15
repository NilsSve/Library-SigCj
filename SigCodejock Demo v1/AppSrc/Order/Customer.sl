Use DFClient.pkg
Use DFSelLst.pkg
Use Windows.pkg

Use Customer.DD

CD_Popup_Object Customer_sl is a dbModalPanel

    Set Border_Style to Border_Thick
    Set Minimize_Icon to False
    Set Label to "Customer List"
    Set Size to 134 238
    Set Location to 4 5
    Set piMinSize to 97 174

    Object Customer_DD is a Customer_DataDictionary
    End_Object    // Customer_DD

    Set Main_DD to Customer_DD
    Set Server to Customer_DD

    Object oSelList is a dbList
        Set Main_File to Customer.File_Number
        Set Ordering to 1
        Set Size to 106 227
        Set Location to 6 6
        Set peAnchors to anAll
        Set pbHeaderTogglesDirection to True

        Begin_Row
            Entry_Item Customer.Customer_Number
            Entry_Item Customer.Name
        End_Row

        Set Form_Width 0 to 38
        Set Header_Label 0 to "Number"
        
        Set Form_Width 1 to 183
        Set Header_Label 1 to "Customer Name"
        
    End_Object    // oSelList

    Object oOK_bn is a Button
        Set Label to "&Ok"
        Set Location to 116 77
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send OK To oSelList
        End_Procedure

    End_Object    // oOK_bn

    Object oCancel_bn is a Button
        Set Label to "&Cancel"
        Set Location to 116 130
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Cancel To oSelList
        End_Procedure

    End_Object    // oCancel_bn

    Object oSearch_bn is a Button
        Set Label to "&Search..."
        Set Location to 116 183
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Search To oSelList
        End_Procedure

    End_Object    // oSearch_bn

    On_Key Key_Alt+Key_O Send KeyAction To oOk_bn
    On_Key Key_Alt+Key_C Send KeyAction To oCancel_bn
    On_Key Key_Alt+Key_S Send KeyAction To oSearch_bn

CD_End_Object    // Customer_sl
