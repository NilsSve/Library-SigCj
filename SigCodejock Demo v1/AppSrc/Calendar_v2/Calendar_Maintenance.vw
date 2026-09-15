//=============================================================================
// Project      : SigCj - VDF Classes for Codejock
// File         : Calendar_Maintenance.vw
// Description  : VDF Class for Codejock control
//
// Revision     : $Rev: $
//                $Date: $
//                $Author: $
//
// Requirements : Visual DataFlex 14.1+
//                Codejock SuitePro - Version 13.4.0+
//
// Copyright    : Copyright © 2009-2012 VDF SIG UK, All rights reserved.
//                Visual DataFlex Special Interest Group UK.
//                http://www.vdfsig.co.uk/
//
//                This file is part of SigCj.
//
//                SigCj is free software: you can redistribute it and/or modify
//                it under the terms of the GNU Lesser General Public License
//                as published by the Free Software Foundation, either version
//                2.1 of the License, or (at your option) any later version.
//
//                SigCj is distributed in the hope that it will be useful, but
//                WITHOUT ANY WARRANTY; without even the implied warranty of
//                MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//                GNU Lesser General Public License for more details.
//
//                If you have the complete SigCj workspace then a copy of the
//                GNU Lesser General Public License is in the Docs folder. If
//                not, see <http://www.gnu.org/licenses/>.
//
//=============================================================================
Use Windows.pkg
Use dfallent.pkg
Use dfTabDlg.pkg
Use Colr_dlg.pkg
Use cHexLib.Pkg
Use cDbCJGrid.pkg
Use cSigCJLabel.pkg
Use cSigCJPushButton.pkg
Use cSigCJColorPicker.pkg
Use cDbCJGridColumn.pkg

Use cC_PropsDataDictionary.dd
Use cC_CategDataDictionary.dd
Use cC_SchedDataDictionary.dd
Use cC_LayoutDataDictionary.dd
Use cC_spDateDataDictionary.dd

