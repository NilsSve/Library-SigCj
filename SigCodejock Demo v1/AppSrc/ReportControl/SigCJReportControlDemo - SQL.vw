Use cSigCjReportControl.pkg
Use cSigCJContextMenu.pkg
Use cSigCJMenuItem.pkg
Use CalEvent.DD
Use DFEntry.pkg
Use Windows.pkg

Deferred_View Activate_SigCjReportControlDemo_SQL_View for ;
Object SigCjReportControlDemo_SQL_View is a dbView
    Set Border_Style to Border_Thick
    Set Size to 250 400
    Set Location to 2 2
    Set Maximize_Icon to True
    Set Label to "Codejock Demo - Report Control - SQL"
    Set Icon to "SIG.ico"
     
    Object oCalevent_DD is a CalEvent_DataDictionary
    End_Object

    Set Main_DD to oCalevent_DD
    Set Server to oCalevent_DD
    
    Object oSigCJReportControl1 is a cSigCJReportControl
        Set Size to 174 382
        Set Location to 33 7
        Set peAnchors to anAll

        Set piTable_Index to 1
        Set phoDD to oCalevent_DD
        Set pbAuto_Columns to True
        Set peDb_Type to eRC_db_SQL
        
        Set pbPX_Save_Layout to True
        Set psPX_Tag to (Label(Parent(Self)))
        
        Procedure OnAdd_ContextMenu_ReportArea Handle hoContextMenu
            Send Add_MenuItem of hoContextMenu "Process Selected Rows"  "Process_Rows"     True     
        End_Procedure
    
        Procedure OnDefine_Columns
            Send Add_Report_Column ""                 0 eRC_Integer eRC_Standard "CalEvent.Recnum"        ""
            Send Add_Report_Column "Subject"        100 eRC_String  eRC_Standard "CalEvent.Subject"       ""
            Send Add_Report_Column "Location"       100 eRC_String  eRC_Standard "CalEvent.Location"      ""
            Send Add_Report_Column "Body"           100 eRC_Text    eRC_Standard "CalEvent.Body"          ""
            Send Add_Report_Column "CreationDate"    80 eRC_Date    eRC_Standard "CalEvent.CreationDate"  ""
            Send Add_Report_Column "CreationTime"    60 eRC_String  eRC_Standard "CalEvent.CreationTime"  ""
            Send Add_Report_Column "StartDate"       80 eRC_Date    eRC_Standard "CalEvent.StartDate"     ""
            Send Add_Report_Column "StartTime"       60 eRC_String  eRC_Standard "CalEvent.StartTime"     ""
            Send Add_Report_Column "EndDate"         80 eRC_Date    eRC_Standard "CalEvent.EndDate"       "" 
            Send Add_Report_Column "EndTime"         60 eRC_String  eRC_Standard "CalEvent.EndTime"       ""
            Send Add_Report_Column "Recurr State"    60 eRC_Integer eRC_Standard "CalEvent.Recurr_State"  "If(CalEvent.Recurr_State > 0,If(CalEvent.Recurr_State = 1,'Recurring','Exception'),'')"
            Send Add_Report_Column "Meeting"         60 eRC_Integer eRC_CheckBox "CalEvent.MeetingFlag"   "If(CalEvent.MeetingFlag > 0,'True','False')"
            Send Add_Report_Column "Private"         60 eRC_Integer eRC_CheckBox "CalEvent.PrivateFlag"   "If(CalEvent.PrivateFlag > 0,'True','False')"
        End_Procedure
        
        Procedure OnProcess_Rows String sID String sProcess_Type Boolean ByRef bCancel
            Integer iRecnum
            
            Move (Integer(sID)) to iRecnum
            If (iRecnum >0 ) Begin
                Send Find_By_Recnum of oCalevent_DD CalEvent.File_Number iRecnum
            End    
        End_Procedure

        Procedure OnDouble_Click String sID
            Integer iRecnum
            
            Move (Integer(sID)) to iRecnum
            If (iRecnum >0 ) Begin
                Send Find_By_Recnum of oCalevent_DD CalEvent.File_Number iRecnum
            End    
        End_Procedure

    End_Object

    Object oCalEvent_URN is a dbForm
        Entry_Item CalEvent.URN
        Set Location to 214 31
        Set Size to 13 52
        Set Label to "URN:"
        Set Label_Justification_Mode to JMode_Right
        Set Label_Col_Offset to 2
        Set peAnchors to anBottomLeft
    End_Object

    Object oCalEvent_Subject is a dbForm
        Entry_Item CalEvent.Subject
        Set Location to 214 134
        Set Size to 13 255
        Set Label to "Subject:"
        Set Label_Justification_Mode to JMode_Right
        Set Label_Col_Offset to 2
        Set peAnchors to anBottomLeftRight
    End_Object

    Object oGroup1 is a Group
        Set Size to 29 387
        Set Location to 1 4
        Set peAnchors to anTopLeftRight

        Object oActive_Track_cb is a CheckBox
            Set Location to 12 10
            Set Size to 10 50
            Set Label to "Active Track"
        
            Procedure OnChange
                Boolean bChecked
            
                Get Checked_State to bChecked
                Set pbActive_Track of oSigCJReportControl1 to bChecked
            End_Procedure
        
        End_Object
        Object oSort_On_Group_cb is a CheckBox
            Set Size to 10 50
            Set Location to 12 72
            Set Label to "Sort On Group"
        
            Procedure OnChange
                Boolean bChecked
            
                Get Checked_State to bChecked
                Set pbGroup_Sorted_Columns of oSigCJReportControl1 to bChecked
            End_Procedure
        
        End_Object

        Object oFilter_Search_Form is a Form
            Set Size to 13 102
            Set Location to 10 278
            Set peAnchors to anBottomRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to JMode_Right
            Set Label to "Filter Search"
            
            Set Form_Button        0 to Form_Button_Prompt
            Set Form_Button_Bitmap 0 to "ieref.bmp"
            Set Prompt_Button_Mode to PB_PromptOn
            On_Key kClear Send Prompt
            On_Key kEnter Send Prompt
    
            Procedure OnChange
                String sValue
            
                Get Value to sValue
                If (Trim(sValue) = "") Begin
                    Send Filter_Rows of oSigCJReportControl1 sValue
                End    
            End_Procedure
            
            Procedure Prompt 
                String sValue
            
                Get Value to sValue
                Send Filter_Rows of oSigCJReportControl1 sValue
            End_Procedure

        End_Object

    End_Object

Cd_End_Object
