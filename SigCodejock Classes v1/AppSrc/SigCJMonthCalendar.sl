//==============================================================================
// Project      : SigCj - VDF Classes for Codejock
// File         : cSigCjMonthCalendar.pkg
// Description  : VDF Class for Codejock control
//
// Revision     : $Rev: 779 $
//                $Date: 2012-05-08 15:47:09 +0100 (Tue, 08 May 2012) $
//                $Author: martin $
//
// Requirements : Visual DataFlex 17.0+
//                Codejock SuitePro - Version 13.4.2, 15.3.1 and 16.3.1
//
// Copyright    : Copyright © 2009-2013 VDF SIG UK, All rights reserved.
//                Visual DataFlex Special Interest Group UK.
//                http://www.vdfsig.co.uk/
//                dev@vdfsig.co.uk
//
//                Some of this code and ideas may have come from a package that Emil wrote!
//                Thanks to John T for his help too.
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
//==============================================================================
Use DfAllEnt.pkg

Use cSigCjMonthCalendar.pkg

Object oSigCJMonthCalendar_Lookup is a dbModalPanel
    //Properties
    Property Integer piInvokingItem     0   
    Property Integer piY                0   
    Property Handle  phoInvokingObject  0  
    Property Handle  phoMonthCalendar   0
    Property Boolean pbShowButtons      True
    Property Boolean pbHideBorder       True
    Property Date    pdDate             0    
      
    //Settings...
    Set Size to 122 177
    Set Location     to 4 5
    Set Border_Style to Border_Normal
    Set Sysmenu_Icon to True
    Set Locate_Mode to Popup_Locate
    Set Label to "Select Date"
    Set button_height to 12
    Set button_width  to 12

    Object oSigCJMonthCalendar is a cSigCJMonthCalendar
        Set Size to 100 100
        Set Location to 4 4
        Set peAnchors to anAll
        Set phoMonthCalendar to Self
                
        Procedure OnComSelChange DateTime llStartDate DateTime llEndDate Boolean ByRef llCancel
            Set pdDate to llStartDate
        End_Procedure
        
        Procedure OnComDblClick
            Send mOK
        End_Procedure 

        Procedure onComMouseDown Short llButton Short llShift OLE_XPOS_PIXELS llx OLE_YPOS_PIXELS lly
            Set piY to lly
        End_Procedure

        Procedure OnSetSize Integer iHeight Integer iWidth
            Integer iHt_Adj iWt_Adj 

            // Adjust the border size 
            Move 12 to iHt_Adj
            Move 12 to iWt_Adj
            
            Set GuiSize of oSigCJMonthCalendar_Lookup to (iHeight+iHt_Adj) (iWidth+iWt_Adj)
            Send Position_Child_Objects
        End_Procedure
    End_Object

    Procedure PopUp
        Handle  hoInvokingObject hoCalendar
        Integer iItem
        Date    dOld dNew
        Boolean bIsDeoControl
        
        //Get current focus object and item. If this is invoked from an object
        //that does not support current_item or value then this will fail
        Get focus to hoInvokingObject
        If (hoInvokingObject = 0) Begin
            Procedure_Return
        End
        Get Current_Item of hoInvokingObject to iItem
        Get value of hoInvokingObject item iItem to dOld
        If (not(dOld)) Begin
            Sysdate dOld
        End
        //Set invoking object, item and current date property values
        Set phoInvokingObject to hoInvokingObject
        Set piInvokingItem to iItem
        Set pdDate to dOld
   
        Set pdValue    of (phoMonthCalendar(Self)) to (pdDate(Self)) 
        Set pdSelEnd   of (phoMonthCalendar(Self)) to (pdDate(Self)) 
        Set pdSelStart of (phoMonthCalendar(Self)) to (pdDate(Self))             
        
        If (pbHideBorder(Self)) Set Caption_Bar to False
        Else Set Caption_Bar to True
     
        Forward Send Popup
    End_Procedure

    Procedure Page_Object Boolean bPage
        Forward Send Page_Object bPage
        If (bPage) Begin     
            Set Icon to 'calendar_16.ico'
        End
    End_Procedure
    
    Procedure mOK
        Date    dNew
        Handle  hoInvokingObject
        Integer iItem iDelegationMode
        Boolean bIsDeoControl
        
        Get pdDate            to dNew
        Get phoInvokingObject to hoInvokingObject
        If (Object_Id(hoInvokingObject)) Begin
        Get piInvokingItem    to iItem
            
            Get Delegation_Mode of hoInvokingObject to iDelegationMode
            Set Delegation_Mode of hoInvokingObject to No_Delegate_or_Error
                  
        Set value of hoInvokingObject item iItem to dNew
            Set Item_Changed_State of hoInvokingObject item iItem to True             

            Set Delegation_Mode of  hoInvokingObject to iDelegationMode            
        End
        
        Send close_panel
    End_Procedure        

    Procedure mCancel
        Send Close_panel
    End_Procedure        
    
    Send Add_Button "O" Msg_mOk
    Send Add_Button "C" Msg_mCancel
    
    On_Key Key_Alt+Key_O Send mOk
    On_Key Key_Alt+Key_C Send mCancel
    On_Key Key_Enter     Send mOk
    On_Key Key_Escape    Send mCancel

    Procedure Position_Child_Objects
        Integer iPanel_Sz 
        Integer iRmrgn iNo_Bn iHt iWd iCol iSpace
        Integer iBn_Obj iObj 
        Integer iWt_Adj 
        Boolean bShowButtons
        
        Move 0 to iSpace  // Adjustment

        Get pbShowButtons to bShowButtons 
        Move (Button_ids(Current_Object)) to iObj
        Get Button_count to iNo_Bn
        Decrement iNo_Bn
        While (iNo_Bn >= 0)
            Get Integer_value of iObj item iNo_Bn to iBn_Obj
            Set Visible_State of iBn_Obj to bShowButtons
            Decrement iNo_Bn
        Loop            

        Get GUISize of oSigCJMonthCalendar to iPanel_Sz

        Move (low(iPanel_Sz)-0) to iRmrgn

        Get Button_count to iNo_Bn
    
        If (iNo_Bn = 0) Begin
            Move (Hi(iPanel_Sz)) to iHt
        End
        Else Begin
            Move (Button_ids(Current_Object)) to iObj
            Get Integer_Value of iObj item 0 to iBn_Obj
            Get GUIsize of iBn_Obj to iHt
            Move (low(iHt)) to iWd
            Move ( hi(iHt)) to iHt
            
            If ((iRmrgn -((iWd)*iNo_Bn)) < 0 ) Begin
                Move 2 to iSpace
            End
            Move ( hi(iPanel_Sz) - iHt) to iHt
            
            Move (iRmrgn-iWd) to iCol
            Decrement iNo_Bn
            While (iNo_Bn >= 0)
                Get Integer_value of iObj item iNo_Bn to iBn_Obj
                If (iNo_Bn = 1) Begin
                    Set Bitmap of iBn_Obj to "btn-cancel_16.bmp"
                End
                If (iNo_Bn = 0) Begin
                    Set Bitmap of iBn_Obj to "btn-ok_16.bmp"
                End
                Set Border_Style of iBn_Obj to Border_None
                Set FlatState of iBn_Obj to True
                Set Color        of iBn_Obj to clWhite 
                Set GUIlocation  of iBn_Obj to iHt iCol
                Send Adjust_Logicals of iBn_Obj
                Move (iCol - iSpace - iWd)  to iCol
                Decrement iNo_Bn
            End
        End
    End_Procedure
    
End_Object

