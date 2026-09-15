Use DfAllEnt.pkg

Use Cal_Res.DD
Use Cal_Sch.DD
Use Cal_Lay.DD
Use Cal_SRL.DD
Use cSigCJPushButton.pkg

Activate_View Activate_oCalendar_Resources for oCalendar_Resources
Object oCalendar_Resources is a dbView
    Set Label to "Calendar Resource Tables"
    Set Size to 137 291
    Set Location to 7 9

    Object oOrder_BusinessProcess is a BusinessProcess
        Property Integer piLayout_no
        Property Integer piOrder

        Object oCal_Lay_DD is a Cal_Lay_DataDictionary
            
            Property Integer pCDD_Layout_no
            
            Procedure OnConstrain
                If (pCDD_Layout_no(Self) > 0) Constrain Cal_Lay.Id eq (pCDD_Layout_no(Self))
            End_Procedure
            
        End_Object // oCal_Lay_DD
    
        Object oCal_Srl_DD is a Cal_Srl_DataDictionary
            Set DDO_Server to oCal_Lay_DD
            Set Constrain_File to Cal_Lay.File_Number 
        End_Object // oCal_Srl_DD
    
        
        //Debugging
        Set Display_Error_State to True
            

        // After deleting check we have the correct Order numbers    
        Procedure DoProcess_Order
            Integer iCount
            String  sValue
            
            Set pCDD_Layout_no   of oCal_Lay_DD to (piLayout_no(Self))
            
            Send Clear of oCal_Lay_DD
            Send Clear of oCal_Srl_DD
        
            Send Rebuild_Constraints of oCal_Lay_DD
            Send Rebuild_Constraints of oCal_Srl_DD
            
            Send Find of oCal_Lay_DD Ge 1
            
            Move 0 to Cal_Srl.Order
            Send Find of oCal_Srl_DD Gt 1
            While (Found)
                Increment iCount
                If (Cal_Srl.Order <> iCount) Begin
                    Set Field_Changed_Value of oCal_Srl_DD Field Cal_Srl.Order to iCount
                    Send Request_Save of oCal_Srl_DD
                End
                Send Find of oCal_Srl_DD Gt 1
            Loop
        End_Procedure

        Procedure DoProcess_Up
            Integer iCount iOrder iUpTo
            String  sValue
            
            If (piOrder(Self) <= 1) Procedure_Return 
            
            Set pCDD_Layout_no   of oCal_Lay_DD to (piLayout_no(Self))
            
            Send Clear of oCal_Lay_DD
            Send Clear of oCal_Srl_DD
        
            Send Rebuild_Constraints of oCal_Lay_DD
            Send Rebuild_Constraints of oCal_Srl_DD
            
            Send Find of oCal_Lay_DD Ge 1
            
            Move 9999 to Cal_Srl.Order
            Send Find of oCal_Srl_DD Lt 1
            Get Field_Current_Value of oCal_Srl_DD Field Cal_Srl.Order to iOrder

            Move (piOrder(Self)-2) to iUpTo
            If (iUpTo < 0) Move 0 to iUpTo

            Repeat 
                Move iOrder to Cal_Srl.Order
                Send Find of oCal_Srl_DD Eq 1
                If (Found) Begin
                    Set Field_Changed_Value of oCal_Srl_DD Field Cal_Srl.Order to (iOrder +1)
                    Send Request_Save of oCal_Srl_DD
                End
                Decrement iOrder
            Until  (iUpTo = iOrder)   

             Move (piOrder(Self)+1) to Cal_Srl.Order
             Send Find of oCal_Srl_DD Eq 1
             If (Found) Begin
                Get Field_Current_Value of oCal_Srl_DD Field Cal_Srl.Order to  iOrder
                Set Field_Changed_Value of oCal_Srl_DD Field Cal_Srl.Order to (iOrder -2)
                Send Request_Save of oCal_Srl_DD
             End
            
            Send DoProcess_Order
        End_Procedure
        
        Procedure DoProcess_Down
            Integer iCount iOrder iUpTo
            String  sValue
            
            Set pCDD_Layout_no   of oCal_Lay_DD to (piLayout_no(Self))
            
            Send Clear of oCal_Lay_DD
            Send Clear of oCal_Srl_DD
        
            Send Rebuild_Constraints of oCal_Lay_DD
            Send Rebuild_Constraints of oCal_Srl_DD
            
            Send Find of oCal_Lay_DD Ge 1
            
            Move (piOrder(Self)) to iUpTo
            
            Move 9999 to Cal_Srl.Order
            Send Find of oCal_Srl_DD Lt 1
            Get Field_Current_Value of oCal_Srl_DD Field Cal_Srl.Order to iOrder
            
            // Stop if on last record
            If (iOrder = iUpTo) Procedure_Return 
            
            If ((iUpTo+1) <> iOrder) Begin
                Repeat 
                    Move iOrder to Cal_Srl.Order
                    Send Find of oCal_Srl_DD Eq 1
                    If (Found) Begin
                        Set Field_Changed_Value of oCal_Srl_DD Field Cal_Srl.Order to (iOrder +1)
                        Send Request_Save of oCal_Srl_DD
                    End
                    Decrement iOrder
                Until  ((iUpTo+1) = iOrder)   
            End
            
            Move (piOrder(Self)) to Cal_Srl.Order
            Send Find of oCal_Srl_DD Eq 1
            If (Found) Begin
                Get Field_Current_Value of oCal_Srl_DD Field Cal_Srl.Order to  iOrder
                Set Field_Changed_Value of oCal_Srl_DD Field Cal_Srl.Order to (iOrder +2)
                Send Request_Save of oCal_Srl_DD
            End
            
            Send DoProcess_Order
        End_Procedure

    End_Object

    Object oNewTabDialog is a dbTabDialogView

        Set Size to 128 282
        Set Location to 5 5
        Set Rotate_Mode to RM_Rotate

        Object oResources_TabPage is a dbTabView
            Object oCal_Res_DD is a Cal_Res_DataDictionary
            End_Object

            Set Main_DD to oCal_Res_DD
            Set Server to oCal_Res_DD

            Set Label to "Resources"

            Object oResource_ID is a dbForm
                Set Location to 10 50
                Entry_Item Cal_Res.ID
                Set Size to 13 54
                Set Label to "ID:"
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to JMode_Right
            End_Object

            Object oResource_Title is a dbForm
                Entry_Item Cal_Res.Title
                Set Location to 26 50
                Set Size to 13 200
                Set Label to "Title:"
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to JMode_Right
            End_Object

            Object oCal_Res_DataType is a dbComboForm
                Entry_Item Cal_Res.DataType
                Set Location to 42 50
                Set Size to 13 80
                Set Label to "Data Type:"
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to JMode_Right
            End_Object

            Object oCal_Res_DataSource is a dbForm
                Entry_Item Cal_Res.DataSource
                Set Location to 58 50
                Set Size to 13 200
                Set Label to "Data Source:"
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to JMode_Right
            End_Object

        End_Object

        Object oSchedules_TabPage is a dbTabView
            Object oCal_Sch_DD is a Cal_Sch_DataDictionary
            End_Object
    
            Set Main_DD to oCal_Sch_DD
            Set Server to oCal_Sch_DD

            Set Label to "Schedules"

            Object oSchedule_ID is a dbForm
                Entry_Item CAl_Sch.ID
                Set Location to 10 50
                Set Size to 13 54
                Set Label to "ID:"
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to JMode_Right
            End_Object

            Object oSchedule_Title is a dbForm
                Entry_Item Cal_Sch.Title
                Set Location to 26 50
                Set Size to 13 198
                Set Label to "Title:"
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to JMode_Right
            End_Object
        End_Object

        Object oLayouts_TabPage is a dbTabView
            Object oCal_Lay_DD is a Cal_Lay_DataDictionary
            End_Object

            Set Main_DD to oCal_Lay_DD
            Set Server to oCal_Lay_DD

            Set Label to "Layouts"

            Object oLayouts_ID is a dbForm
                Entry_Item Cal_Lay.ID
                Set Location to 10 50
                Set Size to 13 54
                Set Label to "ID:"
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to JMode_Right
            End_Object

            Object oLayouts_Title is a dbForm
                Entry_Item Cal_Lay.Title
                Set Location to 26 50
                Set Size to 13 198
                Set Label to "Title:"
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to JMode_Right
            End_Object

            Object oCal_Lay_Category_Set is a dbComboForm
                Entry_Item Cal_Lay.Category_Set
                Set Location to 42 50
                Set Size to 13 120
                Set Label to "Category Set:"
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to JMode_Right
            End_Object
        End_Object

        Object oResourceSetup_TabPage is a dbTabView
            Object oCal_Lay_DD is a Cal_Lay_DataDictionary
            End_Object // oCal_Lay_DD
        
            Object oCal_Srl_DD is a Cal_Srl_DataDictionary
                Set DDO_Server to oCal_Lay_DD
                Set Constrain_File to Cal_Lay.File_Number 
                
                Procedure Delete_Main_File
                    Set piLayout_no of oOrder_BusinessProcess to Cal_Lay.id 
                    Forward Send Delete_Main_File
                End_Procedure
        
                Procedure mAfter_Delete        
                    Send DoProcess_Order of oOrder_BusinessProcess
                End_Procedure
                
            End_Object // oCal_Srl_DD
        
            Set Main_DD to oCal_Lay_DD
            Set Server  to oCal_Lay_DD
        
            Set Label to "Resource Setup"
        
            Object oCal_LayTitle is a dbForm
                Entry_Item Cal_Lay.Title
                Set Size to 13 198
                Set Location to 10 50
                Set peAnchors to anLeftRight
                Set Label to "Title:"
                Set Label_Justification_mode to jMode_right
                Set Label_Col_Offset to 2
                Set Label_row_Offset to 0
            End_Object // oCal_LayTitle
        
            Object oDetailGrid is a dbGrid
                Set Size to 77 197
                Set Location to 27 50
        
                Set Main_file to Cal_Srl.File_number
                Set Server to oCal_Srl_DD
                Set Ordering to 1
                Set peResizeColumn to rcAll
                Set peAnchors to anAll
                Set Wrap_State to True
        
                Begin_Row
                    Entry_Item (Cal_Srl.Order)
                    Entry_Item Cal_Srl.Resource
                    Entry_Item Cal_Srl.Schedule
                End_Row
        
                Set Form_Width 0 to 40
                Set Header_Label 0 to "Order"
        
                Set Form_Width 1 to 83
                Set Header_Label 1 to "Resource"
                Set Column_Combo_State 1 to True
                
                Set Form_Width 2 to 70
                Set Header_Label 2 to "Schedule"
                Set Column_Combo_State 2 to True
                
                Set Child_Table_State to True
                Set GridLine_Mode to Grid_Visible_Horz
                Set CurrentRowColor to clHighlight
                
                Procedure Update_Objects 
                    Send Clear of oCal_Lay_DD  
                    Send Column_Combo_Fill_List 1
                    Send Column_Combo_Fill_List 2   
                End_Procedure                                            
                
                Function Child_Entering Returns Integer
                    Boolean bFail
                    // Check with header to see if it is saved.
                    Delegate Get SaveHeader to bFail
                    Function_Return bFail // if non-zero do not enter
                End_Function // Child_Entering
        
                On_Key kAdd_Mode Send Append_a_Row  // Hot Key for KAdd_Mode = Shift+F10
        
                Procedure Append_a_Row 
                    Send End_Of_Data
                    Send Down
                End_Procedure // Append_a_Row
                
                // Add new record to the end of the table.
                Function Row_Save Returns Integer
                    Integer iRetval   
                    Boolean bHasRecord
                    
                    Get HasRecord of oCal_Srl_DD to bHasRecord
                    If (not(bHasRecord)) Set Field_Changed_Value of oCal_Srl_DD Field Cal_SRL.Order to (Cal_Lay.Count +1)                    
                    Forward Get Row_Save to iRetval
                    Function_Return iRetval
                End_Function // Row_Save    
        
            End_Object // oDetailGrid
        
            Function ConfirmDeleteHeader Returns Boolean
                Boolean bFail
                Get Confirm "Delete Entire Header and all detail?" to bFail
                Function_Return bFail
            End_Function // ConfirmDeleteHeader
        
            Function ConfirmSaveHeader Returns Boolean
                Boolean bNoSave bHasRecord
                Handle  hoSrvr
                Get Server to hoSrvr
                Get HasRecord of hoSrvr to bHasRecord
                If not bHasRecord Begin
                    Get Confirm "Save this NEW header?" to bNoSave
                End
                Function_Return bNoSave
            End_Function // ConfirmSaveOrder
        
            Set Verify_Save_MSG       to GET_ConfirmSaveHeader
            Set Verify_Delete_MSG     to GET_ConfirmDeleteHeader
        
            Function SaveHeader Returns Boolean
                Integer iRec
                Boolean bChanged bHasRecord
                Handle  hoSrvr
        
                Get Server to hoSrvr                   // The Header DDO.
                Get HasRecord of hoSrvr to bHasRecord  // Is there a record?
                Get Should_Save to bChanged            // Are there any current changes?
        
                // If there is no record and no changes we have an error.
                If (not(bHasRecord) and not(bChanged) ) Begin  // no rec
                    Error DfErr_Operator "You must First Create & Save the Header"
                    Function_Return True
                End
        
                Send Request_Save_No_Clear
        
                Get Should_Save to bChanged  // is a save still needed
                Get HasRecord of hoSrvr to bHasRecord // is there a record after the save?
                // if no record or changes still exist, return an error code of 1
                If (not(bHasRecord) or (bChanged)) Begin
                    Function_Return True
                End
            End_Function // SaveHeader
                                                   
            Procedure Activate Returns Integer
                Integer iRetval
                Forward Get msg_Activate to iRetval
                // Reset Combo as we may have changed the data
                Send Update_Objects of oDetailGrid
                Procedure_Return iRetval 
            End_Procedure      
            
            Object oOrder_Up_bn is a cSigCJPushButton
                Set Size to 15 15
                Set Location to 50 30
                Set psImage to "Up16.bmp"
                Set pbPointer_Only to True
            
                Procedure OnClick
                    Integer iLayout_no iOrder

                    Get Field_Current_Value of oCal_Lay_DD Field  Cal_Lay.ID     to iLayout_no
                    Get Field_Current_Value of oCal_Srl_DD Field  Cal_SRL.Order  to iOrder

                    Set piLayout_no of oOrder_BusinessProcess to iLayout_no
                    Set piOrder     of oOrder_BusinessProcess to iOrder
                    
                    If ((iLayout_no > 0) and (iOrder > 0)) Begin
                        Send DoProcess_Up of oOrder_BusinessProcess
                        Send Beginning_of_Data of oDetailGrid
                    End            
                End_Procedure
            
            End_Object
        
            Object oOrder_Down_bn is a cSigCJPushButton
                Set Size to 15 15
                Set Location to 70 30
                Set psImage to "Down16.bmp"
                Set pbPointer_Only to True
    
                Procedure OnClick
                    Integer iLayout_no iOrder

                    Get Field_Current_Value of oCal_Lay_DD Field  Cal_Lay.ID     to iLayout_no
                    Get Field_Current_Value of oCal_Srl_DD Field  Cal_SRL.Order  to iOrder

                    Set piLayout_no of oOrder_BusinessProcess to iLayout_no
                    Set piOrder     of oOrder_BusinessProcess to iOrder
                    
                    If ((iLayout_no > 0) and (iOrder > 0)) Begin
                        Send DoProcess_Down of oOrder_BusinessProcess
                        Send Beginning_of_Data of oDetailGrid
                    End            
                End_Procedure
            
            End_Object

        End_Object

    End_Object

End_Object

