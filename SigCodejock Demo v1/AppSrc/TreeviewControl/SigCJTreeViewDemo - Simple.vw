Use Windows.pkg
Use DFClient.pkg
Use cSigCJTreeView.pkg

Deferred_View Activate_oSigCJTreeViewDemo_Simple_View for ;
Object oSigCJTreeViewDemo_Simple_View is a dbView

    Set Border_Style to Border_Thick
    Set Size to 200 300
    Set Location to 6 9
    Set Label to "Codejock Demo - Treeview - Simple" 
    Set Icon to "SIG.ico"

    Object oSigCJTreeView1 is a cSigCJTreeView  
        Set Size to 188 100
        Set Location to 7 8
               
        Procedure OnCreateTree
            Handle  hoNode hoRoot

            Get Add_Root_Node "Martin" to hoNode
                Get Add_Child_Node "Chip" to hoNode
                Get Add_Child_Node "Pin"  to hoNode
                Set psImage of hoNode to "Newdoc.ico" 

            Get Add_Root_Node "Ian"   to hoNode
                Get Add_Child_Node "Humbugs" to hoNode
                Set psImage of hoNode to "Newdoc.ico" 
                
            Get Add_Root_Node "Peter" to hoNode
                Get Add_Child_Node "Humbugs" to hoNode
                Set psImage of hoNode to "Newdoc.ico" 

            Get Add_Root_Node "Nick" to hoNode
            Set psImage of hoNode to "Newdoc.ico" 
        End_Procedure

    End_Object

Cd_End_Object
