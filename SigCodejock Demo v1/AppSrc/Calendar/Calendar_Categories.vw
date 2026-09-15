//==============================================================================
// Contributions
// =============
//
// When       Who          What
// ========== ============ =====================================================
// 2009-01-09 Nick Wright  Original Implementation
//
//==============================================================================

Use DfAllEnt.pkg

Use CAL_CATS.DD
Use cSigCjPushButton.pkg
Use cSigCjLabel.pkg
Use cHexLib.Pkg
Use TrckBr.pkg
Use cSigCjColorPicker.pkg
Use DfCentry.pkg

Deferred_View Activate_oSigCjCalendarDemo_Categories_View for ;
Object oSigCjCalendarDemo_Categories_View is a dbView
    Set Border_Style to Border_Thick
    Set Size to 145 345
    Set Location to 3 4
    Set Label to "Codejock Demo - Calendar Categories"
    Set Icon to "SIG.ico" 

    
    Object oCal_Cats_DD is a Cal_Cats_DataDictionary

        Procedure OnNewCurrentRecord RowID riOldRec RowID riNewRec
            Forward Send OnNewCurrentRecord riOldRec riNewRec

            If (Operation_Mode <> Mode_Saving ) Begin
                Send ShowColors of oSigCJLabel1
                Set piSelectedColor of oCal_Cats_BorderColor  to CAL_CATS.BORDERColour
                Set piSelectedColor of oCAL_CATS_ColorLIGHT   to CAL_CATS.ColourLIGHT
                Set piSelectedColor of oCAL_CATS_ColorDARK    to CAL_CATS.ColourDARK
                Send MoveSlider
            End
       
        End_Procedure

    End_Object

    Set Main_DD to oCal_Cats_DD
    Set Server to oCal_Cats_DD

    Object oHex is a cHexLib
    End_Object

    Object oCAL_CATS_ID is a dbForm
        Entry_Item CAL_CATS.ID
        Set Location to 10 70
        Set Size to 13 38
        Set Label to "ID:"
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to JMode_Right
    End_Object

    Object oCAL_CATS_SHORT_DESC is a dbForm
        Entry_Item CAL_CATS.SHORT_DESC
        Set Location to 26 70
        Set Size to 13 102
        Set Label to "Short Description:"
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to JMode_Right
    End_Object

    Object oCAL_CATS_LONG_DESC is a dbForm
        Entry_Item CAL_CATS.LONG_DESC
        Set Location to 42 70
        Set Size to 13 246
        Set Label to "Long Description:"
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to JMode_Right
    End_Object

    Object oCAL_CATS_BORDERColor is a cSigCJColorPicker
        Set Size to 16 95
        Set Location to 58 70
        Set Transparent_State to True
        Set psCaption to "Border Color"
        #IF (SigCj_Codejock_Version < 150001) 
            Set peAppearance to OLExtpAppearanceOffice2007
        #ELSE
            Set peAppearance to OLExtpAppearanceResource
        #ENDIF 
        Set pbFlatStyle to True
        
        Procedure OnClick 
            Send Update_Cols
        End_Procedure
        
        Procedure OnKeyPress
            Send Update_Cols
        End_Procedure
        
        Procedure Update_Cols
            Integer iColor
        
            Get piSelectedColor to iColor
            Set Field_Changed_Value of oCal_Cats_DD Field CAL_CATS.BORDERColour to iColor
            Send ShowColors of oSigCJLabel1
        End_Procedure

    End_Object

    Object oCAL_CATS_ColorLIGHT is a cSigCJColorPicker
        Set Size to 16 95
        Set Location to 74 70
        Set Transparent_State to True    
        Set psCaption to "Light Color"
        #IF (SigCj_Codejock_Version < 150001) 
            Set peAppearance to OLExtpAppearanceOffice2007
        #ELSE
            Set peAppearance to OLExtpAppearanceResource
        #ENDIF 
        Set pbFlatStyle to True
            
        Procedure OnClick 
            Send Update_Cols
        End_Procedure
        
        Procedure OnKeyPress
            Send Update_Cols
        End_Procedure

        Procedure Update_Cols
            Integer iColor
        
            Get piSelectedColor to iColor
            Set Field_Changed_Value of oCal_Cats_DD Field CAL_CATS.ColourLIGHT to iColor
            Send ShowColors of oSigCJLabel1
        End_Procedure

    End_Object
            
    Object oCAL_CATS_ColorDARK is a cSigCJColorPicker
        Set Size to 16 95
        Set Location to 90 70
        Set Transparent_State to True
        Set psCaption to "Dark Color"
        Set pbFlatStyle to True
        #IF (SigCj_Codejock_Version < 150001) 
            Set peAppearance to OLExtpAppearanceOffice2007
        #ELSE
            Set peAppearance to OLExtpAppearanceResource
        #ENDIF 
            
        Procedure OnClick 
            Send Update_Cols
        End_Procedure
        
        Procedure OnKeyPress
            Send Update_Cols
        End_Procedure

        Procedure Update_Cols
            Integer iColor
        
            Get piSelectedColor to iColor
            Set Field_Changed_Value of oCal_Cats_DD Field CAL_CATS.ColourDARK to iColor
            Send ShowColors of oSigCJLabel1
        End_Procedure

    End_Object
            
    Object oCAL_CATS_GRADIENTFACTOR is a dbForm
        Entry_Item CAL_CATS.GRADIENTFACTOR
        Set Location to 109 70
        Set Size to 13 29
        Set Label to "Gradient Factor:"

        Procedure Exiting Handle hoDestination Returns Integer
            Integer iRet
            
            Forward Get msg_Exiting hoDestination to iRet
            Send ShowColors of oSigCJLabel1
            Send MoveSlider
            
            Procedure_Return iRet
        End_Procedure

    End_Object

    Object obtnSave is a Button
        Set Location to 127 119
        Set Label to "Save"
        Set peAnchors to anBottomRight
    
        Procedure OnClick
            Send Request_Save
        End_Procedure
    
    End_Object
    Object obtnClear is a Button
        Set Location to 127 177
        Set Label to "Clear"
        Set peAnchors to anBottomRight
    
        Procedure OnClick
            Send Clear
        End_Procedure
    
    End_Object
    
    Object obtnDelete is a Button
        Set Location to 127 235
        Set Label to "Delete"
        Set peAnchors to anBottomRight
    
        Procedure OnClick
            Send Request_Delete
        End_Procedure
    
    End_Object
    
    Object obtnClose is a Button
        Set Location to 127 291
        Set Label to "Close"
        Set peAnchors to anBottomRight
    
        Procedure OnClick
            Send Close_Panel
        End_Procedure
    
    End_Object

    Object oSigCJLabel1 is a cSigCJLabel
        Set Size to 52 149
        Set Location to 58 168
        Set peAnchors to anTopLeftRight
    
        Property Boolean pbCreated
    
        Procedure OnCreate
            Forward Send OnCreate
            Handle hoMarkUpContext 
            Variant vMarkUpContext vMe
            String sLabel

            Forward Send OnCreate

            Set ComEnableMarkup to True
            
            Get ComMarkupContext to vMarkUpContext
            Get Create U_cSigCjComMarkupContext to hoMarkUpContext
                Set pvComObject of hoMarkUpContext to vMarkUpContext

                Get pvComObject to vMe

                Send ComSetMethod of hoMarkUpContext vMe "MakeShapeRed"
            Send Destroy of hoMarkUpContext  
            Set pbCreated to True
            
        End_Procedure

        Procedure ShowColors
            Integer iDark iLight iBorder
            Number nGradient
            String sDark sLight sBorder sLabel
            
            If (pbCreated(Self)) Begin
                Get Field_Current_Value of oCal_Cats_DD Field CAL_CATS.ColourDARK to iDark
                Get Field_Current_Value of oCal_Cats_DD Field CAL_CATS.ColourLIGHT to iLight
                Get Field_Current_Value of oCal_Cats_DD Field CAL_CATS.BORDERColour to iBorder
                Get Field_Current_Value of oCal_Cats_DD Field CAL_CATS.GRADIENTFACTOR to nGradient
                
                Get HexColor of oHex iDark to sDark
                Get HexColor of oHex iLight to sLight
                Get HexColor of oHex iBorder to sBorder
                
                Move "<Page xmlns='http://schemas.microsoft.com/winfx/2006/xaml/presentation' xmlns:x='http://schemas.microsoft.com/winfx/2006/xaml'>" to sLabel
                Move (sLabel + '<Border BorderThickness="1" BorderBrush="'+sBorder+'" CornerRadius="5" >') to sLabel
                Move (sLabel + '	<Border.Background>') to sLabel
                Move (sLabel + '		<LinearGradientBrush StartPoint="0.5,0" EndPoint="0.5,1">') to sLabel
                Move (sLabel + '			<GradientStop Color="'+sLight+'" Offset="0"/>') to sLabel
                Move (sLabel + '			<GradientStop Color="'+sDark+'" Offset="'+String(nGradient)+'"/>') to sLabel
                Move (sLabel + '		</LinearGradientBrush>') to sLabel
                Move (sLabel + '	</Border.Background>') to sLabel
                Move (sLabel + '</Border>') to sLabel
                Move (sLabel + '</Page>') to sLabel
                  
                Set ComCaption to sLabel
            End
        End_Procedure
    
    End_Object

    Procedure Close_panel
        Set pbCreated of oSigCJLabel1 to False
        Forward Send Close_Panel
    End_Procedure


    Object oTrackBar1 is a TrackBar
        Set Size to 68 99
        Set Location to 52 318
        Set Orientation_Mode to slVert
        Set Maximum_Position to 100
        
        Set Visible_Tick_State to False
        Set pbTooltips to False
    
        //OnSetPosition is always called when the slider changes.
    
        Procedure OnSetPosition
            Number nPos
        
            Get Current_Position to nPos
            
            Set Field_Changed_Value of oCAL_CATS_DD Field CAL_CATS.GRADIENTFACTOR to (nPos/100)
            Send ShowColors of oSigCJLabel1
           
        End_Procedure
    
    End_Object

    Object oCal_Cats_Category_Set is a dbComboForm
        Entry_Item Cal_Cats.Category_Set
        Set Location to 10 160
        Set Size to 13 120
        Set Label to "Category Set:"
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to JMode_Right
    End_Object
    
    Procedure MoveSlider
        Number nPos
        Get Field_Current_Value of oCal_Cats_DD Field CAL_CATS.GRADIENTFACTOR to nPos
        Set Current_Position of oTrackBar1 to (nPos*100)
    End_Procedure

Cd_End_Object
