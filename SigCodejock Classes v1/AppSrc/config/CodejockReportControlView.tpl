Use Windows.pkg
Use DFClient.pkg

DEFERRED_VIEW Activate_oNewView FOR ;
Object oNewView is a dbView

    Set Border_Style to Border_Thick
    Set Size to 200 400
    Set Location to 2 1
    Set Label to "Codejock Report Control View"
    Set Maximize_Icon to True
    
    Object oFilter_Group is a Group
        Set Size to 29 392
        Set Location to 0 4 
    
        Object oFilter_Search_Form is a Form
            Set Size to 13 100
            Set Location to 10 60
            Set peAnchors to anTopLeft
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

    End_Object // oFilter_Group  
    
CD_End_Object
