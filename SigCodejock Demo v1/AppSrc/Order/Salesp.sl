Use DFClient.pkg
Use DFSelLst.pkg
Use Windows.pkg

Use SalesP.DD

CD_Popup_Object SalesP_sl is a dbModalPanel

    Set Minimize_Icon to False
    Set Label to "Sales People List"
    Set Size to 99 260
    Set Location to 4 5
    Set piMinSize to 99 174

    Object SalesP_DD is a SalesP_DataDictionary
    End_Object    // Salesp_DD

    Set Main_DD to SalesP_DD
    Set Server to SalesP_DD

    Object oSelList is a dbList
        Set Main_File to SalesP.File_Number
        Set Ordering to 1
        Set Size to 71 248
        Set Location to 6 6
        Set peAnchors to anAll
        Set pbHeaderTogglesDirection to True

        Begin_Row
            Entry_Item SalesP.ID
            Entry_Item SalesP.Name
        End_Row

        Set Form_Width 0 to 40
        Set Header_Label 0 to "ID"
        
        Set Form_Width 1 to 200
        Set Header_Label 1 to "Sales Person Name"
        
    End_Object    // oSelList

    Object oOK_bn is a Button
        Set Label to "&Ok"
        Set Location to 81 99
        Set peAnchors to anBottomRight
        Set Default_State to True

        Procedure OnClick
            Send OK To oSelList
        End_Procedure

    End_Object    // oOK_bn

    Object oCancel_bn is a Button
        Set Label to "&Cancel"
        Set Location to 81 152
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Cancel To oSelList
        End_Procedure

    End_Object    // oCancel_bn

    Object oSearch_bn is a Button
        Set Label to "&Search..."
        Set Location to 81 205
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Search To oSelList
        End_Procedure

    End_Object    // oSearch_bn

    On_Key Key_Alt+Key_O Send KeyAction To oOk_bn
    On_Key Key_Alt+Key_C Send KeyAction To oCancel_bn
    On_Key Key_Alt+Key_S Send KeyAction To oSearch_bn

CD_End_Object    // SalesP_sl
