//=============================================================================
// Project      : SigCj - VDF Classes for Codejock
// File         : Calendar_Demo.vw
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
Use DFClient.pkg
Use DFTabDlg.pkg
Use cSigCJLabel.pkg
Use cSigCJColorPicker.pkg

//If dialogs compiled first OnRegisterDialogs will automatically set the handle 
//properties if the demo names are used
Use Calendar_v2\SigCjCalendar_Event.dg
Use Calendar_v2\SigCjCalendar_Event_Schedules.dg
Use Calendar_v2\SigCjCalendar_TimeScale.dg
Use Calendar_v2\SigCjCalendar_MinWidth.dg
Use Calendar_v2\SigCjCalendar_Reorder.dg
Use Calendar_v2\SigCjCalendar_Series.dg
Use Calendar_v2\SigCjCalendar_DB_Link.dg
Use Calendar_v2\SigCjCalendar_Properties.dg
Use Calendar_v2\SigCjCalendar_Icons.dg

Use cSigCjCalendar_Control_v2.pkg
Use cSigCjCalendar_DatePicker_v2.pkg

Use cC_CategDataDictionary.dd
Use cC_SchedDataDictionary.dd
Use cC_LayoutDataDictionary.dd

Define C_Layout_Staff   for 1
Define C_Layout_Meeting for 2

