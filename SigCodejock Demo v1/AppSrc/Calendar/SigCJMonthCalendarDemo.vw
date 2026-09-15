Use Windows.pkg
Use DFClient.pkg
Use Sysfile1.DD
Use DFEntry.pkg
Use SigCJMonthCalendar.sl
Use dfSpnFrm.pkg
Use cSigCJdbForm.pkg 

Deferred_View Activate_oSigCJMonthCalendarDemo_View for ;
Object oSigCJMonthCalendarDemo_View is a dbView
    Set Border_Style to Border_Thick
    Set Size to 144 288
    Set Location to 22 11
    Set Icon to "SIG.ico"
    Set Label to "Codejock Demo - Month Calendar"

    Set Verify_Data_Loss_Msg to 0
    Set Verify_Exit_Msg      to 0
    Set piMinSize to 144 288
    
    Object oSysfile1_DD is a Sysfile1_DataDictionary
        Set Auto_Fill_State to True
        Set In_Use_State to True
    End_Object

    Set Main_DD to oSysfile1_DD
    Set Server to oSysfile1_DD

    Object oDate_Form is a cSigCjdbForm
        Entry_Item Sysfile1.System_Date
        Set Location to 57 39
        Set Size to 13 66
        Set Label to "Date"
        Set Label_Col_Offset to 5
        Set Label_Justification_Mode to JMode_Right

        Procedure Prompt
            Send ApplySettings 
            Forward Send Prompt
        End_Procedure
    End_Object

    Object oGroup1 is a Group
        Set Size to 136 155
        Set Location to 4 129
        Set Label to "Calendar Settings"
        Set peAnchors to anTopBottomRight

        Object oMonthColumns is a SpinForm
            Set Size to 13 63
            Set Location to 14 59
            Set Label to "Month Columns"
            Set Label_Col_Offset to 3
            Set Label_Justification_Mode to JMode_Right
            Set Maximum_Position to 12
            Set Minimum_Position to 1
            Set Value to "1"
        End_Object

        Object oMonthRows is a SpinForm
            Set Size to 13 63
            Set Location to 30 59
            Set Label_Justification_Mode to JMode_Right
            Set Label_Col_Offset to 3
            Set Label to "Month Rows"
            Set Minimum_Position to 1
            Set Maximum_Position to 12
            Set Value to "1"
        End_Object

        Object oShowToday is a CheckBox
            Set Size to 10 50
            Set Location to 50 59
            Set Label to "Show Today"
            Set Checked_State to True
        End_Object

        Object oShowWeekNumbers is a CheckBox
            Set Size to 10 81
            Set Location to 66 59
            Set Label to "Show Week Numbers"
            Set Checked_State to True
        End_Object

        Object oShowButtons is a CheckBox
            Set Size to 10 81
            Set Location to 82 59
            Set Label to "Show Buttons"
            Set Checked_State to True
        End_Object

        Object oHideBorder is a CheckBox
            Set Size to 10 81
            Set Location to 98 59
            Set Label to "Hide Border"
            Set Checked_State to True
        End_Object

        Object oStartOfWeek is a ComboForm
            Set Size to 13 59
            Set Location to 114 59
            Set Label to "Start Of Week"
            Set Label_Justification_Mode to JMode_Right
            Set Label_Col_Offset to 3
            Set Combo_Sort_State to False
        
            Procedure Combo_Fill_List
                Send Combo_Add_Item "Sunday"
                Send Combo_Add_Item "Monday"
                Send Combo_Add_Item "Tuesday"
                Send Combo_Add_Item "Wednesday"
                Send Combo_Add_Item "Thursday"
                Send Combo_Add_Item "Friday"
                Send Combo_Add_Item "Saturday"
            End_Procedure
        
        End_Object
    End_Object

    Procedure ApplySettings
        Handle hoCalendar
        String sDay 
        Integer iMonthColumns iMonthRows iStartOfWeek
        Boolean bShowWeekNumbers bShowToday bShowButtons bHideBorder
        
        Get phoMonthCalendar of oSigCJMonthCalendar_Lookup to hoCalendar
        If (hoCalendar <> 0) Begin
            Get value of oStartOfWeek to sDay
            Move 6 to iStartOfWeek
            If (sDay = "Sunday") Begin
                Move 6 to iStartOfWeek
            End
            Else If (sDay = "Monday") Begin
                Move 7 to iStartOfWeek
            End
            Else If (sDay = "Tuesday") Begin
                Move 1 to iStartOfWeek
            End
            Else If (sDay = "Wednesday") Begin
                Move 2 to iStartOfWeek
            End
            Else If (sDay = "Thursday") Begin
                Move 3 to iStartOfWeek
            End
            Else If (sDay = "Friday") Begin
                Move 4 to iStartOfWeek
            End
            Else If (sDay = "Saturday") Begin
                Move 5 to iStartOfWeek
            End
            Get Checked_State of oShowToday       to bShowToday
            Get Checked_State of oShowWeekNumbers to bShowWeekNumbers
            Get Checked_State of oShowButtons     to bShowButtons
            Get Checked_State of oHideBorder      to bHideBorder
            Get value         of oMonthColumns    to iMonthColumns
            Get Value         of oMonthRows       to iMonthRows
            
            Set pbShowWeekNumbers of hoCalendar to bShowWeekNumbers
            Set pbShowToday       of hoCalendar to bShowToday
            Set pbShowButtons     of hoCalendar to bShowButtons 
            Set pbHideBorder      of hoCalendar to bHideBorder
            Set piStartOfWeek     of hoCalendar to iStartOfWeek
            Set piMonthColumns    of hoCalendar to iMonthColumns
            Set piMonthRows       of hoCalendar to iMonthRows     
            
            Set piMaxSelCount of hoCalendar to -1
            Set pbMultiSelect of hoCalendar to True
        End
    End_Procedure
    
Cd_End_Object
