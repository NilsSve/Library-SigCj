Use DFClient.pkg
Use DFSelLst.pkg
Use Windows.pkg

Use Customer.DD
Use OrderHea.DD

CD_Popup_Object OrderHea_sl is a dbModalPanel

    Set Minimize_Icon to False
    Set Label to "Orders List"
    Set Size to 134 392
    Set Location to 4 5
    Set piMinSize to 97 174

    Object Customer_DD is a Customer_DataDictionary
    End_Object    // Customer_DD

    Object OrderHea_DD is a OrderHea_DataDictionary
        Set DDO_Server to Customer_DD
    End_Object    // OrderHea_DD

    Set Main_DD to OrderHea_DD
    Set Server to OrderHea_DD

    Object oSelList is a dbList
        Set Main_File to OrderHea.File_Number
        Set Ordering to 1
        Set Size to 106 380
        Set Location to 6 6
        Set peAnchors to anAll
        Set pbHeaderTogglesDirection to True

        Begin_Row
            Entry_Item OrderHea.Order_Number
            Entry_Item Customer.Customer_Number
            Entry_Item Customer.Name
            Entry_Item OrderHea.Order_Date
            Entry_Item OrderHea.Order_Total
        End_Row

        Set Form_Width 0 to 36
        Set Header_Label 0 to "Order #"
        
        Set Form_Width 1 to 36
        Set Header_Label 1 to "Cust. #"
        
        Set Form_Width 2 to 183
        Set Header_Label 2 to "Name"
        
        Set Form_Width 3 to 60
        Set Header_Label 3 to "Order Date"
        
        Set Form_Width 4 to 60
        Set Header_Label 4 to "Order Total"
        
    End_Object    // oSelList

    Object oOK_bn is a Button
        Set Label to "&Ok"
        Set Location to 116 231
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send OK To oSelList
        End_Procedure

    End_Object    // oOK_bn

    Object oCancel_bn is a Button
        Set Label to "&Cancel"
        Set Location to 116 284
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Cancel To oSelList
        End_Procedure

    End_Object    // oCancel_bn

    Object oSearch_bn is a Button
        Set Label to "&Search..."
        Set Location to 116 337
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Search To oSelList
        End_Procedure

    End_Object    // oSearch_bn

    On_Key Key_Alt+Key_O Send KeyAction To oOk_bn
    On_Key Key_Alt+Key_C Send KeyAction To oCancel_bn
    On_Key Key_Alt+Key_S Send KeyAction To oSearch_bn

CD_End_Object    // OrderHea_sl