Deferred_View Activate_oCalendar_Maintenance_View for ;
Object oCalendar_Maintenance_View is a dbView

    Set Border_Style to Border_Thick
	Set Size to 200 450
    Set Location to 2 2
    Set Maximize_Icon to True
    Set Icon to "SIG.ico"
    Set Label to "Calendar Maintenance"

    Set Verify_Data_Loss_Msg to 0
    Set Verify_Exit_Msg      to 0
    Set piMinSize to 200 450

    Object oCalendar_Maintenance_dbTabDialogView is a dbTabDialogView
        Set Size to 176 441
        Set Location to 4 4
        Set peAnchors to anAll

        Object oProperties_dbTabView is a dbTabView
            Set Size to 200 150
            Set Location to 0 0
            Set Label to 'Properties'
            Set peAnchors to anAll
            
            Object oC_Props_DD is a cC_PropsDataDictionary 
            End_Object
            
            Set Main_DD to oC_Props_DD
            Set Server  to oC_Props_DD 
            
            Object oProperties_dbGroup is a dbGroup 
                Set Size to 152 427
                Set Location to 4 4
                Set peAnchors to anAll
                
                Object oc_Props_ptmWorkDayStartTime is a dbForm
                    Entry_Item c_Props.WkDayStartTime
                    Set Location to 10 90
                    Set Size to 13 36
                    Set Label to "Work Start Time:"            
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to JMode_Right
                End_Object
        
                Object oc_Props_ptmWorkDayEndTime is a dbForm
                    Entry_Item c_Props.WkDayEndTime
                    Set Location to 26 90
                    Set Size to 13 36
                    Set Label to "Work End Time:"            
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to JMode_Right
                End_Object
            
                Object ocProps_pbShadeLunchTime is a dbCheckbox
                    Entry_Item c_Props.ShadeLunchTime
                    Set Location to 50 90
                    Set Size to 10 60
                    Set Label to "Show Lunch Time"
                End_Object // ocProps_pbShadeLunchTime 
    
                Object oc_Props_ptmLunchStartTime is a dbForm
                    Entry_Item c_Props.LunchStartTime
                    Set Location to 66 90
                    Set Size to 13 36
                    Set Label to "Lunch Start Time:"
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to JMode_Right
                End_Object
    
                Object oc_Props_ptmLunchEndTime is a dbForm
                    Entry_Item c_Props.LunchEndTime
                    Set Location to 82 90
                    Set Size to 13 36
                    Set Label to "Lunch End Time:"
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to JMode_Right
                End_Object
    
                Object oc_Props_ptmLastWorkDayEndTime is a dbForm
                    Entry_Item c_Props.LastWkDayEndTim
                    Set Location to 130 90
                    Set Size to 13 36
                    Set Label to "Short Day Finish Time:"
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to JMode_Right
                End_Object  
                
                Object ocProps_pbShorterLastDay is a dbCheckbox
                    Entry_Item c_Props.ShorterLastDay
                    Set Location to 114 90
                    Set Size to 10 60
                    Set Label to "Early Finish Friday"
                End_Object // ocProps_pbShorterLastDay
                
            End_Object // oProperties_dbGroup
                        
        End_Object // oProperties_dbTabView

        Object oCategories_dbTabView is a dbTabView
            Set Label to "Categories"
            
            Object oC_Categ_DD is a cC_CategDataDictionary
                Procedure Request_Find Integer eFindMode Integer iFile Integer iIndex
                    Forward Send Request_Find eFindMode iFile iIndex
                    
                    If (Found) Begin
                        Send mUpdate_Display 
                    End
                End_Procedure                
            End_Object     
        
            Set Main_DD to oC_Categ_DD
            Set Server  to oC_Categ_DD
            
            Object oCategories_dbGroup is a dbGroup 
                Set Size to 152 427
                Set Location to 4 4
                Set peAnchors to anAll
                
                Object oC_CategLongDesc is a dbForm
                    Entry_Item C_Categ.Description
                    Set Size to 13 345
                    Set Location to 10 50
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to JMode_Right
                    Set peAnchors to anLeftRight
                    Set Label to "Description"
                End_Object // oC_CategLongdesc
                
                Object oCategBorderColor_cSigCJColorPicker is a cSigCJColorPicker
                    Set Size to 16 95
                    Set Location to 37 11
                    Set psCaption to "Border Colour"
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
                        Set Field_Changed_Value of oC_Categ_DD Field C_Categ.BorderColor to iColor
                        Send ShowColors of oCateg_cSigCJLabel
                    End_Procedure
                End_Object oCategBorderColor_cSigCJColorPicker

                Object oCategColorLight_cSigCJColorPicker is a cSigCJColorPicker
                    Set Size                to 16 95
                    Set Location to 55 11
                    Set psCaption           to "Light Colour"
                    Set pbFlatStyle         to True
                
                    Procedure OnClick 
                        Send Update_Cols
                    End_Procedure
                    
                    Procedure OnKeyPress
                        Send Update_Cols
                    End_Procedure
                
                    Procedure Update_Cols
                        Integer iColor
                    
                        Get piSelectedColor to iColor
                        Set Field_Changed_Value of oC_Categ_DD Field C_Categ.ColorLight to iColor
                        Send ShowColors of oCateg_cSigCJLabel
                    End_Procedure
                End_Object // oCategColorLight_cSigCJColorPicker
                        
                Object oCategColordark_cSigCJColorPicker is a cSigCJColorPicker    
                    Set Size                to 16 95
                    Set Location to 73 11
                    Set psCaption           to "Dark Colour"
                    Set pbFlatStyle         to True
                
                    Procedure OnClick 
                        Send Update_Cols
                    End_Procedure
                    
                    Procedure OnKeyPress
                        Send Update_Cols
                    End_Procedure
                
                    Procedure Update_Cols
                        Integer iColor
                    
                        Get piSelectedColor to iColor
                        Set Field_Changed_Value of oC_Categ_DD Field C_Categ.ColorDark to iColor
                        Send ShowColors of oCateg_cSigCJLabel
                    End_Procedure
                End_Object // oCategColordark_cSigCJColorPicker

                Object cCategGradientfactor_dbForm is a dbForm
                    Entry_Item C_Categ.Gradientfactor
                    Set Size                        to 13 36
                    Set Location to 92 69
                    Set Label                       to "Gradient Factor"
                
                    Procedure Exiting Handle hoDestination Returns Integer
                        Integer iRetval
                        
                        Forward Get msg_Exiting hoDestination to iRetval
                        Send ShowColors of oCateg_cSigCJLabel
                        Send MoveSlider
                        
                        Procedure_Return iRetval
                    End_Procedure
                End_Object // oC_CategGradientfactor
                
                Object oCateg_cSigCJLabel is a cSigCJLabel
                    Set Size to 109 280
                    Set Location to 38 112
                    Set peAnchors to anAll        
                            
                    Property Boolean pbCreated
                        
                    Object oHex is a cHexLib
                    End_Object
                
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
                    End_Procedure // OnCreate
                
                    Procedure ShowColors
                        Integer iDark iLight iBorder
                        Number nGradient
                        String sDark sLight sBorder sLabel
                        
                        If (pbCreated(Self)) Begin
                            Get Field_Current_Value of oC_Categ_DD Field C_Categ.ColorDark      to iDark
                            Get Field_Current_Value of oC_Categ_DD Field C_Categ.ColorLight     to iLight
                            Get Field_Current_Value of oC_Categ_DD Field C_Categ.BorderColor    to iBorder
                            Get Field_Current_Value of oC_Categ_DD Field C_Categ.GradientFactor to nGradient
                            
                            Get HexColor of oHex iDark   to sDark
                            Get HexColor of oHex iLight  to sLight
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
                    End_Procedure // ShowColors
                End_Object // oCateg_cSigCJLabel
                
                Object oCateg_TrackBar is a TrackBar
                    Set Size to 110 20
                    Set Location to 38 397
                    Set Orientation_Mode to slVert
                    Set Maximum_Position to 100
                    Set peAnchors to anTopBottomRight
                    
                    Set Visible_Tick_State to False
                    Set pbTooltips to False
                    
                    Procedure OnSetPosition
                        Number nPos
                    
                        Get Current_Position to nPos
                        
                        Set Field_Changed_Value of oC_Categ_DD Field C_Categ.GradientFactor to (nPos/100)
                        Send ShowColors of oCateg_cSigCJLabel
                    End_Procedure
                End_Object // oCateg_TrackBar
                
            End_Object // oCategories_dbGroup

            Procedure MoveSlider
                Number nPos
                
                Get Field_Current_Value of oC_Categ_DD Field C_Categ.GradientFactor to nPos
                Set Current_Position of oCateg_TrackBar to (nPos*100)
            End_Procedure 
            
            Procedure mUpdate_Display        
                Send ShowColors of oCateg_cSigCJLabel
                Set piSelectedColor of oCategBorderColor_cSigCJColorPicker to C_Categ.BorderColor
                Set piSelectedColor of oCategColorLight_cSigCJColorPicker  to C_Categ.ColorLight
                Set piSelectedColor of oCategColordark_cSigCJColorPicker   to C_Categ.ColorDark
                Send MoveSlider                    
            End_Procedure

        End_Object // oCategories_dbTabView

        Object oSchedules_dbTabView is a dbTabView
            Set Label to "Schedules"

            Object oC_Sched_DD is a cC_SchedDataDictionary
            End_Object // oC_Sched_DD
            
            Set Main_DD to oC_Sched_DD
            Set Server  to oC_Sched_DD  

            Object oSchedules_dbCJGrid is a cdbCJGrid
                Set Size to 151 425
                Set Location to 5 5
                Set peVerticalGridStyle      to xtpGridNoLines
                Set pbShadeSortColumn        to True
                Set peAnchors to anAll
                Set Server to oC_Sched_DD
                Set Ordering to 2
            
                Object oURN_dbCJGridColumn is a cdbCJGridColumn
                    Entry_Item c_Sched.URN
                    Set piWidth to 0
                    Set psCaption to "URN"
                    Set pbVisible to False
                    Set pbShowInFieldChooser to False
                End_Object
            
                Object oName_dbCJGridColumn is a cdbCJGridColumn
                    Entry_Item c_Sched.Name
                    Set piWidth to 205
                    Set psCaption to "Name"
                End_Object

                Object oDataType_dbCJGridColumn is a cdbCJGridColumn
                    Entry_Item c_Sched.DataType
                    Set piWidth to 123
                    Set psCaption to "Data Type"
                    Set peTextAlignment to xtpAlignmentLeft
                    Set pbComboButton to True
                End_Object
            
                Object oDataSource_ascdbCJGridColumn is a cdbCJGridColumn
                    Entry_Item c_Sched.DataSource
                    Set piWidth to 309
                    Set psCaption to "Data Source"
                End_Object

                Object oc_Sched_Shade_Color is a cDbCJGridColumn
                    Entry_Item c_Sched.Shade_Color
                    Set piWidth to 72
                    Set psCaption to "Shade Color"
                End_Object
            
            End_Object // oSchedules_dbCJGrid
        End_Object // oSchedules_dbTabView

        Object oLayouts_dbTabView is a dbTabView
            Set Label to "Layouts"
            Set Verify_Save_msg to (RefFunc(No_Confirmation))
            
            Object oC_Sched_DD is a cC_SchedDataDictionary
            End_Object
        
            Object oC_Categ_DD is a cC_CategDataDictionary 
            End_Object
        
            Object oC_Layout_DD is a cC_LayoutDataDictionary
                
                Procedure OnNewCurrentRecord RowID riOldRec RowID riNewRec
                    Forward Send OnNewCurrentRecord riOldRec riNewRec
        
                    Send mUpdate_Grids
