Use Windows.pkg
Use DFClient.pkg
Use cSigCjCalendarControl.pkg
Use Cal_Date.DD
Use Customer.DD
Use SalesP.DD
Use OrderHea.DD

Deferred_View Activate_oSigCJCalendarDemo_Bespoke_View for ;
Object oSigCJCalendarDemo_Bespoke_View is a dbView
    Set Border_Style to Border_Thick
    Set Size to 200 443
    Set Location to 8 3
    Set Maximize_Icon to True
    Set piMinSize to 200 443
    Set Label to "Codejock Demo - Bespoke Calendar - Sales Team"
    Set Icon to "SIG.ico" 

    Object oSalesp_DD is a SalesP_DataDictionary
    End_Object

    Object oCustomer_DD is a Customer_DataDictionary
    End_Object

    Object oOrderhea_DD is a OrderHea_DataDictionary
        Set DDO_Server to oSalesp_DD
        Set DDO_Server to oCustomer_DD
    End_Object

    Object oCal_Date_DD is a Cal_Date_DataDictionary
    End_Object

    Set Main_DD to oCal_Date_DD
    Set Server to oCal_Date_DD

    Object oSigCJCalendarControl1 is a cSigCJCalendarControl
        Set Size to 192 292
        Set Location to 4 4
        Set peAnchors to anAll
        Set peTimeScale to eCal_TimeScale_15
        Set ptmLunchEndTime to "13:15"
        Set ptmLunchStartTime to "12:30"
        Set pbUseScaleTimes to True
        Set ptmWorkDayStartTime to "08:30"
        Set pbUseStdDates to False
        Set pbUseStdFiles to False
    
        Procedure OnLoad_Special_Date Date dThisDate
            Integer iIndex
            tdCal_Dates tCal_Date
        
            Clear Cal_Date
            Move dThisDate to Cal_Date.Date_From
            Find Le Cal_Date by Index.1
            If ((Found) and (dThisDate >= Cal_Date.Date_From) and (dThisDate <= Cal_Date.Date_To)) Begin
                Move dThisDate            to tCal_Date.dDate
                Move Cal_Date.BackColour  to tCal_Date.iBackColor
                Move Cal_Date.AllDay      to tCal_Date.bAllDay
                Move Cal_Date.AllowEvents to tCal_Date.eAllowEvents
                
                Send Add_Special_Date tCal_Date
            End
        End_Procedure
    
        //=========================================================================
        // List of Non Standard Table Events
        // If your not using the standard table set then the following events will
        // give you complete control over the data
        //=========================================================================
        
        Procedure OnEvent_GetUpcoming DateTime dtFrom DateTime dtTo
        End_Procedure
    
        Function OnEvent_Create tdEvent tEvent_Data Returns Integer
        End_Function
    
        //-------------------------------------------------------------------------
    
        Function OnEvent_Delete Integer iEvent_ID Returns Boolean
        End_Function
    
        //-------------------------------------------------------------------------
    
        Function OnEvent_Read Integer iEvent_ID Returns tdEvent
        End_Function
    
        //-------------------------------------------------------------------------
    
        Function OnEvent_Save tdEvent tEvent_Data Returns Boolean

            Send Clear of oOrderhea_DD
            
            Send Find_By_Recnum of oOrderhea_DD OrderHea.File_Number tEvent_Data.iURN
            
            Set Field_Changed_Value of oOrderhea_DD Field OrderHea.Order_Date to tEvent_Data.dStartDate
            Set Field_Changed_Value of oOrderhea_DD Field OrderHea.Time_Start to (Replace(":",tEvent_Data.tmStartTime,""))
            Set Field_Changed_Value of oOrderhea_DD Field OrderHea.Time_End   to (Replace(":",tEvent_Data.tmEndTime,""))

            Send Request_Save of oOrderhea_DD 
            
            Function_Return True 
        End_Function
    
        //-------------------------------------------------------------------------
    
        Function Move_Orders_To_tdEvent Returns tdEvent
            tdEvent tEvent
    
            Move OrderHea.Recnum          to tEvent.iURN
            Move SalesP.Recnum            to tEvent.sCategories
            Move SalesP.Name              to tEvent.sLocation
            Move ("$" + String(OrderHea.Order_Total))     to tEvent.sBody
            Move Customer.Name            to tEvent.sSubject
            Move OrderHea.Order_Date      to tEvent.dStartDate
            Move OrderHea.Order_Date      to tEvent.dEndDate
            Move OrderHea.Time_Start      to tEvent.tmStartTime
            Move OrderHea.Time_End        to tEvent.tmEndTime

            Function_Return tEvent
        End_Function

        Procedure OnEvents_For_Day Date dDay
            tdEvent tEvent
            
            Clear OrderHea
            Move dDay to OrderHea.Order_Date
            Find Ge OrderHea by Index.3
            While (Found)
                If (OrderHea.Order_Date = dDay) Begin
                        Relate OrderHea
                        Get Move_Orders_To_tdEvent to tEvent
                        Send Add_Event_For_Day tEvent
                End
                Find GT OrderHea by Index.3
            End
        End_Procedure
    
        //-------------------------------------------------------------------------
   
        Function Move_Sales_To_tdCats Returns tdCal_Category
            tdCal_Category tCats

            Move SalesP.Recnum to tCats.iURN        
            Move SalesP.ID     to tCats.sShort_Desc
            Move SalesP.Name   to tCats.sLong_Desc
            Move 1676698       to tCats.iBorder_Color
            Move 16777215      to tCats.iColor_Dark
            Move 11664639      to tCats.iColor_Light
            Move 0.75          to tCats.nGradient

            Function_Return tCats
        End_Function

        Procedure OnCategory_Load 
            Handle  hoData_Prov hoCategories 
            Variant vCategories  
            tdCal_Category tCat

            Clear SalesP
            Find gt SalesP by Index.1
            While (Found)
                Get Move_Sales_To_tdCats to tCat
                Send Add_Category tCat
                    
                Find gt SalesP by Index.1
            Loop
        End_Procedure

    End_Object

    Object oSigCJCalendarDatePicker1 is a cSigCJCalendarDatePicker
        Set Size to 100 135
        Set Location to 4 302
        Set peAnchors to anTopRight
    End_Object

Cd_End_Object
