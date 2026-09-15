Use dfallent.pkg
Use cSigCjProgressBar.pkg
Use cSigCjPushButton.pkg

Deferred_View Activate_oSigCJProgressBarDemo_View for ;
Object oSigCJProgressBarDemo_View is a dbView
    Set Border_Style to Border_Thick
    Set Size to 78 243
    Set Location to 2 2
    Set Maximize_Icon to True
    Set Icon to "SIG.ico"
    Set Label to "Codejock Demo - Progress Bar"

    Set Verify_Data_Loss_Msg to 0
    Set Verify_Exit_Msg      to 0

    Object oSigCJProgressBar_Standard is a cSigCJProgressBar
        Set Location to 8 7
        Set Size to 13 150
        Set psText to "Bar Style - Standard"
    End_Object

    Object oSigCJPushButton_Standard is a cSigCJPushButton
        Set Location to 8 165
        Set psCaption to " Start"

        Procedure OnClick
            Integer iCounter iLoop
            
            Set piValue of oSigCJProgressBar_Standard to 0

            For iCounter from 1 to 100
                Set piValue of oSigCJProgressBar_Standard to iCounter
                
                For iLoop from 1 to 100000
                    //Delay Loop
                Loop
            Loop
        End_Procedure
    End_Object

    Object oSigCJProgressBar_Smooth is a cSigCJProgressBar
        Set Location to 27 7
        Set peStyle to ePR_BarSmooth
        Set psText to "Bar Style - Smooth"
    End_Object

    Object oSigCJPushButton_Smooth is a cSigCJPushButton
        Set Location to 27 164
        Set psCaption to " Start"
        
        Procedure OnClick
            Integer iCounter iLoop
            
            Set piValue of oSigCJProgressBar_Smooth to 0
            
            For iCounter from 1 to 100
                Set piValue of oSigCJProgressBar_Smooth to iCounter
                
                For iLoop from 1 to 100000
                    //Delay Loop
                Loop
            Loop
        End_Procedure
    End_Object

    Object oSigCJProgressBar_Marquee is a cSigCJProgressBar
        Set Location to 46 7
        Set peStyle to ePR_BarMarquee
        Set psText to "Bar Style - Marquee"
        Set piMarqueeDelay to 0
    End_Object

    Object oSigCJPushButton_Marquee is a cSigCJPushButton
        Set Location to 46 163
        Set psCaption to "Start"
        
        Procedure OnClick
            String sWork
            Get psCaption to sWork
            
            If (sWork = "Start") Begin
                Set psCaption to "Stop"
                Set piMarqueeDelay of oSigCJProgressBar_Marquee to 80
            End
            Else Begin
                Set psCaption to "Start"
                Set piMarqueeDelay of oSigCJProgressBar_Marquee to 0
            End
        End_Procedure
    End_Object

Cd_End_Object
