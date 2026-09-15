Use dfallent.pkg
Use cSigCjTreeView.pkg
Use cDbSplitterContainer.pkg
Use cSigCJdbForm.pkg
Use SalesP.DD
Use OrderHea.DD
Use Customer.DD
Use OrderDtl.DD
Use dfClient.pkg

Deferred_View Activate_oSigCJTreeViewDemo_SalesOrders_View for ;
Object oSigCJTreeViewDemo_SalesOrders_View is a dbView

    Set Border_Style to Border_Thick
    Set Size to 205 525
    Set Location to 2 2
    Set Maximize_Icon to True
    Set Icon to "SIG.ico"
    Set Label to "Codejock Demo - Sales Tree View"

    Set Verify_Data_Loss_Msg to 0
    Set Verify_Exit_Msg      to 0

    Object oSalesp_DD is a SalesP_DataDictionary
    End_Object

    Object oCustomer_DD is a Customer_DataDictionary
    End_Object

    Object oOrderhea_DD is a OrderHea_DataDictionary
        Set DDO_Server to oCustomer_DD
        Set DDO_Server to oSalesp_DD 
        Property String psDDO_ID
        
        Procedure OnConstrain
            If (psDDO_ID(Self)) Constrain OrderHea.SalesPerson_ID eq (psDDO_ID(Self))      
        End_Procedure

    End_Object

    Object oOrderdtl_DD is a OrderDtl_DataDictionary
        Set Constrain_file to OrderHea.File_number
        Set DDO_Server to oOrderhea_DD
    End_Object

    Set Main_DD to oSalesp_DD
    Set Server to oSalesp_DD

    Object oDbSplitterContainer1 is a cDbSplitterContainer
        Set piSplitterLocation to 139
        Object oDbSplitterContainerChild1 is a cDbSplitterContainerChild
            
            Object oSales_TreeView is a cSigCJTreeView
                Set Size to 199 132
                Set Location to 3 3
                Set peAnchors to anAll
                Set pbSorted to True
                Set pbActive_Track to True
                Property Handle  phoCurrent_Node
                Property Integer piCurrent_Node_Index 

                Procedure OnCreateTree 
                    Forward Send OnCreateTree 
                    
                    Send Load_Sales 
                End_Procedure
                
                Procedure OnNodeClick Handle hoNode
                    Forward Send OnNodeClick hoNode
                    // Showln "OnNodeClick " hoNode
                End_Procedure   
                
                Procedure OnNodeChanging Handle hoNode Integer iIndex  
                    Set phoCurrent_Node to hoNode
                    Set piCurrent_Node_Index to iIndex 
                    // If you running with data aware components, then this is the hook to save the record before moving on. 
                    //  You will need to refind the Old node first 
                End_Procedure
                

                Procedure Load_Sales
                    Handle hoNode hoDDO
                    
                    Move (oSalesp_DD(Self)) to hoDDO
                    
                    Send Clear of oSalesp_DD
                    Send Find of oSalesp_DD FIRST_RECORD 1 
                    While (Found)
                        Get Add_Root_Node (Trim(SalesP.Name)) (Trim(SalesP.ID)) to hoNode
                        Set Node_Cargo  of hoNode to (Trim(SalesP.ID))
                        Set Node_DDO    of hoNode to hoDDO
                        Set Node_Recnum of hoNode to SalesP.Recnum 
                        // Create a Child ghost in-order allow for expanding
                        Get Add_Child_Node "Ghost" "" (Trim(SalesP.ID)) to hoNode  
                        Send Find of oSalesp_DD NEXT_RECORD 1
                    Loop
                End_Procedure
                
                Procedure Load_Orders String sParentKey 
                    Handle hoNode 
                    
                    Send Clear of oOrderhea_DD
                    Send Find of oOrderhea_DD FIRST_RECORD 1 
                    If (not(Found)) Begin
                        Get Add_Child_Node "No sales" "" sParentKey 2 to hoNode
                        Set psImage  of hoNode to "Newdoc.ico"
                    End     
                    While (Found)
                        Get Add_Child_Node (Trim(Customer.Name)) (String(OrderHea.Order_Number) +':'+ String(OrderHea.Customer_Number)) sParentKey 2 to hoNode
                        Set Node_Recnum of hoNode to OrderHea.Recnum
                        Set psImage     of hoNode to "Newdoc.ico" 
                        If (OrderHea.Order_Total > 5000) Begin
                            Set piForeColor of hoNode to clFuchsia
                            Set pbBold      of hoNode to True 
                            Set psImage     of hoNode to "FlagUK_16.bmp" 
                        End
                        Send Find of oOrderhea_DD NEXT_RECORD 1 
                    Loop 
                End_Procedure

                Procedure OnExpand Handle hoNode
                    String  sCargo sParentKey
                    Integer iLevel 
                    
                    Get Node_Cargo  of hoNode to sCargo
                    Get Node_Level  of hoNode to iLevel
                    Get ComKey      of hoNode to sParentKey

                    If (iLevel = 1) Begin // Sales Person level so Load Orders 
                        Set psDDO_ID of oOrderhea_DD to (Trim(sCargo))
                        Send Rebuild_Constraints to oOrderhea_DD
                        Send Remove_Children of hoNode
                        Send Load_Orders sParentKey 
                    End
                End_Procedure
                
                Procedure OnActive_Track Handle hoNode Integer iIndex
                    Integer iRecnum iLevel
                    Forward Send OnActive_Track hoNode iIndex
                    
                    Get Node_Recnum of hoNode to iRecnum
                    Get Node_Level  of hoNode to iLevel 
                    If ((iRecnum > 0) and (iLevel = 2)) Begin
                        Set psDDO_ID of oOrderhea_DD to ""
                        Send Rebuild_Constraints to oOrderhea_DD
                        Send Find_By_Recnum of oOrderhea_DD OrderHea.File_Number iRecnum
                        Set phoCurrent_Node to hoNode
                    End
                    Else Send Clear_All of oOrderhea_DD 
                     
                End_Procedure
                
                Procedure OnNodeChanging Handle hoNode Integer iIndex  
                    Integer iRecnum iLevel 
                    
                    Get Node_Recnum of hoNode to iRecnum
                    Get Node_Level  of hoNode to iLevel 
                    If ((iRecnum > 0) and (iLevel = 2)) Begin
                        Send Request_Save of oOrderhea_DD 
                    End
                End_Procedure
            
            End_Object
        End_Object

        Object oDbSplitterContainerChild2 is a cDbSplitterContainerChild
            Object oDbContainer3d1 is a dbContainer3d
                Set Size to 85 405
                Set Location to 0 0
                Set peAnchors to anTopLeftRight
                Set Server to oOrderhea_DD 
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
                    Set Location to 4 229
                    Set peAnchors to anTopRight
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to jMode_Right
        
                    // If order record exists, disallow entry in customer window.
                    Procedure Refresh Integer iMode
                        Handle  hoSrvr
                        Boolean bCrnt
                        Get Server to hoSrvr                 // get the data_set
                        Get HasRecord of hoSrvr to bCrnt // has record in data_set
                        // Set displayonly to true if iCrnt is non-zero
                        Set Enabled_State to (not(bCrnt))
                        Forward Send Refresh iMode          // do normal refrsh
                        // don't leave us sitting on a displayonly window
                        If (bCrnt and Focus(Self)=Self) Send Next
                    End_Procedure  // Refresh
                    
                End_Object    // oOrderHea_Customer_Number
        
                Object oOrderHea_Order_Date is a cSigCJdbForm
                    Entry_Item OrderHea.Order_Date
                    Set Label to "Order Date:"
                    Set Size to 13 67
                    Set Location to 4 327
                    Set peAnchors to anTopRight
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to jMode_Right
                End_Object    // oOrderHea_Order_Date
        
                Object oCustomer_Name is a dbForm
                    Entry_Item Customer.Name
                    Set Label to "Customer Name:"
                    Set Size to 13 208
                    Set Location to 18 63
                    Set peAnchors to anTopLeftRight
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to jMode_Right
                    Set Prompt_Button_Mode to pb_PromptOff
        
                    // We want this to be a displayonly field
                    Set Enabled_State to False
                    
                End_Object    // oCustomer_Name
        
                Object oCustomer_Address is a dbForm
                    Entry_Item Customer.Address
                    Set Label to "Street Address:"
                    Set Size to 13 208
                    Set Location to 34 63
                    Set peAnchors to anTopLeftRight
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to jMode_Right
                End_Object    // oCustomer_Address
        
                Object oCustomer_City is a dbForm
                    Entry_Item Customer.City
                    Set Label to "City/State/Zip:"
                    Set Size to 13 112
                    Set Location to 49 63
                    Set peAnchors to anTopLeftRight
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to jMode_Right
                End_Object    // oCustomer_City
        
                Object oCustomer_State is a dbForm
                    Entry_Item Customer.State
                    Set Size to 13 20
                    Set Location to 49 183
                    Set peAnchors to anTopRight
                End_Object    // oCustomer_State
        
                Object oCustomer_Zip is a dbForm
                    Entry_Item Customer.Zip
                    Set Size to 13 60
                    Set Location to 49 211
                    Set peAnchors to anTopRight
                End_Object    // oCustomer_Zip
        
                Object oOrderHea_Ordered_By is a dbForm
                    Entry_Item OrderHea.Ordered_By
                    Set Label to "Ordered By:"
                    Set Size to 13 67
                    Set Location to 34 327
                    Set peAnchors to anTopRight
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to jMode_Right
                End_Object    // oOrderHea_Ordered_By
        
                Object oOrderHea_Salesperson_ID is a dbForm
                    Entry_Item Salesp.Id
                    Set Label to "Salesperson ID:"
                    Set Size to 13 40
                    Set Location to 49 327
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
                    Set Entry_State to False
        
                End_Object    // oOrderHea_Terms
        
                Object oOrderHea_Ship_Via is a dbComboForm
                    Entry_Item OrderHea.Ship_Via
                    Set Label to "Ship Via:"
                    Set Size to 13 103
                    Set Location to 64 211
                    Set peAnchors to anTopRight
                    Set Form_Border to 0
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to jMode_Right
                    Set Entry_State to False
        
                    Procedure Switch
                       Send Activate of oOrderDtl_Grid
                    End_Procedure  // Switch
        
                End_Object    // oOrderHea_Ship_Via
        
            End_Object    // oDbContainer3d1

            Object oDbContainer3d2 is a dbContainer3d
                Set Size to 119 383
                Set Location to 85 1
                Set Server to oOrderdtl_DD 
                Set peAnchors to anAll

                Object oOrderDtl_Grid is a dbGrid
                    Set Size to 63 372
                    Set Location to 10 3
            
                    Begin_Row
                        Entry_Item Invt.Item_id
                        Entry_Item Invt.Description
                        Entry_Item Invt.Unit_Price
                        Entry_Item OrderDtl.Price
                        Entry_Item OrderDtl.Qty_Ordered
                        Entry_Item OrderDtl.Extended_Price
                    End_Row
            
                    Set Main_File to OrderDtl.File_Number
                    Set Server to oOrderDtl_DD
            
                    Set Form_Width 0 to 55
                    Set Header_Label 0 to "Item ID"
                    
                    Set Form_Width 1 to 119
                    Set Header_Label 1 to "Description"
                    
                    Set Form_Width 2 to 55
                    Set Header_Label 2 to "Unit Price"
                    
                    Set Form_Width 3 to 43
                    Set Header_Label 3 to "Price"
                    
                    Set Form_Width 4 to 43
                    Set Header_Label 4 to "Quantity"
                    
                    Set Form_Width 5 to 55
                    Set Header_Label 5 to "Total"
                    
                    Set Column_Button 4 to Form_Button_Spin  // make qty column spinner
                    Set Column_Minimum_Position 4 to 0       // with range of 0 to 999
                    Set Column_Maximum_Position 4 to 999
                    
                    // Change:   Table entry checking.
                    //           Set child_table_state to true which will
                    //           cause table to save when exiting and
                    //           attempt to save header when entering.
                    Set Child_Table_State to True     // Saves when exit object
                    Set Ordering to 1
                    Set peAnchors to anAll
                    Set peResizeColumn to rcAll
                    Set Wrap_State to True
                    Set pbEmbeddedPrompts to True
                    
                    // Called when entering the table. Check with the header if it
                    // has a valid saved record. If not, disallow entry.
                    Function Child_Entering Returns Integer
                       Integer iRetVal
                       // Check with header to see if it is saved.
