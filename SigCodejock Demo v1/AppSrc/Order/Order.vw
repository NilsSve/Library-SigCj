Use dfClient.pkg
Use DataDict.pkg
Use dfEntry.pkg
Use dfSpnEnt.pkg
Use dfCEntry.pkg
Use dfTable.pkg
Use Windows.pkg

Use Vendor.DD
Use Invt.DD
Use Customer.DD
Use SalesP.DD
Use OrderHea.DD
Use OrderDtl.DD
Use cDbCJGrid.pkg
Use cCJGridColumnRowIndicator.pkg
Use cSigCJdbForm.pkg
Use cSigdbGrid.pkg
Use cSigdbGridColumn.pkg

Activate_View Activate_oOrderEntryView for oOrderEntryView
Object oOrderEntryView is a dbView
    Set Border_Style to Border_Thick
    Set Maximize_Icon to True
    Set Label to "Order Entry"
    Set Location to 2 3
    Set Size to 174 383
    Set piMinSize to 174 383
    Set pbAutoActivate to True

    Object Vendor_DD is a Vendor_DataDictionary
    End_Object    // Vendor_DD

    Object Invt_DD is a Invt_DataDictionary
        Set DDO_Server to Vendor_DD
    End_Object    // Invt_DD

    Object Customer_DD is a Customer_DataDictionary
    End_Object    // Customer_DD

    Object SalesP_DD is a Salesp_DataDictionary
    End_Object    // SalesP_DD

    Object OrderHea_DD is a OrderHea_DataDictionary
        Set DDO_Server to Customer_DD
        Set DDO_Server to SalesP_DD
        
        // this lets you save a new OrderHea from within OrderDtl.
        Set Allow_Foreign_New_Save_State to True
        
    End_Object    // OrderHea_DD

    Object OrderDtl_DD is a OrderDtl_DataDictionary
        Set DDO_Server to OrderHea_DD
        Set DDO_Server to Invt_DD
        Set Constrain_File to OrderHea.File_Number
    End_Object    // OrderDtl_DD

    Set Main_DD to OrderHea_DD
    Set Server to OrderHea_DD

    Object oDbContainer3d1 is a dbContainer3d
        Set Size to 85 377
        Set Location to 2 3
        Set peAnchors to anTopLeftRight
        Object oOrderHea_Order_Number is a dbForm
            Entry_Item OrderHea.Order_Number
            Set Label to "Order Number:"
            Set Size to 13 42
            Set Location to 4 63
            Set peAnchors to anTopLeft
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object    // oOrderHea_Order_Number

        Object oOrderHea_Customer_Number is a dbForm
            Entry_Item Customer.Customer_Number
            Set Label to "Customer Number:"
            Set Size to 13 42
            Set Location to 4 201
            Set peAnchors to anTopRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object    // oOrderHea_Customer_Number

        Object oOrderHea_Order_Date is a cSigCJdbForm
            Entry_Item OrderHea.Order_Date
            Set Label to "Order Date:"
            Set Size to 13 67
            Set Location to 4 299
            Set peAnchors to anTopRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object    // oOrderHea_Order_Date

        Object oCustomer_Name is a dbForm
            Entry_Item Customer.Name
            Set Label to "Customer Name:"
            Set Size to 13 180
            Set Location to 18 63
            Set peAnchors to anTopLeftRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object    // oCustomer_Name

        Object oCustomer_Address is a dbForm
            Entry_Item Customer.Address
            Set Label to "Street Address:"
            Set Size to 13 180
            Set Location to 34 63
            Set peAnchors to anTopLeftRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object    // oCustomer_Address

        Object oCustomer_City is a dbForm
            Entry_Item Customer.City
            Set Label to "City/State/Zip:"
            Set Size to 13 84
            Set Location to 49 63
            Set peAnchors to anTopLeftRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object    // oCustomer_City

        Object oCustomer_State is a dbForm
            Entry_Item Customer.State
            Set Size to 13 20
            Set Location to 49 155
            Set peAnchors to anTopRight
        End_Object    // oCustomer_State

        Object oCustomer_Zip is a dbForm
            Entry_Item Customer.Zip
            Set Size to 13 60
            Set Location to 49 183
            Set peAnchors to anTopRight
        End_Object    // oCustomer_Zip

        Object oOrderHea_Ordered_By is a dbForm
            Entry_Item OrderHea.Ordered_By
            Set Label to "Ordered By:"
            Set Size to 13 67
            Set Location to 34 299
            Set peAnchors to anTopRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object    // oOrderHea_Ordered_By

        Object oOrderHea_Salesperson_ID is a dbForm
            Entry_Item Salesp.Id
            Set Label to "Salesperson ID:"
            Set Size to 13 40
            Set Location to 49 299
            Set peAnchors to anTopRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object    // oOrderHea_Salesperson_ID

        Object oOrderHea_Terms is a dbComboForm
            Entry_Item OrderHea.Terms
            Set Label to "Terms:"
            Set Size to 13 85
            Set Location to 64 63
            Set peAnchors to anTopLeft
            Set Form_Border to 0
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right

        End_Object    // oOrderHea_Terms

        Object oOrderHea_Ship_Via is a dbComboForm
            Entry_Item OrderHea.Ship_Via
            Set Label to "Ship Via:"
            Set Size to 13 103
            Set Location to 64 183
            Set peAnchors to anTopRight
            Set Form_Border to 0
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object    // oOrderHea_Ship_Via

    End_Object    // oDbContainer3d1

    Object oOrderDtl_Grid is a cSigdbGrid
        Set Server to OrderDtl_DD
        Set Ordering to 1
        Set Size to 63 377
        Set Location to 90 3
        Set psLayoutSection to "OrderView_oOrderDtl_Grid2"
        Set piLayoutBuild to 6
        Set pbShade_Row to True 

        // Add some colour to show how row shading work
        Procedure OnSetRowColour Handle hoGridItemMetrics Integer iRow
            Number nTotal
            
            Get RowValue of oOrderDtl_Extended_Price iRow to nTotal
            If (nTotal <  200) Set ComBackColor of hoGridItemMetrics to clWhite
            If (nTotal >= 200) Set ComBackColor of hoGridItemMetrics to (RGB(128,255,128))
            If (nTotal >= 500) Set ComBackColor of hoGridItemMetrics to (RGB(128,191,255))
            If (nTotal >= 999) Set ComBackColor of hoGridItemMetrics to (RGB(255,128,128))
        End_Procedure
        
        Object oMark is a cCJGridColumnRowIndicator
        End_Object
        
        Object oInvt_Item_ID is a cSigdbGridColumn
            Entry_Item Invt.Item_ID
            Set piWidth to 91
            Set psCaption to "Item ID"
            Set psImage to "ActionPrompt.ico"
        End_Object
        
        Object oInvt_Description is a cSigdbGridColumn
            Entry_Item Invt.Description
            Set piWidth to 213
            Set psCaption to "Description"
        End_Object
        
        Object oInvt_Unit_Price is a cSigdbGridColumn
            Entry_Item Invt.Unit_Price
            Set piWidth to 53
            Set psCaption to "Unit Price"
        End_Object
        
        Object oOrderDtl_Qty_Ordered is a cSigdbGridColumn
            Entry_Item OrderDtl.Qty_Ordered
            Set piWidth to 50
            Set psCaption to "Quantity"
        End_Object
        
        Object oOrderDtl_Price is a cSigdbGridColumn
            Entry_Item OrderDtl.Price
            Set piWidth to 62
            Set psCaption to "Price"
        End_Object
        
        Object oOrderDtl_Extended_Price is a cSigdbGridColumn
            Entry_Item OrderDtl.Extended_Price
            Set piWidth to 81
            Set psCaption to "Total"
        End_Object

    End_Object    // oOrderDtl_Grid

    Object oOrderHea_Order_Total is a dbForm
        Entry_Item OrderHea.Order_Total
        Set Label to "Order Total:"
        Set Size to 13 60
        Set Location to 156 307
        Set peAnchors to anBottomRight
        Set Label_Col_Offset to 3
        Set Label_Justification_Mode to jMode_Right
    End_Object    // oOrderHea_Order_Total

    // Change:   Create custom confirmation messages for save and delete
    //           We must create the new functions and assign verify messages
    //           to them.
    Function Confirm_Delete_Order Returns Integer
        Integer iRetVal
        Get Confirm "Delete Entire Order?" to iRetVal
        Function_Return iRetVal
    End_Function
    
    // Only confirm on the saving of new records
    Function Confirm_Save_Order Returns Integer
        Integer iNoSave iSrvr
        Boolean bOld
        Get Server to iSrvr
        Get HasRecord of iSrvr to bOld
        If not bOld ;
            Get Confirm "Save this NEW order header?" to iNoSave
        Function_Return iNoSave
    End_Function
    
    // Define alternate confirmation Messages
    Set Verify_Save_MSG       to (RefFunc(Confirm_Save_Order))
    Set Verify_Delete_MSG     to (RefFunc(Confirm_Delete_Order))
    Set Auto_Clear_DEO_State  to False // don't clear Header on save
    
    Procedure Find_Record_Order_View String sID
        Send Clear of OrderHea_DD
        Move sID to OrderHea.Order_Number
        Send Find of OrderHea_DD Ge 1
    End_Procedure
    
End_Object    // oOrderEntryView

Procedure  Activate_Order_View String sID 
    Send Activate_oOrderEntryView
    Send Find_Record_Order_View of oOrderEntryView sID
End_Procedure
