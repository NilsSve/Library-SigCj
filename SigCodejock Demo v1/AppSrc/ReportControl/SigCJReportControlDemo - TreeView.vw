Use Windows.pkg
Use DFClient.pkg
Use cSigCjReportControl.pkg
Use Vendor.DD
Use Invt.DD

Struct tdReportGroup
    String  sGroupName
    Integer iCount
    Boolean bExpanded
End_Struct

Deferred_View Activate_oSigCJReportControlDemo_TreeView for ;
Object oSigCJReportControlDemo_TreeView is a dbView

    Set Border_Style to Border_Thick
    Set Size to 292 386
    Set Location to 10 17
    Set piMinSize to 292 386
    Set Label to "Codejock Demo - Report Control - Tree View"
    Set Icon to "SIG.ico"
    
    Object oSigCJReportControl1 is a cSigCJReportControl
        
        Property tdReportGroup[] ptaReportGroup
        
        Property Integer piImageFolderClosed
        Property Integer piImageFolder
        Property Integer piImageAbout
        
        Set Size to 223 376
        Set Location to 33 6
        Set peAnchors to anAll
        //Set data source to text, even though we will populate it with data from the db
        Set peDb_Type to eRC_db_Text
        //Set pbRow_Item to True so that the OnCreateRowItem event is called
        Set pbRow_Item to True
        //Don't show the group box - we will group programatically
        Set pbShowGroupBox to False
        //Set Row_Colors to True. Not because we want row Colors, but we need to turn on the OnComBeforeDrawRow event
        Set pbRow_Colors to True
        //Set reference column
        Set piRef_Column to 4
        //Turn off the auo row ref. We will use a serialised row id as the reference (specified in the piRef_Column)
        Set pbAuto_Row_Ref to False
        
        
        //Method to keep track of group labels and the count of items within the group
        Procedure Increment_Group_Count String sGroup
            tdReportGroup[] taReportGroup
            Integer iGroup
            Boolean bFoundGroup
            
            Get ptaReportGroup to taReportGroup
            For iGroup from 0 to (SizeOfArray(taReportGroup)-1)
                If (taReportGroup[iGroup].sGroupName = sGroup) Begin
                    Add 1 to taReportGroup[iGroup].iCount 
                    Move True to bFoundGroup 
                    Move (SizeOfArray(taReportGroup)-1) to iGroup     
                End
            Loop
            If (not(bFoundGroup)) Begin
                Move (SizeOfArray(taReportGroup)) to iGroup
                Move sGroup to taReportGroup[iGroup].sGroupName
                Add 1 to taReportGroup[iGroup].iCount 
            End
            Set ptaReportGroup to taReportGroup
        End_Procedure
        
        //Method to return the number of items within a group (specified by the label)
        Function Group_Count String sGroup Returns Integer
            Integer iRetVal iGroup
            tdReportGroup[] taReportGroup
            
            Get ptaReportGroup to taReportGroup
            For iGroup from 0 to (SizeOfArray(taReportGroup)-1)
                If (taReportGroup[iGroup].sGroupName = sGroup) Begin
                    Move taReportGroup[iGroup].iCount to iRetVal
                    Move (SizeOfArray(taReportGroup)-1) to iGroup     
                End
            Loop
            Function_Return iRetVal
        End_Function
        
        //OnCreate. Set a few more properties that we don't (yet) have property wrappers for.
        Procedure OnCreate
            Forward Send OnCreate
            
            Set ComAllowColumnReOrder to False
            Set ComAllowColumnRemove to False
            Set ComRecordsTreeFilterMode to OLExtpReportFilterTreeByParentAndChildren
            Set ComHorizontalGridStyle of (phoReportPaintManager(Self)) to OLExtpGridNoLines
        End_Procedure

        Procedure OnDefine_Columns
            Send Add_Report_Column "Description" 300 eRC_String   eRC_Standard "" ""
            Send Add_Report_Column "Unit Price"   90 eRC_Currency eRC_Standard "" ""
            Send Add_Report_Column "On Hand"      90 eRC_Integer  eRC_Standard "" ""
            //Hidden column on which to group
            Send Add_Report_Column ""              0 eRC_String   eRC_Standard "" ""
        End_Procedure

        //Set the Tree Column
        Procedure OnCreateColumn Integer iColumn Handle hoCol
            If (iColumn=0) Begin
                Set ComTreeColumn of hoCol to True
            End
        End_Procedure
    
        //We are NOT opening a data source BUT we will use this suitable hook for clearing file buffers, initialising properties and loading icons
        Procedure OnOpen_DataSource
            Integer iIndex
            tdReportGroup[] taReportGroup
            
            Set pbEOF to False
            Set ptaReportGroup to taReportGroup
            //Add images
            Get AddImage of ghoSigCjGlobalSetting "Misc_Folder_Closed.ico" 0 0 to iIndex
            Set piImageFolderClosed to iIndex
            Get AddImage of ghoSigCjGlobalSetting "Misc_Folder.ico" 0 0 to iIndex
            Set piImageFolder to iIndex
            Get AddImage of ghoSigCjGlobalSetting "Misc_about.ico" 0 0 to iIndex
            Set piImageAbout to iIndex
            //clear file buffer
            Clear Invt
        End_Procedure
        
        //Find next record in db. Use Add_Item_Data to upload values we want displayed in the report control (plus an additional reference value)
        Procedure OnPrepare_RowData
            Find GT Invt by Index.2
            If (not(Found)) Begin
                Set pbEOF to True
            End
            Else Begin
                Relate Invt
                Send Add_Item_Data (Trim(Invt.Description))
                Send Add_Item_Data Invt.Unit_Price
                Send Add_Item_Data Invt.On_Hand
                Send Add_Item_Data (Trim(Vendor.Name))
                Send Add_Item_Data (SerializeRowID(GetRowID(Invt.File_Number)))
            End        
        End_Procedure
        
        //Add child items to a report item
        Procedure DoAddChildDetail String sLabel String sData Handle hoChilds Handle hoChild Handle hoItem
            Variant vItem
            
            Set pvComObject of hoChild to (ComAdd(hoChilds))
            Get ComAddItem of hoChild (sLabel*sData) to vItem
            Set ComTag of hoChild to (SerializeRowID(GetRowID(Invt.File_Number)))
            Set pvComObject of hoItem to vItem
            Set ComIcon of hoItem to (piImageAbout(Self))
        End_Procedure

        //Use OnCreateRowItem to add additional child records. We don't need to do this every time the event is called, simply once per row
        //..so we wait until the passed column is the last one in the row (iColumn=piColumn_Count)
        Procedure OnCreateRowItem Integer iColumn Handle hoItem String sValue
            Handle hoChilds hoChildRecord hoChildItem      
            
            If (iColumn=piColumn_Count(Self)) Begin
                Send Increment_Group_Count (Trim(Vendor.Name))
                
                Get Create U_cSigCJComReportRecords to hoChilds
                Set pvComObject of hoChilds to (ComChilds(phoReportRecord(Self)))
                Get Create U_cSigCJComReportRecord to hoChildRecord
                Get Create U_cSigCJComReportRecordItem to hoChildItem
                
                Send DoAddChildDetail "Vendor Part ID:" (Trim(Invt.Vendor_Part_ID)) hoChilds hoChildRecord hoChildItem 
                Send DoAddChildDetail "Item ID:" (Trim(Invt.Item_ID)) hoChilds hoChildRecord hoChildItem 
                
                Send Destroy of hoChildItem
                Send Destroy of hoChildRecord
                Send Destroy of hoChilds
            End
        End_Procedure
    
        //Programmatically specify the ordering
        Procedure OnSetGrouping tdRC_Ordering[] ByRef taRC_Ordering
            Move 3 to taRC_Ordering[0].iColumn
        End_Procedure
        
        //Populate as normal but then process the rows so we can amend the group row labels
        Procedure ComPopulate
            Forward Send ComPopulate
            Send DoProcessAllRows
        End_Procedure

        {MethodType=Event}
        Procedure OnProcessRow Handle hoRow 
        End_Procedure
    
        {MethodType=Event}
        Procedure OnProcessGroupRow Handle hoRow
            Handle hoRows
            String  sCaption
            Boolean bExpanded
            Integer iCount
            
            Get ComGroupCaption of hoRow to sCaption
            Move (Trim(sCaption)) to sCaption
            If (Left(sCaption,1)=":") Begin
                Move (Trim(Replace(":",sCaption,""))) to sCaption        
            End

            Get Group_Count sCaption to iCount            
            // Set ComExpanded of hoRow to False
            Move (sCaption*"(%1)") to sCaption
            Move (SFormat(sCaption,String(iCount))) to sCaption
            Set ComGroupCaption of hoRow to sCaption        
        End_Procedure 
        
        {MethodType=Method Visibility=Public}
        Procedure DoProcessAllRows
            Handle hoRows hoRow hoGroupRow
            Integer iRow iCount
            Variant vRow
            Boolean bIsGroupRow
            
            If (not(IsComObjectCreated(Self))) Begin
                Procedure_Return
            End
            Get phoReportRow to hoRow
            Get phoReportGroupRow to hoGroupRow
            Get phoReportRows to hoRows
            Set pvComObject of hoRows to (ComRows(Self))
            Get ComCount of hoRows to iCount
            Subtract 1 from iCount
            For iRow from 0 to iCount
                Get ComRow of hoRows iRow to vRow
                Set pvComObject of hoRow to vRow
                
                Get ComGroupRow of hoRow to bIsGroupRow
                If (bIsGroupRow) Begin
                    Set pvComObject of hoGroupRow to vRow
                    Send OnProcessGroupRow hoGroupRow
                End
                Else Begin
                    Send OnProcessRow hoRow 
                End
                //Have to re-get the count because we may have collapsed a row
                Get ComCount of hoRows to iCount
                Subtract 1 from iCount
            Loop     
        End_Procedure 
        
        //Set the group icons (folder images)
        Procedure OnComBeforeDrawRow Variant llRow Variant llItem Variant llMetrics
            Handle hoRow hoGroupRow hoMetrics
            Boolean bIsGroupRow bExpanded
            Integer iImage
            
            Get phoReportRow to hoRow
            Set pvComObject of hoRow to llRow
            Move (IsNullComObject(ComRecord(hoRow))) to bIsGroupRow
            If (bIsGroupRow) Begin
                Get phoReportGroupRow to hoGroupRow
                Set pvComObject of hoGroupRow to llRow
                Get ComExpanded of hoGroupRow to bExpanded
                Move (If(bExpanded,piImageFolder(Self),piImageFolderClosed(Self))) to iImage
                Get Create U_cSigCJComReportRecordItemMetrics to hoMetrics
                Set pvComObject of hoMetrics to llMetrics
                Set ComGroupRowIcon of hoMetrics to iImage
                Set ComGroupRowIconAlignment of hoMetrics to (olextpGroupRowIconBeforeText + olextpGroupRowIconVCenterToText)
                Send Destroy of hoMetrics
            End
        End_Procedure

        Procedure OnActive_Track String sID
            Set value of oActive_Track_Row to sID
        End_Procedure
        
    End_Object

    Object oGroup1 is a Group
        Set Size to 29 378
        Set Location to 1 4
        Set peAnchors to anTopLeftRight

        Object oActive_Track_cb is a CheckBox
            Set Location to 12 10
            Set Size to 10 50
            Set Label to "Active Track"

            Procedure OnChange
                Boolean bChecked

                Get Checked_State to bChecked
                Set pbActive_Track of oSigCJReportControl1 to bChecked
            End_Procedure

        End_Object

        Object oFilter_Search_Form is a Form
            Set Size to 13 102
            Set Location to 10 267
            Set peAnchors to anBottomRight
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

    End_Object

    Object oActive_Track_Row is a Form
        Set Location to 264 25
        Set Size to 13 52
        Set Label to "Row"
        Set Label_Justification_Mode to JMode_Right
        Set Label_Col_Offset to 2
        Set peAnchors to anBottomLeft
    End_Object
    
    Object oButton1 is a Button
        Set Location to 267 329
        Set Label to "ReLoad"
        Set peAnchors to anBottomRight
    
        // fires when the button is clicked
        Procedure OnClick
            Send Reset_Data_Properties of oSigCJReportControl1
            Send Rebuild_Report        of oSigCJReportControl1
        End_Procedure
    
    End_Object
    

Cd_End_Object