//                       Delegate Get Save_Header to iRetVal
                       Function_Return iRetVal // if non-zero do not enter
                    End_Function  // Child_Entering
                    
                    // Change:   Assign insert-row key append a row
                    //           Create new behavior to support append a row
                    //           Optimize the table refresh
                    Set Allow_Insert_Add_State to False 
                    On_Key kAdd_Mode Send Append_a_Row  // Hot Key for KAdd_Mode = Shift+F10
                    
                    // Add new record to the end of the table.
                    Procedure Append_a_Row      // Q: how would a keyboard do this?
                        Send End_Of_Data        // A: Go to end of table and
                        Send Down               //    down 1 line to empty line
                    End_Procedure  // Append_a_Row
                    
                    // The way this table is set up, items can never be added out
                    // of order. New items are always added to the end of the table.
                    // By setting Auto_Regenerate_State to false we are telling the
                    // table to never bother reordering after adding records. This is
                    // a minor optimization.
                    
                    Set Auto_Regenerate_State to False // table is always in order.
            
                End_Object    // oOrderDtl_Grid
                Object oOrderHea_Order_Total is a dbForm
                    Entry_Item OrderHea.Order_Total
                    Set Label to "Order Total:"
                    Set Size to 13 60
                    Set Location to 76 307
                    Set peAnchors to anBottomRight
                    Set Label_Col_Offset to 3
                    Set Label_Justification_Mode to jMode_Right
                End_Object    // oOrderHea_Order_Total
            End_Object
        End_Object
    End_Object

Cd_End_Object
