Use Windows.pkg
Use DFClient.pkg
Use cSigCjChartControl.pkg
Use Customer.DD
Use SalesP.DD
Use OrderHea.DD

Deferred_View Activate_oChartSalesBySalesPerson for ;
Object oChartSalesBySalesPerson is a dbView
    Object oSalesP_DD is a SalesP_DataDictionary
    End_Object

    Object oCustomer_DD is a Customer_DataDictionary
    End_Object

    Object oOrderHea_DD is a OrderHea_DataDictionary
        Set DDO_Server to oSalesP_DD
        Set DDO_Server to oCustomer_DD
        
        Property String psSalespId
        
        Procedure OnConstrain
            If (psSalespId(Self)<>'') Begin
                Constrain OrderHea.SalesPerson_ID eq (psSalespId(Self))
            End
        End_Procedure
    End_Object

    Set Main_DD to oOrderHea_DD
    Set Server to oOrderHea_DD

    Set Border_Style to Border_Thick
    Set Size to 253 446
    Set Location to 2 2
    Set piMinSize to 253 446
    Set Label to "Chart Sales Per Sales Person"
    
    Function SalesPTotal String sSalePersonID Returns Integer
        Integer iOrderTotal iTotal
        
        Set psSalespId of oOrderHea_DD to sSalePersonID
        Send Rebuild_Constraints of oOrderHea_DD
        Send Clear of oOrderHea_DD
        Send Request_Find of oOrderHea_DD First_Record OrderHea.File_Number 1
        While (Found)
            Get Field_Current_Value of oOrderHea_DD Field OrderHea.Order_Total to iOrderTotal
            Move (iTotal+iOrderTotal) to iTotal
            Send Request_Find of oOrderHea_DD GT OrderHea.File_Number 1
        Loop
        
        Function_Return iTotal
    End_Function

    Object oSalesPChart is a cSigCJChart
        Set Size to 253 446
        Set peAnchors to anAll
        Set psTitleText to "Chart Sales Per Sales Person"
        Set pbLegendVisible to False
        
        Object oSalesPDiagram is a cSigCjDiagram
            Set pbAllowScroll to True

            Object oXAxis is a cSigCJAxis
                Set peWhichAxis to xtpChartAxisX
                Set piAxisLabelAngle to 55  // Presents the sales person name on the X-Axis at an angle of 55 degrees                
                Set pbAxisRangeViewAutoRange to False // Turns off the auto generation of the view range (the portion of the axis that is first visible), this then enables you to set the max and min view range yourself.
                Set pbAxisRangeAutoRange to False // Turns off the auto generation of the range (the portion of the axis that can be accessed using the scroll bar), this then enables you to set the max and min range yourself.
                Set prAxisRangeViewMaxValue to 15.5
                Set prAxisRangeMaxValue to 27
                Set prAxisRangeViewMinValue to -0.5
                Set prAxisRangeMinValue to -0.5
                Set pbAxisLabelBold to True
                Set psAxisTitleText to "Sales Person"
            End_Object
            
            Object oYAxis is a cSigCJAxis
                Set peWhichAxis to xtpChartAxisY
                Set peAxisLabelFormatCategory to xtpChartCurrency
                Set pbAxisLabelFormatUseThousandSeparator to True
                Set pbAxisRangeShowZeroLevel to True
                Set psAxisTitleText to "Sales Total"           
                Set pbAxisGridSpacingAuto to False
                Set prAxisGridSpacing to 5000
                
                Object oContantLine is a cSigCJAxisConstantLine
                    Set prAxisValue to 18000                   
                    Set psText to "Target"
                    Set pbBold to True
                    Set peDashStyle to xtpChartDashStyleDash
                End_Object
            End_Object
            
            Object oSalesPSeries is a cSigCJSeries
                Set peSeriesStyle to xtpBarSeriesStyle
                Set peLabelFormatCategory to xtpChartCurrency
                Set pbLabelFormatUseThousandSeparator to True
                
                Procedure OnAddChartData
                    String sSalespID
                    Integer iTotal
                    
                    Clear SalesP
                    Find Gt SalesP by Index.1
                    While (Found)
                        Move SalesP.ID to sSalespID
                        Get SalesPTotal sSalespID to iTotal
                        If (iTotal<>0) Begin
                            Send AddPoint "" SalesP.Name iTotal
                        End
                        Clear SalesP
                        Move sSalespID to SalesP.ID
                        Find Gt SalesP by Index.1
                    Loop
                End_Procedure
            End_Object
        End_Object
    End_Object
Cd_End_Object