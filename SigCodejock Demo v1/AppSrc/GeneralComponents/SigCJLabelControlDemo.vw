Use Windows.pkg
Use DFClient.pkg
Use cSigCjLabel.pkg

Deferred_View Activate_oSIGCJLabelControlDemo_View for ;
Object oSIGCJLabelControlDemo_View is a dbView

    Set Border_Style to Border_Thick
    Set Size to 200 300
    Set Location to 2 2
    Set Maximize_Icon to True
    Set Label to "Codejock Demo - Label Control {xaml}"
    Set Icon to "SIG.ico"
    
    Function Read_xaml String sFileName Returns String
        String  sRetval  sLine
        Boolean bExists
        Integer iChannel
    
        File_Exist sFileName bExists
        If (not(bExists)) Begin
            Function_Return "Error:- File not found" 
        End
    
        Get Seq_New_Channel to iChannel
    
        Direct_Input channel iChannel sFileName
        If (SeqEof) Begin
            Close_Input channel iChannel
            Send Seq_Release_Channel iChannel
            Function_Return "Error:- File has no data"
        End

        While (not(SeqEof))
            Readln channel iChannel sLine
            Move (Append(sRetval,sLine)) to sRetval
        Loop
        If (SeqEof) Begin
            Close_Input channel iChannel
        End
        
        Send Seq_Release_Channel iChannel
        Function_Return sRetval
    End_Function    

    Object oFileName_Form is a Form
        Set Label to "xaml File"
        Set Size to 13 207
        Set Location to 9 35
        Set Prompt_Button_Mode to pb_PromptOn
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to JMode_Right
        // Set peAnchors to anTopBottomLeft

        Procedure Prompt
            Handle hoOpenDialog hoWorkspace
            Boolean bSave
            String sHomePath
        
            Get phoWorkspace of oApplication to hoWorkspace 
            Get psHome       of hoWorkspace  to sHomePath 
            
            Get Create U_OpenDialog to hoOpenDialog
            If (hoOpenDialog) Begin
                Set Initial_Folder of hoOpenDialog to (sHomePath + 'Markup')
                Set Filter_String  of hoOpenDialog to "xaml (*.xaml)|*.xaml"
        
                Get Show_Dialog of hoOpenDialog to bSave
                If (bSave) Begin
                    Set Value to (File_Name(hoOpenDialog))
                End
                Send Destroy of hoOpenDialog
            End
        End_Procedure  // Prompt

    End_Object    // oFileName_Form

    Object oButton1 is a Button
        Set Size to 14 35
        Set Location to 8 253
        Set Label to "Load"
    
        Procedure OnClick
            String sFileName sValue
            
            Get Value of oFileName_Form to sFileName
            Get Read_xaml sFileName to sValue
            Set ComCaption of oSigCJLabel1 to sValue
        End_Procedure
    
    End_Object

    Object oSigCJLabel1 is a cSigCJLabel // cComMarkupContext
        Set Size to 250 400
        Set Location to 32 6
        Set peAnchors to anAll
    
        Set pbEnableMarkup to True

        Procedure OnCreate
            Forward Send OnCreate
            Handle hoMarkUpContext 
            Variant vMarkUpContext vMe

            Forward Send OnCreate
            
            Get ComMarkupContext to vMarkUpContext
            Get Create U_cSigCjComMarkupContext to hoMarkUpContext
                Set pvComObject of hoMarkUpContext to vMarkUpContext

                Get pvComObject to vMe

                Send ComSetMethod of hoMarkUpContext vMe "MakeShapeRed"
                Send ComSetMethod of hoMarkUpContext vMe "MakeShapeGreen"
                Send ComSetMethod of hoMarkUpContext vMe "ToggleNextControl"
                Send ComSetMethod of hoMarkUpContext vMe "MakeTextBold" 
                Send ComSetMethod of hoMarkUpContext vMe "MakeTextNormal" 
                Send ComSetMethod of hoMarkUpContext vMe "MakeTextYellow" 
                Send ComSetMethod of hoMarkUpContext vMe "MakeTextGreen" 
                Send ComSetMethod of hoMarkUpContext vMe "MoveColumn3"
                Send ComSetMethod of hoMarkUpContext vMe "SetText1" 
                Send ComSetMethod of hoMarkUpContext vMe "SetText2"
                Send ComSetMethod of hoMarkUpContext vMe "AboutBox"
            Send Destroy of hoMarkUpContext  
                          
            Set ComCaption of oSigCJLabel1 to "<TextBlock>Click <Hyperlink'http://www.vdfsig.co.uk'>this</Hyperlink>Link</TextBlock>"
            //Set ComCaption of oSigCJLabel1 to "<TextBlock>Click <Hyperlink Click='http://www.donorflex.com'>this</Hyperlink>Link</TextBlock>"
        End_Procedure
    
        Procedure MakeShapeRed
            Send Info_Box "Hello MakeShapeRed"
        End_Procedure

        Procedure MakeShapeGreen
            Send Info_Box "Hello MakeShapeGreen"
        End_Procedure
    
    End_Object

Cd_End_Object
