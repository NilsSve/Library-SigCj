Use Windows.pkg
Use DFClient.pkg
Use cSigCJPopupControl.pkg

Deferred_View Activate_oSigCJPopupControlDemo_View for ;
Object oSigCJPopupControlDemo_View is a dbView

    Set Border_Style to Border_Thick
    Set Size to 200 300
    Set Location to 11 5
    Set Label to "Codejock Demo - Popup Control"
    Set Icon to "SIG.ico"

    Object oShowMessageBar_Bn is a Button
        Set Location to 55 95
        Set Size to 13 100
        Set Label to "Show Message Bar"
    
        Procedure OnClick
            Send ShowMessageBar of ghoCommandBars  "Hello World" "Educ 2010"         
        End_Procedure
    End_Object

    Object oPopupControl1_bn is a Button
        Set Location to 100 95
        Set Size to 13 100
        Set Label to "Show Popup Control 1"
    
        Procedure OnClick
            Handle hoItem
            // Must reset to get a clean start            
            Send Reset of oSigCJPopupControl1
            // Add Images and Text Items to the popup control
            Get Add_Image_Item of oSigCJPopupControl1  7  7 24 24 5001 to hoItem
            Get Add_Text_Item  of oSigCJPopupControl1 33 12 160 40 "You've got mail!" True to hoItem
            // Set any font properties 
            Set pbBold         of hoItem to True
            Set pbItalic       of hoItem to True
            Set psFontName     of hoItem to "Calibri"
            Set pnFontSize     of hoItem to 11  
            // Now tell it to popup
            Send Popup of oSigCJPopupControl1
        End_Procedure
    End_Object

    Object oPopupControl2_bn is a Button
        Set Location to 120 95
        Set Size to 13 100
        Set Label to "Show Popup Control 2"
    
        Procedure OnClick
            Handle hoItem
            // Must reset to get a clean start
            Send Reset of oSigCJPopupControl1
            // Add Images and Text Items to the popup control
            Get Add_Image_Item of oSigCJPopupControl1  7  7 24 24 5002 to hoItem
            Get Add_Text_Item  of oSigCJPopupControl1 33 12 160 40 "You've got Calender Items!" True to hoItem
            // Now tell it to popup
            Send Popup of oSigCJPopupControl1
        End_Procedure
    End_Object

    Object oSigCJPopupControl1 is a cSigCJPopupControl

        #IF (SigCj_Codejock_Version < 150001) 
            Set pPopupControlTheme to OLExtpPopupThemeOffice2007
        #ELSE    
            Set pPopupControlTheme to OLExtpPopupThemeResource
        #ENDIF 
        
         Procedure Load_Images
            Integer iImage
            
            Get AddImage "icon1_24.bmp" 0 0 to iImage
            Get AddImage "icon2_24.bmp" 0 0 to iImage
            Get AddImage "icon3_24.bmp" 0 0 to iImage
        End_Procedure 
    
        Procedure OnClick Integer iItem
            Send Info_Box ("You Click item" * String(iItem))
        End_Procedure //OnClick
    End_Object

Cd_End_Object
