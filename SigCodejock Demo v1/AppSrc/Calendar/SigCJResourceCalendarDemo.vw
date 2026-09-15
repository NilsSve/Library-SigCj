Use dfallent.pkg
Use cSigCjCalendarControl.pkg
Use Windows.pkg

Deferred_View Activate_oSigCJCalendarDemo_Resource_View for ;
Object oSigCJCalendarDemo_Resource_View is a dbView
    Set Border_Style to Border_Thick
	Set Size to 200 450
    Set Location to 2 2
    Set Maximize_Icon to True
    Set Icon to "SIG.ico"
    Set Label to "Codejock Demo - Resource Calendar"

    Set Verify_Data_Loss_Msg to 0
    Set Verify_Exit_Msg      to 0
    Set piMinSize to 200 450

    Object oSigCJCalendarControl1 is a cSigCJCalendarControl
        Set Size to 192 292
        Set Location to 4 4
        Set peAnchors to anAll
        Set peTimeScale to eCal_TimeScale_15
        Set ptmLunchEndTime to "13:15"
        Set ptmLunchStartTime to "12:30"
        Set pbUseScaleTimes to True
        Set ptmWorkDayStartTime to "08:30"
        Set psResourceLayout to "Tasking Plan"
        Set peUseResources to eCal_RS_StdFiles  
        
    End_Object

    Object oSigCJCalendarDatePicker1 is a cSigCJCalendarDatePicker
        Set Size      to 194 135
        Set Location  to 2 306
        Set peAnchors to anTopBottomRight
    End_Object   

Cd_End_Object
