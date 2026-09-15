Use Windows.pkg
Use DFClient.pkg
Use cSigCjCheckBox.pkg
Use cSigCjPushButton.pkg
Use dfallent.pkg
Use CheckBox.DD
Use DFEntry.pkg
Use DFEnChk.pkg

Deferred_View Activate_oSigCJCheckBoxDemo_View for ;
Object oSigCJCheckBoxDemo_View is a dbView

    Set Size to 183 238
    Set Location to 14 30
    Set Label to "Codejock Demo - Tri-State Checkbox"
    Set Icon to "SIG.ico"

    Object oCheckbox_DD is a Checkbox_DataDictionary
    End_Object

    Set Main_DD to oCheckbox_DD
    Set Server to oCheckbox_DD

    Procedure Request_Clear
        Forward Send Request_Clear
        
        Send Reset of oBound
    End_Procedure

    Procedure Request_Clear_All
        Forward Send Request_Clear_All
        
        Send Reset of oBound
    End_Procedure
    
    Object oUnbound is a Group
        Set Size to 77 226
        Set Location to 3 5
        Set Label to "Unbond"

        //---------------------------------------------------------------------

        Object oCB_YNG is a cSigCJCheckBox
            Set Size to 18 80
            Set Location to 19 20
            Set psCaption to "No Yes Grayed"
            Set psFalse to "N"
            Set psGrayed to "G"
            Set psTrue to "Y"
                    
            Procedure OnChange
                Set Value of oCB_YNG_Value to (psValue(Self))
            End_Procedure
        End_Object

        Object oCB_YNG_Value is a Form
            Set Size to 13 33
            Set Location to 21 176
            Set Label to "Data Value"
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to JMode_Right
        End_Object

        //---------------------------------------------------------------------

        Object oCB_TFU is a cSigCJCheckBox
            Set Size to 17 100
            Set Location to 40 20
            Set psCaption to "False True"
            Set psFalse to "F"
            Set psTrue to "T"
            Set pbTriState to False
            
            Procedure OnChange
                Set Value of oCB_TFU_Value to (psValue(Self))
            End_Procedure
        End_Object

        Object oCB_TFU_Value is a Form
            Set Size to 13 35
            Set Location to 42 176
            Set Label to "Data Value"
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to JMode_Right
        End_Object

        //---------------------------------------------------------------------

    End_Object

    Object oBound is a dbGroup
        Set Size to 91 223
        Set Location to 86 7
        Set Label to "Data Aware"

        Procedure Reset
            Set Value of oCB_Check_Box_Field_Value to ""
            Set Value of oCB_String_Field_Value to ""
        End_Procedure

        Object oCheckBox_ID is a dbForm
            Entry_Item CheckBox.ID
            Set Location to 18 19
            Set Size to 13 18
            Set Label to "ID"
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to JMode_Right
        End_Object

        //---------------------------------------------------------------------

        Object oCB_Check_Box_Field is a cSigCJdbCheckBox
            Entry_Item CheckBox.Check_Box_Field
            Set Size to 18 101
            Set Location to 34 20
            Set psCaption to "Check Box Field"
                    
            Procedure OnChange
                Set Value of oCB_Check_Box_Field_Value to (psValue(Self))
            End_Procedure
        End_Object

        Object oCB_Check_Box_Field_Value is a Form
            Set Size to 13 33
            Set Location to 36 176
            Set Label to "Control Value"
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to JMode_Right
        End_Object

        //---------------------------------------------------------------------

        Object oCB_String_Field is a cSigCJdbCheckBox
            Entry_Item CheckBox.String_Field
            Set Size to 17 100
            Set Location to 55 20
            Set psCaption to "String Field"
            Set psFalse to "X"
            Set psGrayed to "Y"
            Set psTrue to "Z"
        
            Procedure OnChange
                Set Value of oCB_String_Field_Value to (psValue(Self))
            End_Procedure
        End_Object

        Object oCB_String_Field_Value is a Form
            Set Size to 13 35
            Set Location to 57 176
            Set Label to "Control Value"
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to JMode_Right
        End_Object

        //---------------------------------------------------------------------
    End_Object

Cd_End_Object
