Use Windows.pkg
Use DFClient.pkg
Use cSigCJPushButton.pkg 

Deferred_View Activate_oSigCJPushButtonDemo_View for ;
Object oSigCJPushButtonDemo_View is a dbView
    Set Label to "Codejock Demo - Push Buttons"
    Set Border_Style to Border_Thick
    Set Size to 200 300
    Set Location to 2 2
    Set Icon to "SIG.ico"

    Object oSigCJPushButton1 is a cSigCJPushButton
        Set Location to 20 95
        Set Size to 15 100
        Set Label to "Standard && Cool"
        Set psToolTip to "Standard & Cool" 
        
        Set peStyle to OLExtpButtonDropDownRight
        
        Procedure OnClick
            Send Info_Box "You pushed me!"
        End_Procedure
    End_Object

    Object oSigCJPushButton2 is a cSigCJPushButton
        Set Location to 40 95
        Set Size to 15 100
        Set Label to "Office 2003"
        Set peAppearance to OLExtpAppearanceOffice2003
        Set psImage to "icon1_24.bmp"
        Set peTextImageRelation to OLExtpImageBeforeText
        
        Procedure OnClick
            Set TextColor of oSigCJPushButton3 to clGreen
            Send Info_Box "You pushed me!"
        End_Procedure
    End_Object

    Object oSigCJPushButton3 is a cSigCJPushButton
        Set Location to 60 95
        Set Size to 33 100
        Set Label to "Office 2007"
        
        #IF (SigCj_Codejock_Version < 150001) 
            Set peAppearance to OLExtpAppearanceOffice2007
        #ELSE
            Set peAppearance to OLExtpAppearanceResource
        #ENDIF 

        Set psImage to "icon1_24.bmp"
        Set peTextImageRelation to OLExtpImageAboveText
        Set peImageAlignment to OLExtpAlignCenter
        Set peTextAlignment to OLExtpAlignCenter
        Set Color to clInactiveCaptionText
        Set TextColor to clRed
        Set piBackColor to clSilver
        Set psCaption to "Office 2007"
        Set pbPointer_Only to True 
        
        Procedure OnClick
            Send Info_Box "You pushed me!"
        End_Procedure
    End_Object

    Object oButton1 is a Button
        Set Location to 100 120
        Set Label to "Close"
    
        // fires when the button is clicked
        Procedure OnClick
            Send close_panel
        End_Procedure
    End_Object

Cd_End_Object