Activate_View Activate_oCalendar_Demo_View for oCalendar_Demo_View
Object oCalendar_Demo_View is a dbView
    Set Label to "Calendar Demo"
    Set Size to 309 477
    Set Location to 5 7
    Set Maximize_Icon to True
    Set Border_Style to Border_Thick

    Object oTabDialog is a dbTabDialogView
        Set Size to 301 468
        Set Location to 5 5
        Set Rotate_Mode to RM_Rotate
        Set peAnchors to anAll
        
        //=====================================================================

        Object oSimple is a dbTabView
            Set Label to "Simple"

            Object oSimple_Calendar is a cSigCJCalendar_Control_v2
                Set Size to 281 291
                Set Location to 2 2
                Set peAnchors to anAll
                Set pbEnableDB_Link to True
                Set pbDB_Link_OnClick to False
                Set pbEnableCustomIcons to True
                Set pbEnableCustomProperties to True

                
                #Include Calendar_v2\cSigCJCalendar_Standard_Tables.pkg
        
                Procedure OnCreate_DataProvider
                    //Do Nothing - we will use the auto created default
                End_Procedure
                
                Procedure OnLoadIcons
                    Send Load_Icon 10 "Con_All_16.ico" 
                    Send Load_Icon 11 "Con_Act_16.ico" 
                    Send Load_Icon 12 "Con_Ter_16.ico" 
                    Send Load_Icon 22 "Gear_16.ico" 
                    Send Load_Icon 23 "Grid_16.ico" 
                    Send Load_Icon 24 "Grids_16.ico" 
                End_Procedure
        
                Procedure OnCreate_Categories
                    tdSigCjCal_Category     tCategory
                    
                    Move 1          to tCategory.iID
                    Move "Holiday"  to tCategory.sName
                    Move clRed      to tCategory.iBorderColor
                    Move clAqua     to tCategory.iColor_1
                    Move clAqua     to tCategory.iColor_2
                    Move 0.75       to tCategory.nGradient
                    Send Create_Category tCategory
        
                    Move 2                  to tCategory.iID
                    Move "Internal Meeting" to tCategory.sName
                    Move clLime             to tCategory.iBorderColor
                    Move clYellow           to tCategory.iColor_1
                    Move clYellow           to tCategory.iColor_2
                    Move 0.75               to tCategory.nGradient
                    Send Create_Category  tCategory
        
                    Move 3                to tCategory.iID
                    Move "Client Meeting" to tCategory.sName
                    Move clBlue           to tCategory.iBorderColor
                    Move clGreen          to tCategory.iColor_1
                    Move clGreen          to tCategory.iColor_2
                    Move 0.75             to tCategory.nGradient
                    Send Create_Category  tCategory
                End_Procedure
            End_Object

            Object oSimple_DatePicker is a cSigCJCalendar_DatePicker_v2
                Set Size to 105 135
                Set Location to 2 325
                Set peAnchors to anTopRight
        
                Set phoCalendar to oSimple_Calendar
            End_Object

            Object oSimple_Properties is a Container3d
                Set Size to 157 165
                Set Location to 125 296
                Set Border_Style to Border_None
                Set peAnchors to anTopBottomRight
        
                #Replace zzCal_Object oSimple_Calendar
                #Include Calendar_v2\oSigCjCalendar_Properties.pkg
            End_Object
        End_Object

        //=====================================================================

        Object oCustom_Dialog is a dbTabView
            Set Label to "Custom Dialogs"

            Procedure Activating
                Forward Send Activating
        
                Set Value of oCustom_Dialogs to "Built-In Dialogs"
            End_Procedure

            Object oCustom_Calendar is a cSigCJCalendar_Control_v2
                Set Size to 281 291
                Set Location to 2 2
                Set peAnchors to anAll
                Set pbEnableDB_Link to True
                Set pbDB_Link_OnClick to False
                Set pbEnableCustomIcons to True
                Set pbEnableCustomProperties to False
                
                #Include Calendar_v2\cSigCJCalendar_Standard_Tables.pkg
        
                Procedure OnCreate_DataProvider
                    //Do Nothing - we will use the auto created default
                End_Procedure
        
                Procedure OnRegisterDialogs
                    Set phoDialog_NewEvent          to oSigCjCalendar_Event_Panel
                    Set phoDialog_EditEvent         to oSigCjCalendar_Event_Panel
                    Set phoDialog_Series            to oSigCjCalendar_Series_Panel
                    //Set phoDialog_EditRecurrence    to oSigCjCalendar_Recurring
                    Set phoDialog_MinWidth          to oSigCjCalendar_MinWidth_Panel
                    Set phoDialog_TimeScale         to oSigCjCalendar_TimeScale_Panel
                    Set phoDialog_Reorder           to oSigCjCalendar_Reorder_Panel
                    Set phoDialog_DB_Link           to oSigCjCalendar_DB_Link_Panel
                    Set phoDialog_CustomProperties  to oSigCjCalendar_CustomProperties_Panel
                    Set phoDialog_CustomIcons       to oSigCjCalendar_CustomIcons_Panel
                End_Procedure
        
                Procedure OnLoadIcons
                    Send Load_Icon 10 "Con_All_16.ico" 
                    Send Load_Icon 11 "Con_Act_16.ico" 
                    Send Load_Icon 12 "Con_Ter_16.ico" 
                    Send Load_Icon 22 "Gear_16.ico" 
                    Send Load_Icon 23 "Grid_16.ico" 
                    Send Load_Icon 24 "Grids_16.ico" 
                End_Procedure
        
                Procedure OnCreate_Categories
                    tdSigCjCal_Category     tCategory
                    
                    Move 1          to tCategory.iID
                    Move "Holiday"  to tCategory.sName
                    Move clRed      to tCategory.iBorderColor
                    Move clAqua     to tCategory.iColor_1
                    Move clAqua     to tCategory.iColor_2
                    Move 0.75       to tCategory.nGradient
                    Send Create_Category tCategory
        
                    Move 2                  to tCategory.iID
                    Move "Internal Meeting" to tCategory.sName
                    Move clLime             to tCategory.iBorderColor
                    Move clYellow           to tCategory.iColor_1
                    Move clYellow           to tCategory.iColor_2
                    Move 0.75               to tCategory.nGradient
                    Send Create_Category  tCategory
        
                    Move 3                to tCategory.iID
                    Move "Client Meeting" to tCategory.sName
                    Move clBlue           to tCategory.iBorderColor
                    Move clGreen          to tCategory.iColor_1
                    Move clGreen          to tCategory.iColor_2
                    Move 0.75             to tCategory.nGradient
                    Send Create_Category  tCategory
                End_Procedure
            End_Object
            
            Object oCustom_DatePicker is a cSigCJCalendar_DatePicker_v2
                Set Size to 105 135
                Set Location to 2 325
                Set peAnchors to anTopRight
        
                Set phoCalendar to oCustom_Calendar
            End_Object

            Object oCustom_Dialogs is a ComboForm
                Set Size to 13 80
                Set Location to 109 381
                Set peAnchors to anTopRight
        
                Procedure Combo_Fill_List
                    // Fill the combo list with Send Combo_Add_Item
                    Send Combo_Add_Item "Built-In Dialogs"
                    Send Combo_Add_Item "Custom Dialogs"
                End_Procedure
            
                Procedure OnChange
                    String sValue
                
                    Get Value to sValue // the current selected item
                    If (sValue = "Built-In Dialogs") Begin
                        Set phoDialog_NewEvent       of oCustom_Calendar to 0
                        Set phoDialog_EditEvent      of oCustom_Calendar to 0
                        Set phoDialog_EditRecurrence of oCustom_Calendar to 0
                    End
                    Else Begin
                        Send OnRegisterDialogs of oCustom_Calendar 
                    End
                End_Procedure
            
            End_Object

            Object oCustom_Properties is a Container3d
                Set Size to 157 165
                Set Location to 125 296
                Set Border_Style to Border_None
                Set peAnchors to anTopBottomRight
        
                #Replace zzCal_Object oCustom_Calendar 
                #Include Calendar_v2\oSigCjCalendar_Properties.pkg
            End_Object
        End_Object

        //=====================================================================

        Object oSingle_Layout is a dbTabView
            Set Label to "Single Layout"

            Procedure Activating
                Forward Send Activating
        
                Set Value of oSingle_Dialogs to "Built-In Dialogs"
            End_Procedure
        
            Object oSingle_Calendar is a cSigCJCalendar_Control_v2
                Set Size to 281 291
                Set Location to 2 2
                Set peAnchors to anAll
                Set pbEnableDB_Link to True
                Set pbDB_Link_OnClick to False
                Set pbEnableCustomIcons to True
                Set pbEnableCustomProperties to True
                Set pbEnableResources to True
                
                #Include Calendar_v2\cSigCJCalendar_Standard_Tables.pkg
        
                Procedure OnRegisterDialogs
                    Set phoDialog_NewEvent          to oSigCjCalendar_Event_Schedules_Panel
                    Set phoDialog_EditEvent         to oSigCjCalendar_Event_Schedules_Panel
                    Set phoDialog_Series            to oSigCjCalendar_Series_Panel
                    //Set phoDialog_EditRecurrence    to oSigCjCalendar_Recurring_Panel
                    Set phoDialog_MinWidth          to oSigCjCalendar_MinWidth_Panel
                    Set phoDialog_TimeScale         to oSigCjCalendar_TimeScale_Panel
                    Set phoDialog_Reorder           to oSigCjCalendar_Reorder_Panel
                    Set phoDialog_DB_Link           to oSigCjCalendar_DB_Link_Panel
                    Set phoDialog_CustomProperties  to oSigCjCalendar_CustomProperties_Panel
                    Set phoDialog_CustomIcons       to oSigCjCalendar_CustomIcons_Panel
                End_Procedure

                Procedure OnLoadIcons
                    Send Load_Icon 10 "Con_All_16.ico" 
                    Send Load_Icon 11 "Con_Act_16.ico" 
                    Send Load_Icon 12 "Con_Ter_16.ico" 
                    Send Load_Icon 22 "Gear_16.ico" 
                    Send Load_Icon 23 "Grid_16.ico" 
                    Send Load_Icon 24 "Grids_16.ico" 
                End_Procedure
        
                Procedure OnLoadLayout
                    tdSigCjCal_Category     tCategory
                    tdSigCjCal_DataProvider tDataProvider
                    tdSigCjCal_Schedule     tSchedule
                    tdSigCjCal_Resource     tResource
                    tdSigCjCal_Layout       tLayout
        
                    //-----------------------------------------------------------------
                    //Data Providers - None needed as the default will be used
        
                    //-----------------------------------------------------------------
                    //Categories

                    Move 1          to tCategory.iID
                    Move "Holiday"  to tCategory.sName
                    Move clRed      to tCategory.iBorderColor
                    Move clYellow   to tCategory.iColor_1
                    Move clBlue     to tCategory.iColor_2
                    Move 0.50       to tCategory.nGradient
                    Send Create_Category tCategory
        
                    Move 2                  to tCategory.iID
                    Move "Internal Meeting" to tCategory.sName
                    Move 16155007           to tCategory.iBorderColor
                    Move 16155007           to tCategory.iColor_1
                    Move 11664639           to tCategory.iColor_2
                    Move 10                 to tCategory.nGradient
                    Send Create_Category  tCategory
        
                    Move 3                to tCategory.iID
                    Move "Client Meeting" to tCategory.sName
                    Move clBlue           to tCategory.iBorderColor
                    Move 12314304         to tCategory.iColor_1
                    Move 7917443          to tCategory.iColor_2
                    Move 10               to tCategory.nGradient
                    Send Create_Category  tCategory
                    
                    //-----------------------------------------------------------------
                    //Schedules
                    
                    Move 1     to tSchedule.iID
                    Move "Ian" to tSchedule.sName
                    Move ""    to tSchedule.sProperties
                    Send Create_Schedule tSchedule
                    Send Apply_Category tSchedule.iID 1
                    Send Apply_Category tSchedule.iID 2
                    Send Apply_Category tSchedule.iID 3
                    
                    Move 2        to tSchedule.iID
                    Move "Martin" to tSchedule.sName
                    Move ""       to tSchedule.sProperties
                    Send Create_Schedule tSchedule
                    Send Apply_Category tSchedule.iID 1
                    Send Apply_Category tSchedule.iID 2
                    Send Apply_Category tSchedule.iID 3
        
                    Move 3      to tSchedule.iID
                    Move "Paul" to tSchedule.sName
                    Move ""     to tSchedule.sProperties
                    Send Create_Schedule tSchedule
                    Send Apply_Category tSchedule.iID 1
                    Send Apply_Category tSchedule.iID 2
                    Send Apply_Category tSchedule.iID 3
        
                    //-----------------------------------------------------------------
                    //Resources
        
                    Move 1        to tResource.iID
                    Move "Martin" to tResource.sName
                    Send Create_Resource tResource
                    Send Apply_Schedule  tResource.iID 2
        
                    Move 2      to tResource.iID
                    Move "Ian"  to tResource.sName
                    Send Create_Resource tResource
                    Send Apply_Schedule  tResource.iID 1
        
                    Move 3      to tResource.iID
                    Move "Paul" to tResource.sName
                    Send Create_Resource tResource
                    Send Apply_Schedule  tResource.iID 3
        
                    //-----------------------------------------------------------------
                    //Layouts
                    
                    Move C_Layout_Staff to tLayout.iID
                    Move "All Staff"    to tLayout.sName
                    Send Create_Layout tLayout
                    Send Apply_Resource tLayout.iID 1 True
                    Send Apply_Resource tLayout.iID 2 True
                    Send Apply_Resource tLayout.iID 3 True
        
                    Send Apply_Layout C_Layout_Staff
                End_Procedure
            End_Object

            Object oSingle_DatePicker is a cSigCJCalendar_DatePicker_v2
                Set Size to 105 135
                Set Location to 2 325
                Set peAnchors to anTopRight
        
                Set phoCalendar to oSingle_Calendar
            End_Object

            Object oSingle_Dialogs is a ComboForm
                Set Size to 13 80
                Set Location to 109 381
                Set peAnchors to anTopRight
        
                Procedure Combo_Fill_List
                    Send Combo_Add_Item "Built-In Dialogs"
                    Send Combo_Add_Item "Custom Dialogs"
                End_Procedure
            
                Procedure OnChange
                    String sValue
                
                    Get Value to sValue // the current selected item
                    If (sValue = "Built-In Dialogs") Begin
                        Set phoDialog_NewEvent       of oSingle_Calendar to 0
                        Set phoDialog_EditEvent      of oSingle_Calendar to 0
                        Set phoDialog_EditRecurrence of oSingle_Calendar to 0
                    End
                    Else Begin
                        Send OnRegisterDialogs of oSingle_Calendar
                    End
                End_Procedure
            
            End_Object

            Object oSingle_Properties is a Container3d
                Set Size to 157 165
                Set Location to 125 296
                Set Border_Style to Border_None
                Set peAnchors to anTopBottomRight
        
                #Replace zzCal_Object oSingle_Calendar 
                #Include Calendar_v2\oSigCjCalendar_Properties.pkg
            End_Object
        End_Object

        //=====================================================================

        Object oMultiple_Layouts is a dbTabView
            Set Label to "Multiple Layouts"

            Procedure Activating
                Forward Send Activating
        
                Set Value of oMulti_Dialogs to "Built-In Dialogs"
            End_Procedure

            Object oMulti_Calendar is a cSigCJCalendar_Control_v2
                Set Size to 281 291
                Set Location to 2 2
                Set peAnchors to anAll
                Set pbEnableDB_Link to True
                Set pbDB_Link_OnClick to False
                Set pbEnableCustomIcons to True
                Set pbEnableCustomProperties to True
                Set pbEnableResources to True
                Set pbEnable_ShadeResources to True
                Set pbMultipleSchedulesMode to True
                Set pbDialogAllSchedulesMode to True
                
                #Include Calendar_v2\cSigCJCalendar_Standard_Tables.pkg
        
                Procedure OnRegisterDialogs
                    Set phoDialog_NewEvent          to oSigCjCalendar_Event_Schedules_Panel
                    Set phoDialog_EditEvent         to oSigCjCalendar_Event_Schedules_Panel
                    Set phoDialog_Series            to oSigCjCalendar_Series_Panel
                    //Set phoDialog_EditRecurrence    to oSigCjCalendar_Recurring_Panel
                    Set phoDialog_MinWidth          to oSigCjCalendar_MinWidth_Panel
                    Set phoDialog_TimeScale         to oSigCjCalendar_TimeScale_Panel
                    Set phoDialog_Reorder           to oSigCjCalendar_Reorder_Panel
                    Set phoDialog_DB_Link           to oSigCjCalendar_DB_Link_Panel
                    Set phoDialog_CustomProperties  to oSigCjCalendar_CustomProperties_Panel
                    Set phoDialog_CustomIcons       to oSigCjCalendar_CustomIcons_Panel
                End_Procedure
        
                Procedure OnLoadIcons
                    Send Load_Icon 10 "Con_All_16.ico" 
                    Send Load_Icon 11 "Con_Act_16.ico" 
                    Send Load_Icon 12 "Con_Ter_16.ico" 
                    Send Load_Icon 22 "Gear_16.ico" 
                    Send Load_Icon 23 "Grid_16.ico" 
                    Send Load_Icon 24 "Grids_16.ico" 
                End_Procedure
        
                Procedure OnLoadLayout
                    tdSigCjCal_Category     tCategory
                    tdSigCjCal_DataProvider tDataProvider
                    tdSigCjCal_Schedule     tSchedule
                    tdSigCjCal_Resource     tResource
                    tdSigCjCal_Layout       tLayout
        
                    //-----------------------------------------------------------------
                    //Data Providers - None needed as the default will be used
        
                    //-----------------------------------------------------------------
                    //Categories
                    
                    Move 1          to tCategory.iID
                    Move "Holiday"  to tCategory.sName
                    Move clRed      to tCategory.iBorderColor
                    Move clYellow   to tCategory.iColor_1
                    Move clBlue     to tCategory.iColor_2
                    Move 0.50       to tCategory.nGradient
                    Send Create_Category tCategory
        
                    Move 2                  to tCategory.iID
                    Move "Internal Meeting" to tCategory.sName
                    Move 16155007           to tCategory.iBorderColor
                    Move 16155007           to tCategory.iColor_1
                    Move 11664639           to tCategory.iColor_2
                    Move 10                 to tCategory.nGradient
                    Send Create_Category  tCategory
        
                    Move 3                to tCategory.iID
                    Move "Client Meeting" to tCategory.sName
                    Move clBlue           to tCategory.iBorderColor
                    Move 12314304         to tCategory.iColor_1
                    Move 7917443          to tCategory.iColor_2
                    Move 10               to tCategory.nGradient
                    Send Create_Category  tCategory
                    
                    //-----------------------------------------------------------------
                    //Schedules
                    
                    Move 1          to tSchedule.iID
                    Move "Ian"      to tSchedule.sName
                    Move ""         to tSchedule.sProperties
                    Move 12307372   to tSchedule.iShadeColor
                    Send Create_Schedule tSchedule
                    Send Apply_Category tSchedule.iID 1
                    Send Apply_Category tSchedule.iID 2
                    Send Apply_Category tSchedule.iID 3
                                            
                    Move 2                  to tSchedule.iID
                    Move "Martin"           to tSchedule.sName
                    Move (RGB(245,213,253)) to tSchedule.iShadeColor
                    Move ""       to tSchedule.sProperties
                    Send Create_Schedule tSchedule
                    Send Apply_Category tSchedule.iID 1
                    Send Apply_Category tSchedule.iID 2
                    Send Apply_Category tSchedule.iID 3
        
                    Move 3                  to tSchedule.iID
                    Move "Paul"             to tSchedule.sName
                    Move (RGB(238,233,221)) to tSchedule.iShadeColor
                    Move ""     to tSchedule.sProperties
                    Send Create_Schedule tSchedule
                    Send Apply_Category tSchedule.iID 1
                    Send Apply_Category tSchedule.iID 2
                    Send Apply_Category tSchedule.iID 3
        
                    Move 8           to tSchedule.iID
                    Move "Conf Room" to tSchedule.sName
                    Move ""          to tSchedule.sProperties
                    Send Create_Schedule tSchedule
                    Send Apply_Category tSchedule.iID 2
                    Send Apply_Category tSchedule.iID 3
        
                    //-----------------------------------------------------------------
                    //Resources
        
                    Move 1        to tResource.iID
                    Move "Martin" to tResource.sName
                    Move (RGB(245,213,253)) to tResource.iShadeColor
                    Send Create_Resource tResource
                    Send Apply_Schedule  tResource.iID 2
        
                    Move 2      to tResource.iID
                    Move "Ian"  to tResource.sName
                    Move (RGB(238,233,221)) to tResource.iShadeColor
                    Send Create_Resource tResource
                    Send Apply_Schedule  tResource.iID 1
        
                    Move 3      to tResource.iID
                    Move "Paul" to tResource.sName
                    Move 0      to tResource.iShadeColor
                    Send Create_Resource tResource
                    Send Apply_Schedule  tResource.iID 3
        
                    Move 20       to tResource.iID
                    Move "Staff" to tResource.sName
                    Send Create_Resource tResource
                    Send Apply_Schedule  tResource.iID 1
                    Send Apply_Schedule  tResource.iID 2
                    Send Apply_Schedule  tResource.iID 3
        
                    Move 21      to tResource.iID
                    Move "Room" to tResource.sName
                    Send Create_Resource tResource
                    Send Apply_Schedule  tResource.iID 8
        
                    //-----------------------------------------------------------------
                    //Layouts
                    
                    Move C_Layout_Staff to tLayout.iID
                    Move "All Staff"    to tLayout.sName
                    Send Create_Layout tLayout
                    Send Apply_Resource tLayout.iID 1 True
                    Send Apply_Resource tLayout.iID 2 True
                    Send Apply_Resource tLayout.iID 3 True
        
                    Move C_Layout_Meeting  to tLayout.iID
                    Move "Meetings"        to tLayout.sName
                    Send Create_Layout tLayout
                    Send Apply_Resource tLayout.iID 20 True
                    Send Apply_Resource tLayout.iID 21 True
        
                    Send Apply_Layout C_Layout_Staff
                End_Procedure
            End_Object
            
            Object oMulti_DatePicker is a cSigCJCalendar_DatePicker_v2
                Set Size to 105 135
                Set Location to 2 325
                Set peAnchors to anTopRight
        
                Set phoCalendar to oMulti_Calendar 
            End_Object
            
            Object oMulti_Layout is a ComboForm
                Set Size to 13 80
                Set Location to 109 298
                Set peAnchors to anTopRight
                Set Value to "All Staff"
                
                Procedure Combo_Fill_List
                    Send Combo_Add_Item "All Staff"
                    Send Combo_Add_Item "Meetings"
                End_Procedure
            
                Procedure OnChange
                    String sValue
                
                    Get Value to sValue // the current selected item
                    If (sValue = "All Staff") Send Apply_Layout of oMulti_Calendar C_Layout_Staff
                    If (sValue = "Meetings")  Send Apply_Layout of oMulti_Calendar C_Layout_Meeting
                End_Procedure
            
            End_Object
            
            Object oMulti_Dialogs is a ComboForm
                Set Size to 13 80
                Set Location to 109 381
                Set peAnchors to anTopRight
        
                Procedure Combo_Fill_List
                    Send Combo_Add_Item "Built-In Dialogs"
                    Send Combo_Add_Item "Custom Dialogs"
                End_Procedure
            
                Procedure OnChange
                    String sValue
                
                    Get Value to sValue // the current selected item
                    If (sValue = "Built-In Dialogs") Begin
                        Set phoDialog_NewEvent       of oMulti_Calendar to 0
                        Set phoDialog_EditEvent      of oMulti_Calendar to 0
                        Set phoDialog_EditRecurrence of oMulti_Calendar to 0
                    End
                    Else Begin
                        Send OnRegisterDialogs of oMulti_Calendar 
                    End
                End_Procedure
            End_Object

            Object oMulti_Properties is a Container3d
                Set Size to 157 165
                Set Location to 125 296
                Set Border_Style to Border_None
                Set peAnchors to anTopBottomRight
        
                #Replace zzCal_Object oMulti_Calendar 
                #Include Calendar_v2\oSigCjCalendar_Properties.pkg
            End_Object
        End_Object

        //=====================================================================

        Object oDynamic is a dbTabView
            Set Label to "Dynamic Layouts"

            Procedure Activating
                Forward Send Activating
        
                Set Value of oDynamic_Dialogs to "Built-In Dialogs"
            End_Procedure

            Object oDynamic_Calendar is a cSigCJCalendar_Control_v2
                Set Size to 281 291
                Set Location to 2 2
                Set peAnchors to anAll
                Set pbEnableDB_Link to True
                Set pbDB_Link_OnClick to False
                Set pbEnableCustomIcons to True
                Set pbEnableCustomProperties to True
                Set pbEnableResources to True
                Set pbEnable_ShadeResources to True
                Set pbDialogAllSchedulesMode to True
                Set pbMultipleSchedulesMode to True 
                Set pbRestrictTimeScale to True
                Set ptmWorkDayStartTime to "08:30" 
                Set ptmWorkDayEndTime to "17:00" 
                Set pbShadeLunchTime to True
                Set ptmLunchStartTime to "12:30"
                Set ptmLunchEndTime   to "13:15"
                Set pbShorterLastDay to True 
                Set ptmLastWorkDayEndTime to "16:00" 
                Set peTimeScale to eCal_TimeScale_15 
                
                #Include Calendar_v2\cSigCJCalendar_Standard_Tables.pkg
        
                Procedure OnRegisterDialogs
                    Set phoDialog_NewEvent          to oSigCjCalendar_Event_Schedules_Panel
                    Set phoDialog_EditEvent         to oSigCjCalendar_Event_Schedules_Panel
                    Set phoDialog_Series            to oSigCjCalendar_Series_Panel
                    //Set phoDialog_EditRecurrence    to oSigCjCalendar_Recurring_Panel
                    Set phoDialog_MinWidth          to oSigCjCalendar_MinWidth_Panel
                    Set phoDialog_TimeScale         to oSigCjCalendar_TimeScale_Panel
                    Set phoDialog_Reorder           to oSigCjCalendar_Reorder_Panel
                    Set phoDialog_DB_Link           to oSigCjCalendar_DB_Link_Panel
                    Set phoDialog_CustomProperties  to oSigCjCalendar_CustomProperties_Panel
                    Set phoDialog_CustomIcons       to oSigCjCalendar_CustomIcons_Panel
                End_Procedure

                Procedure OnLoadIcons
                    Send Load_Icon 10 "Con_All_16.ico" 
                    Send Load_Icon 11 "Con_Act_16.ico" 
                    Send Load_Icon 12 "Con_Ter_16.ico" 
                    Send Load_Icon 22 "Gear_16.ico" 
                    Send Load_Icon 23 "Grid_16.ico" 
                    Send Load_Icon 24 "Grids_16.ico" 
                End_Procedure
        
                Procedure OnCreate_DataProvider
                    //Do Nothing - we will use the auto create default
                End_Procedure
        
                Procedure ChangeLayout Integer iLayoutID
                    tdSigCjCal_Category     tCategory
                    tdSigCjCal_DataProvider tDataProvider
                    tdSigCjCal_Schedule     tSchedule
                    tdSigCjCal_Resource     tResource
                    tdSigCjCal_Layout       tLayout
        
                    Integer iCount iCommaPos
                    String sScheduleId sSchedules sCategoryId sCategories
        
                    Send Reset_ResourceManager    
                    
                    Clear C_Categ
                    Find Gt C_Categ by Index.1
                    While (Found)
                        Move C_Categ.ID              to tCategory.iID
                        Trim C_Categ.Description     to tCategory.sName
                        Move C_Categ.BorderColor     to tCategory.iBorderColor
                        Move C_Categ.ColorLight      to tCategory.iColor_1
                        Move C_Categ.ColorDark       to tCategory.iColor_2
                        Move C_Categ.GradientFactor  to tCategory.nGradient
        
                    Send Create_Category  tCategory
        
                        Find Gt C_Categ by Index.1
                    Loop
                    
                    Clear C_Sched
                    Find Gt C_Sched by Index.1
                    While (Found)
                        Move C_Sched.URN            to tSchedule.iID
                        Move (Trim(C_Sched.Name))   to tSchedule.sName
                        Move c_Sched.Shade_Color    to tSchedule.iShadeColor
                        Move ""                     to tSchedule.sProperties                               
                    
                        Send Create_Schedule tSchedule
                    
                        Clear C_Layout
                        Move iLayoutID to C_Layout.URN
                        Find EQ C_Layout by Index.1                
                        If (Found) Begin
                            Move C_Layout.Categories to sCategories                    
                            
                            While (sCategories <> "")
                                Move (Pos (",", sCategories)) to iCommaPos
        
                                If (iCommaPos > 0) Begin
                                    Move (Left (sCategories, (iCommaPos-1))) to sCategoryId
                                    Move (Right (sCategories, Length (sCategories) - iCommaPos)) to sCategories
                                End
                                Else Begin
                                    Move sCategories to sCategoryId
                                    Move "" to sCategories
                                End
        
                                Send Apply_Category tSchedule.iID sCategoryId                 
                            Loop                                        
                        End
        
                        Move C_Sched.URN            to tResource.iID
                        Move (Trim(C_Sched.Name))   to tResource.sName
                        Move c_Sched.Shade_Color    to tResource.iShadeColor

                        Send Create_Resource tResource
                        Send Apply_Schedule  tResource.iID C_Sched.URN   
        
                        Find Gt C_Sched by Index.1                    
                    Loop
        
                    Clear C_Layout
                    Move iLayoutID to C_Layout.URN
                    Find EQ C_Layout by Index.1
                    If (Found) Begin
                        Move C_Layout.URN  to tLayout.iID
                        Move (Trim(C_Layout.Name))  to tLayout.sName
                        Send Create_Layout tLayout
        
                        Move C_Layout.Schedules to sSchedules
        
                        While (sSchedules <> "")
                            Move (Pos (",", sSchedules)) to iCommaPos
        
                            If (iCommaPos > 0) Begin
                                Move (Left (sSchedules, (iCommaPos-1))) to sScheduleId
                                Move (Right (sSchedules, Length (sSchedules) - iCommaPos)) to sSchedules
                            End
                            Else Begin
                                Move sSchedules to sScheduleId
                                Move "" to sSchedules
                            End
                    
                            Send Apply_Resource tLayout.iID sScheduleId True                   
                        Loop                
                    End
        
                    Send Apply_Layout iLayoutID
                End_Procedure
        
                Procedure OnLoadLayout
                    Clear C_Layout
                    Find GT C_Layout by Index.1
                    If (Found) Begin
                        Send ChangeLayout of oDynamic_Calendar C_Layout.URN
                    End
                End_Procedure
            End_Object
            
            Object oDynamic_DatePicker is a cSigCJCalendar_DatePicker_v2
                Set Size to 105 135
                Set Location to 2 325
                Set peAnchors to anTopRight
        
                Set phoCalendar to oDynamic_Calendar
            End_Object
            
            Object oDynamic_Layouts is a ComboForm
                Set Size to 13 80
                Set Location to 109 298
                Set peAnchors to anTopRight
                Set Value to "All Staff"
                
                Procedure Combo_Fill_List
                    Clear C_Layout
                    Find Gt C_Layout by Index.1
                    While (Found)
                        Send Combo_Add_Item (Trim(C_Layout.Name))
                        Find Gt C_Layout by Index.1                                
                    Loop
                End_Procedure
            
                Procedure OnChange
                    String sValue
                
                    Get Value to sValue // the current selected item
            
                    Clear C_Layout
                    Move sValue to C_Layout.Name
                    Find Eq C_Layout by Index.2
                    If (Found) Begin
                        Send ChangeLayout of oDynamic_Calendar C_Layout.URN
                    End
                End_Procedure
            End_Object
            
            Object oDynamic_Dialogs is a ComboForm
                Set Size to 13 80
                Set Location to 109 381
                Set peAnchors to anTopRight
        
                Procedure Combo_Fill_List
                    Send Combo_Add_Item "Built-In Dialogs"
                    Send Combo_Add_Item "Custom Dialogs"
                End_Procedure
            
                Procedure OnChange
                    String sValue
                
                    Get Value to sValue // the current selected item
                    If (sValue = "Built-In Dialogs") Begin
                        Set phoDialog_NewEvent       of oDynamic_Calendar to 0
                        Set phoDialog_EditEvent      of oDynamic_Calendar to 0
                        Set phoDialog_EditRecurrence of oDynamic_Calendar to 0
                    End
                    Else Begin
                        Send OnRegisterDialogs of oDynamic_Calendar 
                    End
                End_Procedure
            End_Object

            Object oDynamic_Properies is a Container3d
                Set Size to 157 165
                Set Location to 125 296
                Set peAnchors to anTopBottomRight
                Set Border_Style to Border_None

                #Replace zzCal_Object oDynamic_Calendar         
                #Include Calendar_v2\oSigCjCalendar_Properties.pkg
            End_Object
        End_Object

    End_Object

End_Object

