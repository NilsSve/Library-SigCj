Use Windows.pkg
Use DFClient.pkg
Use cSigCjTaskDialog.pkg

Deferred_View Activate_oSigCJTaskDialogDemo_View for ;
Object oSigCJTaskDialogDemo_View is a dbView

    Set Border_Style to Border_Thick
    Set Size to 138 275
    Set Location to 4 15
    Set Icon to "SIG.ico"
    Set Label to "Task Dialogs Boxes"
    Set piMinSize to 138 275
    Set Maximize_Icon to True

    Object oGroup1 is a Group
        Set Size to 130 130
        Set Location to 4 4
        Set Label to "Standard Dialog Boxes"

        Object oStandardYesNo_btn is a Button
            Set Size to 14 90
            Set Location to 20 20
            Set Label to "Yes No Box"
            Set peAnchors to anTopLeftRight
            
            Procedure OnClick
                Integer iRetval
                Get sigYesNo_Box "Was this demonstration any good?" to iRetval
                //Option 2 Get sigYesNo_Box "Was this demonstration any good?" "Question" to iRetval
                //Option 3 Get sigYesNo_Box "Was this demonstration any good?" "Question" eBtn_Yes to iRetval
            End_Procedure
        End_Object
        Object oStandardYesNoCancel_btn is a Button
            Set Location to 40 21
            Set Size to 14 90
            Set Label to "Yes No Cancel Box"
            Set peAnchors to anTopLeftRight
            
            Procedure OnClick
                Integer iRetval
                Get sigYesNoCancel_Box "Humbugs!" to iRetval
                //Option 2 Get sigYesNoCancel_Box "Humbugs!" "Hello World" to iRetval
                //Option 3 Get sigYesNoCancel_Box "Humbugs!" "Hello World" eBtn_Cancel to iRetval
            End_Procedure
        End_Object
        Object oStandardInfo_btn is a Button
            Set Size to 14 90
            Set Location to 60 20
            Set Label to "Info Box"
            Set peAnchors to anTopLeftRight
            
            Procedure OnClick
                Send SigInfo_Box  "Humbugs are great, so you think you can program!" 
                //Option 2 Send SigInfo_Box  "Humbugs are great, so you think you can program!" "Hello World"
            End_Procedure
        End_Object
        Object oStandardWarning_btn is a Button
            Set Size to 14 90
            Set Location to 80 20
            Set Label to "Warning Box"
            Set peAnchors to anTopLeftRight
            
            Procedure OnClick
                Send SigWarning_Box  "Humbugs are great, so you still think you can program!"
                //Option 2 Send SigWarning_Box  "Humbugs are great, so you still think you can program!" "Hello World"
            End_Procedure
        End_Object
        Object oStandardStop_btn is a Button
            Set Size to 14 90
            Set Location to 100 20
            Set Label to "Stop Box"
            Set peAnchors to anTopLeftRight
            
            Procedure OnClick
                Send SigStop_Box  "Humbugs, you can program!" 
                //Option 2 Send SigStop_Box  "Humbugs, you can program!" "Hello World"
            End_Procedure
        End_Object
    End_Object

    Object oGroup2 is a Group
        Set Size to 130 130
        Set Location to 4 140
        Set Label to "Custom Dialog Boxes"

        Object oInfoDialog_btn is a Button
            Set Size to 14 90
            Set Location to 20 20
            Set Label to "Information Dialog"
            Set peAnchors to anTopLeftRight
        
            Procedure OnClick
                Handle hoDialog
                Integer eReply
                
                Get Initialise of (oSigCJTaskDialog(Self)) to hoDialog
                
                Set pbShowWindowsExitButton   of hoDialog to True                                                                                                      
                Set psTitle                   of hoDialog to "VDF SIG UK"                                                                                              
                Set pbShowButtonOk            of hoDialog to True
                Set pbShowButtonCancel        of hoDialog to True
                Set psMainInstructionText     of hoDialog to "Task Dialogs"                                                                                   
                Set piMainIcon                of hoDialog to eTaskIconInfo                                                                                             
                Set pbEnableHyperLinks        of hoDialog to True                                                                                                      
                Set psContentText             of hoDialog to ('Package:  cSigCJTaskDialog.pkg' +CLF+ 'Publisher: <A HREF="http://www.vdfsig.co.uk">vdfsig uk</A>')     
                Set psExpandedInformationText of hoDialog to "First demonstrated at EDUC 2008 in Copenhagen"                                                           
                Set psFooterText              of hoDialog to "Contributors: Martin Pincott, Ian Smith and Peter Bragg (The Three Musketeers?)"                                
                Set piFooterIcon              of hoDialog to eTaskIconCustom                                                                                                                                                              
                Set psFooterIconImage         of hoDialog to "ThreeMusketeers_16.ico"
                Set pbRelativePosition        of hoDialog to True                                                                                                      
                Set ComVerificationText       of hoDialog to "Don't show me this again"                                                                                
                
                Get ShowDialog of (oSigCJTaskDialog(Self)) to eReply
                Send info_box ("Button Clicked: "+String(eReply)) "Return Value"               
            End_Procedure
            
        End_Object
        Object oProgramUpdateDialog_Btn is a Button
            Set Size to 14 90
            Set location to 40 20
            Set Label to "Upgrade Dialog"
            Set peAnchors to anTopLeftRight
    
            Procedure OnClick
                Handle hoDialog
                Integer eReply
                
                Get Initialise of (oSigCJTaskDialog(Self)) to hoDialog
                
                Set piWidth                   of hoDialog to 228
                Set pbShowWindowsExitButton   of hoDialog to True                                                                                                      
                Set psTitle                   of hoDialog to "Internet Explorer - Security Warning"                                                                                              
                Set psMainInstructionText     of hoDialog to "Do you want to run this software?"                                                                                   
                Set piMainIcon                of hoDialog to eTaskIconCustom                                                                                           
                Set psMainIconImage           of hoDialog to "sig.ico"
                Set pbEnableHyperLinks        of hoDialog to True                                                                                                      
                Set psContentText             of hoDialog to ('Name: Special Interest Group' +CLF+ 'Publisher: <A HREF="http://www.vdfsig.co.uk">Special Interest Group UK</A>')                 
                Set TaskDialogOptionButton    of hoDialog to "Run"       100
                Set TaskDialogOptionButton    of hoDialog to "Don't Run" 101
                Set pbEnableCommandLinks      of hoDialog to True
                Set pbShowCommandLinkIcons    of hoDialog to True            
                Set psFooterText              of hoDialog to ("While files from the internet can be useful, this file type can potentially harm your computer. " ;
                 + 'Only run software from publishers you trust. <A HREF="http://www.vdfsig.co.uk">'+"What's the risk?</a>")                         
                Set piFooterIcon              of hoDialog to eTaskIconShield                                                                                                                                                            
                Set pbRelativePosition        of hoDialog to True                                                                                                                                                                                    
                
                Get ShowDialog of (oSigCJTaskDialog(Self)) to eReply
                // Send info_box ("Button Clicked: "+String(eReply)) "Return Value"                    
            End_Procedure        
        End_Object
        Object oErrorDialog_Btn is a Button
            Set Size to 14 90
            Set Location to 60 20
            Set Label to "Error Dialog"
            Set peAnchors to anTopLeftRight
    
            Procedure OnClick
                Handle hoDialog
                Integer eReply
                
                Get Initialise of (oSigCJTaskDialog(Self)) to hoDialog
                
                Set pbShowWindowsExitButton   of hoDialog to True                                                                                                      
                Set psTitle                   of hoDialog to "Application Error"                                                                                              
                Set psMainInstructionText     of hoDialog to "Error Report"                                                                                   
                Set piMainIcon                of hoDialog to eTaskIconError                                                                                                                                                                                         
                Set psContentText             of hoDialog to ("Line: 9673 Error Number: 98" + CLF + "Invalid Message: 'This presenter is too good looking'" )                                                                                                                          
                Set pbRelativePosition        of hoDialog to True                                                                                                                                                                                    
                
                Get ShowDialog of (oSigCJTaskDialog(Self)) to eReply           
            End_Procedure  
        End_Object
        Object oProgressDialog_btn is a Button
            Set Size to 14 90
            Set Location to 80 20
            Set Label to "Progress Dialog"
            Set peAnchors to anTopLeftRight
            
            Procedure OnClick
                Handle hoDialog
                Integer eReply
                
                Get Initialise of (oSigCJTaskDialog(Self)) to hoDialog
    
                Set pbShowWindowsExitButton   of hoDialog to False                                                                                                      
                Set psTitle                   of hoDialog to "Export Data"
                Set piMainIcon                of hoDialog to eTaskIconCustom 
                Set psMainIconImage           of hoDialog to "export_32.ico"             
                Set psMainInstructionText     of hoDialog to "Processing... 0%"  
                Set psContentText             of hoDialog to "Please wait..."
                Set peProgressBarStyle        of hoDialog to eTaskProgressBar_Normal
                Set pbEnableCallbackTimer     of hoDialog to True
                Set ProgressBarRange          of hoDialog 1 to 98
                Set pbShowButtonCancel        of hoDialog to True
                
                Get ShowDialog of (oSigCJTaskDialog(Self)) to eReply   
            End_Procedure
        End_Object
        Object oDialogWithRadioOptions_btn is a Button
            Set Size to 14 90
            Set location to 100 20
            Set Label to "With Radio Options"
            Set peAnchors to anTopLeftRight
            
            Procedure OnClick
                Handle hoDialog
                Integer eReply
                
                Get Initialise of (oSigCJTaskDialog(Self)) to hoDialog
    
                Set pbShowWindowsExitButton   of hoDialog to True                                                                                                      
                Set psTitle                   of hoDialog to "You're a winner!"
                Set piMainIcon                of hoDialog to eTaskIconCustom 
                Set psMainIconImage           of hoDialog to "Cashbag_32.ico"  
                Set psMainInstructionText     of hoDialog to "Congratulations"
                Set psContentText             of hoDialog to ("Congratulations! You are today's instant prize winner!" + CLF ;
                                                            + "You have won $1000. Do you wish to...") 
                Set TaskDialogOptionRadio     of hoDialog to "Give it all to the wife"           100
                Set TaskDialogOptionRadio     of hoDialog to "Buy everyone in the room a drink"  101
                Set TaskDialogOptionRadio     of hoDialog to "Donate it all to charity"          102
                Set TaskDialogOptionRadio     of hoDialog to "Buy a new laptop"                  103
                Set piDefaultRadioOption      of hoDialog to 103
                
                Set psFooterText              of hoDialog to ("Send your choice of option along with a cheque for $1000 to " ;
                                                            + "The Three Musketeers (Les Trois Mousquetaires), the nearest bar!")
                Set piFooterIcon              of hoDialog to eTaskIconInfo
                
                Get ShowDialog of (oSigCJTaskDialog(Self)) to eReply   
            End_Procedure
        End_Object
    End_Object

Cd_End_Object
