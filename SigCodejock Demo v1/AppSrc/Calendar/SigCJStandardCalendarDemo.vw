Use Windows.pkg
Use DFClient.pkg
Use cSigCjCalendarControl.pkg
Use Cal_Date.DD
Use Cal_Cats.dd
Use Cal_Sys.dd
Use Calr_Pat.dd
Use Calevent.dd


Deferred_View Activate_oSigCJCalendarDemo_Standard_View for ;
Object oSigCJCalendarDemo_Standard_View is a dbView
    Set Border_Style to Border_Thick
    Set Size to 300 450
    Set Location to 8 3
    Set Maximize_Icon to True
    Set piMinSize to 200 300
    Set Label to "Codejock Demo - Standard Calendar"
    Set Icon to "SIG.ico" 

    Object oCalevent_DD is a CalEvent_DataDictionary
    End_Object

    Object oCalr_Pat_DD is a Calr_Pat_DataDictionary
    End_Object

    Object oCal_Sys_DD is a Cal_Sys_DataDictionary
    End_Object

    Object oCal_Cats_DD is a Cal_Cats_DataDictionary
    End_Object

    Object oCal_Date_DD is a Cal_Date_DataDictionary
    End_Object

    Set Main_DD to oCalevent_DD
    Set Server to oCalevent_DD

    Object oSigCJCalendarControl1 is a cSigCJCalendarControl
        Set Size to 292 292
        Set Location to 4 4
        Set peAnchors to anAll
        Set peTimeScale to eCal_TimeScale_15
        Set ptmLunchEndTime to "13:15"
        Set ptmLunchStartTime to "12:30"
        Set pbUseScaleTimes to True
        Set ptmWorkDayStartTime to "08:30"
    End_Object
    
    Object oSigCJDatePicker1 is a cSigCJCalendarDatePicker
        Set Size to 100 135
        Set Location to 2 306
        Set peAnchors to anTopRight
    End_Object

    Object oContainer3d1 is a Container3d
        Set Size to 170 151
        Set Location to 105 297
        Set peAnchors to anTopBottomRight
        Set Border_Style to Border_Normal
        
        Use Calendar\oCalendar_Properties.pkg
    End_Object
    
    Object oPreview_Bn is a cSigCJPushButton
        Set Size to 26 26
        Set Location to 278 348
        Set peAnchors to anBottomRight
        Set psImage to "Cal_Preview32.ico"

        Procedure OnClick
            Send ComPrintPreview of oSigCJCalendarControl1 True
        End_Procedure
    End_Object

    Object oPrint_Bn is a cSigCJPushButton
        Set Size to 26 26
        Set Location to 278 378
        Set peAnchors to anBottomRight
        Set psImage to "Cal_Print32.ico" 

        Procedure OnClick
            Send ComPrintCalendar2 of oSigCJCalendarControl1 True
        End_Procedure
    End_Object

    Object oPrintSetup_bn is a cSigCJPushButton
        Set Size to 26 26
        Set Location to 278 408
        Set peAnchors to anBottomRight
        Set psImage to "Cal_PrintSetUp32.ico"

        Procedure OnClick
            Boolean bRetval
            Get ComShowPrintPageSetup of oSigCJCalendarControl1 to bRetval
        End_Procedure
    End_Object
    

Cd_End_Object
