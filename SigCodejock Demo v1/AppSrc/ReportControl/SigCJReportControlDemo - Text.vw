Use Windows.pkg
Use Dfclient.pkg
Use DFEntry.pkg
Use cSigCjReportControl.pkg
Use cSigCJContextMenu.pkg
Use cSigCJMenuItem.pkg

Deferred_View Activate_SigCjReportControlDemo_Text_View for ;
Object SigCjReportControlDemo_Text_View is a dbView
    Set Border_Style to Border_Thick
    Set Size to 250 400
    Set Location to 2 2
    Set Maximize_Icon to True
    Set Label to "Codejock Demo - Report Control - Text File"
    Set Icon to "SIG.ico"
        
    Object oSigCJReportControl1 is a cSigCJReportControl
        Set Size to 174 382
        Set Location to 33 7
        Set peAnchors to anAll
        Set peDb_Type to eRC_db_Text
        Set pbActive_Track to True
        Set pbPX_Save_Layout to True
        Set psPX_Tag to (Label(Parent(Self)))

        Procedure OnAdd_ContextMenu_ReportArea Handle hoContextMenu
            Send Add_MenuItem of hoContextMenu "Process Selected Rows"  "Process_Rows"     True     
        End_Procedure

        Procedure OnDefine_Columns
            Send Add_Report_Column "Date"         60 eRC_Date    eRC_Standard "" ""
            Send Add_Report_Column "Time"         60 eRC_String  eRC_Standard "" ""
            Send Add_Report_Column "User"        120 eRC_String  eRC_Standard "" ""
            Send Add_Report_Column "Workstation" 200 eRC_String  eRC_Standard "" ""
            Send Add_Report_Column "Ip Addess"   160 eRC_String  eRC_Standard "" ""
            Send Add_Report_Column "Error No."    60 eRC_String  eRC_Standard "" ""
            Send Add_Report_Column "Error Line"   80 eRC_Integer eRC_Standard "" ""
            Send Add_Report_Column "Error Text"  300 eRC_Text    eRC_Standard "" ""
        End_Procedure

        //---------------------------------------------------------------------

        Procedure OnOpen_DataSource
            //Hook - open data source here

            Integer iCh_No
            String sLine sPath

            Get psHome of (phoWorkspace(ghoApplication)) to sPath
            
            Get Seq_New_Channel to iCh_No
            Set piCh_No to iCh_No

            Direct_Input channel iCh_No (sPath - "\Data\Error.log")

            Readln channel iCh_No sLine        //Skip header rows
            Readln channel iCh_No sLine
            Set pbEOF to (SeqEof)
        End_Procedure

        Procedure OnPrepare_RowData
            //Hook - Set up row data ( Send Add_Item_Data for each column )

            Integer iCh_No iLoop iColumn_Count
            String  sLine
            
            Get piCh_No     to iCh_No
            Get piColumn_Count to iColumn_Count

            Readln channel iCh_No sLine
            If (SeqEof) Begin
                Set pbEOF to True
            End
            Else Begin
                Send Add_Item_Data (Mid(sLine,                    10,   1)) //Date       
                Send Add_Item_Data (Mid(sLine,                     8,  12)) //Time       
                Send Add_Item_Data (Mid(sLine,                    11,  21)) //User       
                Send Add_Item_Data (Mid(sLine,                    19,  33)) //Workstation
                Send Add_Item_Data (Mid(sLine,                    15,  53)) //Ip Addess  
                Send Add_Item_Data (Mid(sLine,                     5,  75)) //Error No.  
                Send Add_Item_Data (Mid(sLine,                     7,  96)) //Error Line 
                Send Add_Item_Data (Mid(sLine, (Length(sLine) - 105), 106)) //Error Text 
            End            
        End_Procedure

        Procedure OnClose_DataSource
            //Hook - safe to close data source here

            Integer iCh_No 
            Get piCh_No to iCh_No

            Close_Input channel iCh_No
            Send Seq_Release_Channel iCh_No
        End_Procedure

        //---------------------------------------------------------------------

        Procedure OnProcess_Rows String sID
            //Showln "OnProcess_Rows : " sID
        End_Procedure

        Procedure OnDouble_Click String sID
            //Showln "Click Click : " sID
        End_Procedure

        Procedure OnActive_Track String sID
            Set value of oActive_Track_Row to sID
        End_Procedure
        
        Procedure OnAfter_Load_Data
            //Showln "Rows: " (piRow_Count(Self)) " Time taken: " (ptsTimeSpan_Load(Self)) " SQL Exe " (ptsTimeSpan_SQL(Self))
        End_Procedure

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

    Object oActive_Track_Row is a Form
        Set Location to 214 31
        Set Size to 13 52
        Set Label to "Row"
        Set Label_Justification_Mode to JMode_Right
        Set Label_Col_Offset to 2
        Set peAnchors to anBottomLeft
    End_Object

    Object oButton1 is a Button
        Set Location to 217 343
        Set Label to "ReLoad"
        Set peAnchors to anBottomRight
    
        // fires when the button is clicked
        Procedure OnClick
            Send Reset_Data_Properties of oSigCJReportControl1
            Send Rebuild_Report        of oSigCJReportControl1
        End_Procedure
    
    End_Object

Cd_End_Object