//                    If (Operation_Mode <> Mode_Saving ) Begin
//                        Send mUpdate_Grids 
//                    End
                End_Procedure
            End_Object // oC_Layout_DD
        
            Set Main_DD to oC_Layout_DD
            Set Server to oC_Layout_DD
            
            Object oLayouts_dbGroup is a dbGroup 
                Set Size to 152 427
                Set Location to 4 4
                Set peAnchors to anAll
                
                Object oC_Layout_Name_dbForm is a dbForm
                    Entry_Item C_Layout.Name
                    Set Location to 10 40
                    Set Size to 13 332
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to JMode_Right
                    Set Label to "Name"
                End_Object
            
                Object oShedule_TextBox is a TextBox
                    Set Auto_Size_State to False
                    Set Size to 12 200
                    Set Location to 26 9
                    Set Label to "Schedules"
                    Set Color to 14995904
                    Set Justification_Mode to (JMode_VCenter+JMode_Center)
                End_Object        
            
                Object oC_Layout_Schedules_dbForm is a dbForm
                    Entry_Item C_Layout.Schedules
                    Set Visible_State to False 
                    Set Enabled_State to False 
                    Set Size to 13 100
                    Set Location to 10000 10000
                End_Object // oC_Layout_Schedules
            
                Object oC_Layout_Categories_dbForm is a dbForm
                    Entry_Item C_Layout.Categories
                    Set Visible_State to False 
                    Set Enabled_State to False 
                    Set Size to 13 100
                    Set Location to 10000 10000
                End_Object // oC_Layout_Categories 
                        
                Object oCategory_TextBox is a TextBox
                    Set Auto_Size_State to False
                    Set Size to 12 200
                    Set Location to 26 217
                    Set Label to "Categories"
                    Set Color to 14995904
                    Set Justification_Mode to (JMode_VCenter+JMode_Center)
                End_Object  
                
                Object oSched_DbCJGrid is a cDbCJGrid
                    Set Server to oC_Sched_DD
                    Set Size to 109 200
                    Set Location to 38 9
                    Set peVerticalGridStyle      to xtpGridNoLines
                    Set pbShadeSortColumn        to True
                    Set pbAllowAppendRow to False
                    Set pbAllowColumnRemove to False
                    Set pbAllowColumnReorder to False
                    Set pbAllowColumnResize to False
                    Set pbAllowDeleteRow to False
                    Set pbAllowInsertRow to False
                    Set pbAutoAppend to False
                    Set pbHeaderReorders to True
                    Set pbStaticData to True
                    Set peAnchors to anTopBottom
                    Set Verify_Save_msg to (RefFunc(No_Confirmation))

                
                    Object oC_Sched_URN_cDbCJGridColumn is a cDbCJGridColumn
                        Entry_Item C_Sched.URN
                        Set piWidth to 36
                        Set psCaption to "URN"
                        Set pbEditable to False
                        Set pbVisible to False
                        Set pbShowInFieldChooser to False
                    End_Object // oC_Sched_URN
            
                    Object oC_Sched_Name_cDbCJGridColumn is a cDbCJGridColumn
                        Entry_Item C_Sched.Name
                        Set piWidth to 274
                        Set psCaption to "Name"
                        Set pbEditable to False
                    End_Object // oC_Sched_Name
                    
                    Object oSched_CheckBox_DbCJGridColumn is a cDbCJGridColumn
                        Set piWidth to 26
                        Set psCaption to ""
                        Set pbCheckbox to True
                        
                        Procedure OnSetCalculatedValue String ByRef sValue
                            Integer   iPos iItem iID 
                            String    sList sCheck_Value

                            Get SelectedRowValue of oC_Sched_URN_cDbCJGridColumn to iID
                            
                            Move (Trim(C_Layout.Schedules)) to sList
                            Move (Pos(",",sList)) to iPos
                            While (iPos > 0)
                                Move (Left(sList,(iPos -1))) to iItem
                                If (iItem = iID) Move 1 to sCheck_Value 
                                Move (Right(sList,(Length(sList)-iPos))) to sList
                                Move (Pos(",",sList)) to iPos
                            Loop
                            //Don't forget the last item
                            If (sList <> "") Begin
                                If (sList = iID) Move 1 to sCheck_Value
                            End
                            If (sValue <> sCheck_Value) Move sCheck_Value to sValue 
                        End_Procedure // OnSetCalculatedValue String ByRef sValue

    
                        Procedure OnEndEdit String sOldValue String sNewValue
                            Integer iPos iVerify_Save_Msg
                            String  sData sItem 
                            
                            Forward Send OnEndEdit sOldValue sNewValue
                    
                            Get DataForCell of (phoDataSource(Self)) (SelectedRow(phoDataSource(Self))) 0 to sItem
                    
                            Get Value of oC_Layout_Schedules_dbForm to sData
                            If (sNewValue = 0) Begin
                                Move (","-sData-",") to sData
                                Move (Replace((","-sItem-","),sData,",")) to sData
                                Move (Mid(sData,(length(sData) -2),2)) to sData
                            End
                            Else Begin
                                If (sData <> "") Append sData "," 
                                Append sData sItem
                            End
                            Set Field_Changed_Value    of oC_Layout_DD Field c_Layout.Schedules to sData
                            Send Request_Save_No_Clear of oC_Layout_DD
                            Send Update_Check_Boxes
                        End_Procedure // OnEndEdit String sOldValue String sNewValue
                    End_Object // oSched_CheckBox_DbCJGridColumn
                               
                    Procedure Update_Check_Boxes
                        Integer[] iaSelected
                        Integer   iPos iRowCount iRow iItem iSize
                        String    sList sValue 
                        tDataSourceRow[] DataSource
                
                        Move (Trim(C_Layout.Schedules)) to sList
                        Move (Pos(",",sList)) to iPos
                        While (iPos > 0)
                            Move (Left(sList,(iPos -1))) to iItem
                            Move 1 to iaSelected[iItem]
                            Move (Right(sList,(Length(sList)-iPos))) to sList
                            Move (Pos(",",sList)) to iPos
                        Loop
                        //Don't forget the last item
                        If (sList <> "") Begin
                            Move 1 to iaSelected[sList]
                        End    
                  
                        Get piRowCount of (phoDataSource(Self)) to iRowCount
                        Get pDataSource of (phoDataSource(Self)) to DataSource
                        
                        Move (SizeOfArray(iaSelected)) to iSize
                        For iRow from 0 to (iRowCount -1)
                            Move DataSource[iRow].sValue[0] to iItem
                            Move 0 to DataSource[iRow].sValue[2]
                            If ((iSize-1) >= iItem) Begin
                                If (iaSelected[iItem] = 1) Move 1 to DataSource[iRow].sValue[2]     
                            End
                        Loop            
                        Set pDataSource of (phoDataSource(Self)) to DataSource
                        If (IsComObjectCreated(Self)) Begin
                            Send ReSynchToDataSource
                        End
                    End_Procedure // Update_Check_Boxes        
                End_Object // oSched_DbCJGrid
                
                Object oCateg_cdbCJGrid is a cdbCJGrid
                    Set Server to oC_Categ_DD
                    Set Size to 109 200
                    Set Location to 38 217
                    Set peVerticalGridStyle      to xtpGridNoLines
                    Set pbShadeSortColumn        to True
                    Set pbAllowAppendRow to False
                    Set pbAllowColumnRemove to False
                    Set pbAllowColumnReorder to False
                    Set pbAllowColumnResize to False
                    Set pbAllowDeleteRow to False
                    Set pbAllowInsertRow to False
                    Set pbAutoAppend to False
                    Set pbHeaderReorders to True
                    Set pbStaticData to True
                    Set peAnchors to anTopBottom
                    Set Verify_Save_msg to (RefFunc(No_Confirmation))
                    
                    Object oC_Categ_ID_cDbCJGridColumn is a cDbCJGridColumn
                        Entry_Item C_Categ.ID
                        Set piWidth to 36
                        Set psCaption to "ID"
                        Set pbEditable to False
                        Set pbVisible to False
                        Set pbShowInFieldChooser to False
                    End_Object // oC_Categ_ID
            
                    Object oC_Categ_Desc_cDbCJGridColumn is a cDbCJGridColumn
                        Entry_Item C_Categ.Description
                        Set piWidth to 274
                        Set psCaption to "Description"
                        Set pbEditable to False
                    End_Object // oC_Categ_ShortDesc
                    
                    Object oCat_CheckBox_cdbCJGridColumn is a cdbCJGridColumn
                        Set piWidth to 26
                        Set psCaption to ""
                        Set pbCheckbox to True
                    
                        Procedure OnSetCalculatedValue String ByRef sValue
                            Integer   iPos iItem iID 
                            String    sList sCheck_Value

                            Get SelectedRowValue of oC_Categ_ID_cDbCJGridColumn to iID
                            
                            Move (Trim(C_Layout.Categories)) to sList
                            Move (Pos(",",sList)) to iPos
                            While (iPos > 0)
                                Move (Left(sList,(iPos -1))) to iItem
                                If (iItem = iID) Move 1 to sCheck_Value 
                                Move (Right(sList,(Length(sList)-iPos))) to sList
                                Move (Pos(",",sList)) to iPos
                            Loop
                            //Don't forget the last item
                            If (sList <> "") Begin
                                If (sList = iID) Move 1 to sCheck_Value
                            End
                            If (sValue <> sCheck_Value) Move sCheck_Value to sValue 
                        End_Procedure // OnSetCalculatedValue String ByRef sValue

                        Procedure OnEndEdit String sOldValue String sNewValue
                            Integer iPos iVerify_Save_Msg
                            String  sData sItem 
                            
                            Forward Send OnEndEdit sOldValue sNewValue
                    
                            Get DataForCell of (phoDataSource(Self)) (SelectedRow(phoDataSource(Self))) 0 to sItem
                    
                            Get Value of oC_Layout_Categories_dbForm to sData
                            If (sNewValue = 0) Begin
                                Move (","-sData-",") to sData
                                Move (Replace((","-sItem-","),sData,",")) to sData
                                Move (Mid(sData,(length(sData) -2),2)) to sData
                            End
                            Else Begin
                                If (sData <> "") Append sData "," 
                                Append sData sItem
                            End
                            Set Field_Changed_Value    of oC_Layout_DD Field c_Layout.Categories to sData
                            Send Request_Save_No_Clear of oC_Layout_DD
                            Send Update_Check_Boxes
                        End_Procedure // OnEndEdit String sOldValue String sNewValue
                    End_Object // oCat_CheckBox
                            
                    Procedure Update_Check_Boxes
                        Integer[] iaSelected
                        Integer   iPos iRowCount iRow iItem iSize
                        String    sList sValue
                        tDataSourceRow[] DataSource
                        
                        Move (Trim(C_Layout.Categories)) to sList
                        Move (Pos(",",sList)) to iPos
                        While (iPos > 0)
                            Move (Left(sList,(iPos -1))) to iItem
                            Move 1 to iaSelected[iItem]
                            Move (Right(sList,(Length(sList)-iPos))) to sList
                            Move (Pos(",",sList)) to iPos
                        Loop
                        //Don't forget the last item
                        If (sList <> "") Begin
                            Move 1 to iaSelected[sList]
                        End    
                
                        Get piRowCount of (phoDataSource(Self)) to iRowCount
                        Get pDataSource of (phoDataSource(Self)) to DataSource
                
                        Move (SizeOfArray(iaSelected)) to iSize
                        For iRow from 0 to (iRowCount -1)
                            Move DataSource[iRow].sValue[0] to iItem
                            Move 0 to DataSource[iRow].sValue[2]
                            If ((iSize-1) >= iItem) Begin
                                If (iaSelected[iItem] = 1) Move 1 to DataSource[iRow].sValue[2]     
                            End
                        Loop            
                        Set pDataSource of (phoDataSource(Self)) to DataSource
                        If (IsComObjectCreated(Self)) Begin
                            Send ReSynchToDataSource
                        End
                    End_Procedure // Update_Check_Boxes
                End_Object // oCateg_cdbCJGrid            

            End_Object // oLayouts_dbGroup
            
            Procedure mUpdate_Grids
                Send Update_Check_Boxes of oSched_dbCJGrid
                Send Update_Check_Boxes of oCateg_cdbCJGrid
            End_Procedure

        End_Object // oLayouts_dbTabView

        Object oSpecial_Days_dbTabView is a dbTabView
            Set Label to "Special Days"
            
            Object oC_spDate_DD is a cC_spDateDataDictionary
            End_Object

            Set Main_DD to oC_spDate_DD
            Set Server to oC_spDate_DD
            
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


            Object oSpecial_Days_dbCJGrid is a cDbCJGrid
                Set Size to 150 425
                Set Location to 5 5
                Set peVerticalGridStyle      to xtpGridNoLines
                Set pbShadeSortColumn        to True
                Set peAnchors to anAll
                Set Ordering to 1

                Object oc_spDate_Date_From is a cDbCJGridColumn
                    Entry_Item c_spDate.Date_From
                    Set piWidth to 72
                    Set psCaption to "Date From"
                    Set Prompt_Button_Mode to PB_PromptOn
                End_Object

                Object oc_spDate_Date_To is a cDbCJGridColumn
                    Entry_Item c_spDate.Date_To
                    Set piWidth to 72
                    Set psCaption to "Date To"
                    Set Prompt_Button_Mode to PB_PromptOn
                End_Object

                Object oc_spDate_Description is a cDbCJGridColumn
                    Entry_Item c_spDate.Description
                    Set piWidth to 120
                    Set psCaption to "Description"
                End_Object

                Object oc_spDate_BackColor is a cDbCJGridColumn
                    Entry_Item c_spDate.BackColor
                    Set piWidth to 65
                    Set psCaption to "BackColor"
                    Set Prompt_Button_Mode to PB_PromptOn
                    
                    Procedure Prompt 
                        Integer iRBG 
                        Get SelectColor of oColorDialog to iRBG
                        Set Field_Changed_Value of oC_Spdate_DD Field C_spDate.BackColor to iRBG
                    End_Procedure
                    
                End_Object // oc_spDate_BackColor

                Object oc_spDate_ShadeStyle is a cDbCJGridColumn
                    Entry_Item c_spDate.ShadeStyle
                    Set piWidth to 160
                    Set psCaption to "ShadeStyle"
                    Set pbComboButton to True
                End_Object

                Object oc_spDate_AllowEvents is a cDbCJGridColumn
                    Entry_Item c_spDate.AllowEvents
                    Set piWidth to 73
                    Set psCaption to "AllowEvents"
                    Set pbComboButton to True
                End_Object
                
            End_Object // oSpecial_Days_dbCJGrid

        End_Object // oSpecial_Days_dbTabView

        Procedure Request_Switch_To_Tab Integer iTab Integer iPointerMode                        
            Integer iCurrent_Tab 
            Handle  hoTabPage
            Boolean bChecked
            
            Forward Send Request_Switch_To_Tab iTab iPointerMode
            
            // Test if the page switch was successful
            Get Current_Tab to iCurrent_Tab
            If (iCurrent_Tab = iTab) Begin
                Get Tab_page_id iCurrent_Tab to hoTabPage            
                Case Begin
                    Case (hoTabPage = oLayouts_dbTabView)
                        Send mUpdate_Grids of oLayouts_dbTabView 
                    Case Break
                Case End                
            End
        End_Procedure        
        
    End_Object // oCalendar_Maintenance_dbTabDialogView

    Object oClose_Button is a cSigCJPushButton
        Set Location to 183 396
        Set Label to "Close"
        Set psImage to "ActionDelete.ico" 
        Set peAnchors to anBottomRight
    
        Procedure OnClick
            Send Close_Panel            
        End_Procedure
    
    End_Object // oClose_Button

Cd_End_Object
