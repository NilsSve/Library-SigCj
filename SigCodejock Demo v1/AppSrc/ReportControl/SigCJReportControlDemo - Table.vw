Use Windows.pkg
Use DFClient.pkg
Use Customer.DD
Use SalesP.DD
Use OrderHea.DD
Use Vendor.DD
Use Invt.DD
Use OrderDtl.DD
Use cSigCjReportControl.pkg
Use cSigCJFieldChooser.pkg
Use cSigCjProgressBar.pkg
Use cSigCjPushButton.pkg

Define CR_LF for (Character(13)+Character(10))

Deferred_View Activate_SigCjReportControlDemo_Table_View for ;
Object SigCjReportControlDemo_Table_View is a dbView
    Set Border_Style to Border_Thick
    Set Size to 216 450
    Set Location to 2 2
    Set Label to "Codejock Demo - Report Control - Table"
    Set Maximize_Icon to True
    Set Icon to "SIG.ico"
         
    Object oVendor_DD is a Vendor_DataDictionary
    End_Object

    Object oInvt_DD is a Invt_DataDictionary
        Set DDO_Server to oVendor_DD

        Procedure OnConstrain 
            // Constrain Invt.Item_ID eq "MENU" 
        End_Procedure

    End_Object

    Object oSalesp_DD is a Salesp_DataDictionary

        Procedure OnConstrain 
            // Constrain Salesp.ID eq "LM" 
        End_Procedure

    End_Object

    Object oCustomer_DD is a Customer_DataDictionary
    End_Object

    Object oOrderhea_DD is a OrderHea_DataDictionary
        Set DDO_Server to oSalesp_DD
        Set DDO_Server to oCustomer_DD
    End_Object

    Object oOrderdtl_DD is a OrderDtl_DataDictionary
        Set DDO_Server to oInvt_DD
        Set DDO_Server to oOrderhea_DD
        
        Procedure OnConstrain 
            Constrain OrderDtl.Qty_Ordered gt 0 
        End_Procedure
    End_Object

    Set Main_DD to oOrderdtl_DD
    Set Server to oOrderdtl_DD

    Object oFilter_Group is a Group
    		Set Size to 28 441
        Set Location to 4 4
        Set peAnchors to anTopLeftRight

        Object oFilter_Search_Form is a Form
            Set Size to 13 107
            Set Location to 10 57
            Set peAnchors to anTopLeft
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to JMode_Right
            Set Label to "Filter Search"
            
            Set Form_Button        0 to Form_Button_Prompt
            Set Form_Button_Bitmap 0 to "ieref.bmp"
            Set Prompt_Button_Mode to PB_PromptOn
            On_Key kClear Send Prompt
            On_Key kEnter Send Prompt
    
            Procedure OnChange
                String sValue
            
                Get Value to sValue
                If (Trim(sValue) = "") Begin
                    Send Filter_Rows of oSigCJReportControl1 sValue
                End    
            End_Procedure
            
            Procedure Prompt 
                String sValue
            
                Get Value to sValue
                Send Filter_Rows of oSigCJReportControl1 sValue
            End_Procedure
        End_Object

        Object oRows_Form is a Form
            Set Size to 13 25
            Set Location to 10 190
            Set Label to "Rows"
            Set Label_Justification_Mode to JMode_Right
            Set Label_Col_Offset to 2
        End_Object
        
        Object oFilter_Rows_Form is a Form
            Set Size to 13 25
            Set Location to 10 265
            Set Label to "Filtered Rows"
            Set Label_Justification_Mode to JMode_Right
            Set Label_Col_Offset to 2
        End_Object

        Object oSelected_Rows_Form is a Form
            Set Size to 13 25
            Set Location to 10 345
            Set Label to "Selected Rows"
            Set Label_Justification_Mode to JMode_Right
            Set Label_Col_Offset to 2
        End_Object

        Object oActionFirst_cSigCJPushButton is a cSigCJPushButton
            Set Location to 9 374
            Set Size to 14 16
            Set psImage to "ActionFirst.ico"
            Set peAnchors to anTopRight

            Procedure OnClick
                Send MoveToFirstRow of oSigCJReportControl1 
            End_Procedure
        End_Object

        Object oActionPrevious_cSigCJPushButton is a cSigCJPushButton
            Set Location to 9 390
            Set Size to 14 16
            Set psImage to "ActionPrevious.ico"
            Set peAnchors to anTopRight

            Procedure OnClick
                Send MoveUpRow of oSigCJReportControl1 
            End_Procedure
        End_Object

        Object oActionPrevious_cSigCJPushButton is a cSigCJPushButton
            Set Location to 9 406
            Set Size to 14 16
            Set psImage to "ActionNext.ico"
            Set peAnchors to anTopRight

            Procedure OnClick
                Send MoveDownRow of oSigCJReportControl1 
            End_Procedure
        End_Object


        Object oActionLast_cSigCJPushButton is a cSigCJPushButton
            Set Location to 9 422
            Set Size to 14 15
            Set psImage to "ActionLast.ico"
            Set peAnchors to anTopRight

            Procedure OnClick
                Send MoveToLastRow of oSigCJReportControl1 
            End_Procedure
        End_Object


    End_Object

    //-------------------------------------------------------------------------
    //Progress bar and data load button
    
    Object oSigCJProgressBar1 is a cSigCJProgressBar
        Set Size to 13 387
        Set Location to 199 59
        Set peAnchors to anBottomLeftRight
        Set peStyle to ePR_BarSmooth
        Set pbFlatStyle to True
        Set piBarColor to (RGB(128,197,255))
    
        Procedure Do_Update Integer iVal
            Set ComValue to iVal
            Set ComText to ("Loading Data Please Wait..." * String(iVal))
        End_Procedure
    
        Procedure Reset_Bar 
            Set ComValue to 0
            Set ComText to ""
        End_Procedure
    End_Object

    //-------------------------------------------------------------------------

    Object oSigCJReportControl1 is a cSigCJReportControl
        Set Size to 159 440
        Set Location to 36 5
    
        Set peAnchors      to anAll
        Set phoDD          to (Server(Self))
        Set piTable_Index  to 1
        Set pbActive_Track to True
        Set pbRow_Colors  to True
        Set pbRow_Item to True
        Set pbRowID_Mode to True
        Set pbPX_Save_Layout to True
        Set psPX_Tag to (Label(Parent(Self)))
        Set piLoad_Monitor  to 5   
        Set pbAuto_Fill to False
        Set piLoad_Monitor to True 
        Set pbItem_Colors to True
        Set psWatermarkBitmap to "Logo.bmp" 
        Set pbEnableTotals to True
        Set pbShade_Row to True 
        
        Procedure OnAdd_ContextMenu_ReportArea Handle hoContextMenu
            Send Add_MenuItem of hoContextMenu "Process Selected Rows"  "Process_Rows"     True     
        End_Procedure
    
        Procedure OnDefine_Columns
            Send Add_Report_Column "Order"         80 eRC_Integer  eRC_Standard "OrderDtl.Order_Number"    
            Send Add_Report_Column "Line"          80 eRC_Integer  eRC_Standard "OrderDtl.Detail_Number"   
            Send Add_Report_Column "Item"         100 eRC_String   eRC_Standard "OrderDtl.Item_ID"         
            Send Add_Report_Column "Qty"           80 eRC_Integer  eRC_Standard "OrderDtl.Qty_Ordered"     "" True
            Send Add_Report_Column "Price"         80 eRC_Decimal  eRC_Standard "OrderDtl.Price"           "" True
            Send Add_Report_Column "Line Total"   100 eRC_Currency eRC_Standard "OrderDtl.Extended_Price"  "" True
            Send Add_Report_Column "Sales Person" 100 eRC_String   eRC_Standard "SalesP.Name"               
            Send Add_Report_Column "Customer"     150 eRC_String   eRC_Standard "Customer.Name"            
            Send Add_Report_Column "Dated"         80 eRC_Date     eRC_Standard "OrderHea.Order_Date"      
            Send Add_Report_Column "Order Total"  100 eRC_Currency eRC_Standard "OrderHea.Order_Total"     "" True
            Send Add_Report_Column "!"            100 eRC_String   eRC_Standard "OrderHea.Order_Total" ;
            "(If(OrderHea.Order_Total > 10000 , 'Large Order' , ''))"           
            Send Add_Report_Column "Customer"       0 eRC_String   eRC_Preview  "Customer.Comments"        
        End_Procedure
           
        Procedure OnDouble_Click_RowID RowID Row_ID 
            Boolean bFound
            String  sOrder
                
            Move (FindByRowId(OrderDtl.File_Number, Row_ID)) to bFound
            If (bFound) Begin
                #IFDEF C_Module_Orders
                Send Activate_Order_View OrderDtl.Order_Number
                #ENDIF 
            End    
        End_Procedure
    
        Procedure OnProcess_Rows_RowID RowID Row_ID 
            Boolean bFound
                
            Move (FindByRowId(OrderDtl.File_Number, Row_ID)) to bFound
            //Showln Customer.Name " " OrderHea.Order_Total " " OrderDtl.Qty_Ordered
        End_Procedure
    
        Procedure OnSetRowColor Integer iColumn String sValue
            String sColumn_Name 
            
            Get psColumn_Label iColumn to sColumn_Name 
            If (sColumn_Name = 'Order') Begin
                If (Mod(Integer(sValue),2)=0) Set piRow_BackColor to clAqua
            End
        End_Procedure
        
        Procedure OnCreateRowItem Integer iColumn Handle hoItem String sValue
            String sColumn_Name 
                        
            Get psColumn_Label iColumn to sColumn_Name 
            If (sColumn_Name = '!') Begin
                If (Trim(sValue) > "") Set psImage of hoItem to "FlagUK_16.bmp" 
            End
            
        End_Procedure
        
        Procedure OnSetItemColor Integer iColumn String sValue
            String sColumn_Name 
            
            Get psColumn_Label iColumn to sColumn_Name 
            If (sColumn_Name = 'Order Total') Begin
                If (Number(sValue) > 5000) Begin
                    Set piItem_BackColor to clLime
                End    
                If (Number(sValue) < 1000) Begin
                    Set piItem_BackColor to clLime
                End    
            End
            If (iColumn = 10) Begin
                If (sValue > "") Begin
                    Set piItem_ForeColor to clRed
                    Set piItem_BackColor to clYellow 
                End    
            End
        End_Procedure
        
        Procedure OnReport_Row_Count Integer iRow_Count
            Set Value of oRows_Form to iRow_Count
        End_Procedure

        Procedure OnFiltered_Row_Count Integer iFiltered_Count
            Set Value of oFilter_Rows_Form to iFiltered_Count
        End_Procedure

        Procedure OnSelected_Row_Count Integer iSelectedCount
            Set Value of oSelected_Rows_Form to iSelectedCount
        End_Procedure

        //---------------------------------------------------------------------
        //Data Load Progress Events
        Procedure OnLoad_Start Integer iMax_Rows
            If (iMax_Rows = 0) Begin
                Get_Attribute DF_FILE_RECORDS_USED of (Main_File(Server(Self))) to iMax_Rows
            End
            Set ComMax of oSigCJProgressBar1 to iMax_Rows
        End_Procedure
    
        Procedure OnLoad_Monitor Integer iRow_Count
            Integer iOuter iInner iMax_Rows iMax
            
            Get ComMax of oSigCJProgressBar1 to iMax_Rows
            Move (iMax_Rows/20) to iMax
            While (iMax < iRow_Count)
                Move (iMax + iMax) to iMax
            Loop    
            If (iMax = iRow_Count) Send Do_Update of oSigCJProgressBar1 iRow_Count
        End_Procedure
        
        Procedure OnLoad_End Integer iRow_Count
            Send Reset_bar of oSigCJProgressBar1 
            Send sigInfo_Box ("Load Time for" * String(iRow_Count) * "rows is" * String(ptsTimeSpan_Load(Self)) ) "Load Times"
        End_Procedure

        //---------------------------------------------------------------------
        
    End_Object

    Object oSigCJPushButton1 is a cSigCJPushButton
        Set Location to 199 5
        Set psCaption to " Load Data"
        Set peAnchors to anBottomLeft
        
        Procedure OnClick
            Send Refresh_Report of oSigCJReportControl1            
        End_Procedure
    End_Object


    Object Double_Orders_bpo is a BusinessProcess
        Object oVendor_DD is a Vendor_DataDictionary
        End_Object
    
        Object oInvt_DD is a Invt_DataDictionary
            Set DDO_Server to oVendor_DD
        End_Object
    
        Object oSalesp_DD is a Salesp_DataDictionary
        End_Object
    
        Object oCustomer_DD is a Customer_DataDictionary
        End_Object
    
        Object oOrderhea_DD is a OrderHea_DataDictionary
            Set DDO_Server to oSalesp_DD
            Set DDO_Server to oCustomer_DD
        End_Object
    
        Object oOrderdtl_DD is a OrderDtl_DataDictionary
            Set Constrain_file to OrderHea.File_number
            Set DDO_Server to oInvt_DD
            Set DDO_Server to oOrderhea_DD
        End_Object
    
        Set Main_DD to oOrderdtl_DD
        Set Server to oOrderdtl_DD

        Procedure OnProcess
            Integer iFile iFile_Invt iCount iDetail_Num 
            String  sValue1 sValue3 sValue4 sValue5 sValue6
            
            Move OrderDtl.File_Number to iFile
            Move Invt.File_Number     to iFile_Invt 
            Send Clear of oOrderhea_DD
            Send Find of oOrderhea_DD GE 1
            While (Found)
                Get Field_Current_Value of oOrderhea_DD Field OrderHea.Last_Detail_Num to iDetail_Num
                For iCount from 1 to iDetail_Num
                    Move iCount to OrderDtl.Detail_Number
                    Send Find of oOrderdtl_DD EQ 1
                    If (Found) Begin
                        Get_Field_Value iFile 3 to sValue3
                        Get_Field_Value iFile 4 to sValue4
                        Get_Field_Value iFile 5 to sValue5
                        Get_Field_Value iFile 6 to sValue6
                        Send Clear of oOrderdtl_DD
                        Set_Field_Value iFile_Invt 1 to sValue3
                        Send Find of oInvt_DD EQ 1 
                        Set_Field_Value iFile 4 to sValue4
                        Set_Field_Value iFile 5 to sValue5
                        Set_Field_Value iFile 6 to sValue6
                        Send Request_Save of oOrderdtl_DD     
                    End
                Loop
                Send Find of oOrderhea_DD Gt 1
            Loop
        End_Procedure
    End_Object


Cd_End_Object
