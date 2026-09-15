Use Windows.pkg
Use DFClient.pkg
Use Cal_Date.DD
Use dfTable.pkg
Use Colr_dlg.pkg

//Use cSigCJdbForm.pkg

Deferred_View Activate_oSigCJCalendarDemo_Special_Dates_View for ;
Object oSigCJCalendarDemo_Special_Dates_View is a dbView
    Set Border_Style to Border_Thick
    Set Size to 200 460
    Set Location to 2 2
    Set Label to "Codejcok Demo - Calendar Special Dates"
    Set piMinSize to 200 460
    Set Maximize_Icon to True
    Set Icon to "SIG.ico" 
        
    Object oCal_Date_DD is a Cal_Date_DataDictionary
    End_Object

    Set Main_DD to oCal_Date_DD
    Set Server to oCal_Date_DD


    Object oColorDialog is a ColorDialog

        Function SelectColor Returns Integer
            Integer iRgbColor bColorSelected
        
            Get Show_Dialog to bColorSelected
            If (bColorSelected = True) Begin
                Get SelectedColor to iRgbColor
            End
        
            Function_Return iRgbColor
        End_Function // SelectColor

    End_Object    // oColorDialog

    Object oDbGrid1 is a dbGrid
        Set Size to 192 452
        Set Location to 4 4

        Begin_Row
            Entry_Item cal_date.Date_From
            Entry_Item cal_date.Date_To
            Entry_Item cal_date.Title
            Entry_Item cal_date.BackColour
            Entry_Item cal_date.AllDay
            Entry_Item cal_date.AllowEvents
        End_Row

        Set Main_File to cal_date.File_number

        Set Form_Width 0 to 60
        Set Header_Label 0 to "Date From"
        Set Form_Button        0  to Form_Button_Prompt
        Set Form_Button_Bitmap 0  to "CalendarPrompt.Bmp"        
        Set Form_Width 1 to 60
        Set Header_Label 1 to "Date To"
        Set Form_Button        1  to Form_Button_Prompt
        Set Form_Button_Bitmap 1  to "CalendarPrompt.Bmp"
        Set Form_Width 2 to 160
        Set Header_Label 2 to "Title"
        Set Form_Width 3 to 48
        Set Header_Label 3 to "BackColor"
        Set Column_Button 3 to Form_Button_Prompt
        Set Form_Width 4 to 60
        Set Header_Label 4 to "All Day"
        Set Column_Checkbox_State 4 to True
        Set Form_Width 5 to 60
        Set Header_Label 5 to "Allow Events"
        Set Column_Combo_State 5 to True
        Set pbEmbeddedPrompts to True
        Set pbReverseOrdering to True
        Set peAnchors to anAll
        Set Ordering to 1
        
        Procedure Activating Returns Integer 
            Integer iRetval
            Forward Get msg_Activating to iRetval
            Send Beginning_of_Data
            Procedure_Return iRetval
        End_Procedure
        
//        Procedure Prompt
//            Integer iRBG
//            Get SelectColor of oColorDialog to iRBG
//            Set Field_Changed_Value of oCal_Date_DD Field cal_date.BackColor to iRBG
//        End_Procedure // Prompt
        
        Procedure Prompt
            Integer iBase_Item iCurrent_Item
            Integer iRBG 
        
            Forward Send Prompt
                
            Get Base_Item     to iBase_Item
            Get Current_Item  to iCurrent_Item
                
            If (iBase_Item+3) eq iCurrent_Item Begin
                // Send Info_Box "Hello Color prompt"
                Get SelectColor of oColorDialog to iRBG
                Set Field_Changed_Value of oCal_Date_DD Field cal_date.BackColour to iRBG
            End
        End_Procedure // Prompt

    End_Object

Cd_End_Object
