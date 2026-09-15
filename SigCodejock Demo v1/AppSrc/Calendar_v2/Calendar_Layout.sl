//=============================================================================
// Project      : SigCj - VDF Classes for Codejock
// File         : Calendar_Layout.sl
// Description  : VDF Class for Codejock control
//
// Revision     : $Rev: $
//                $Date: $
//                $Author: $
//
// Requirements : Visual DataFlex 14.1+
//                Codejock SuitePro - Version 13.4.0+
//
// Copyright    : Copyright © 2009-2012 VDF SIG UK, All rights reserved.
//                Visual DataFlex Special Interest Group UK.
//                http://www.vdfsig.co.uk/
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
//=============================================================================
Use cSigCjdbModelPanel.pkg
Use cSigCjdbCJGridPromptList.pkg
Use cC_LayoutDataDictionary.dd

Cd_Popup_Object oCalendar_Layout_sl is a cSigCjdbModalPanel
    Set Label to "Layout Lookup List"
    Set Size to 134 238
    Set Location to 4 5
    //Set pbMatchSearch to True

    Object oC_Layout_DD Is A cC_LayoutDataDictionary
    End_Object // oC_Layout_DD

    Set Main_DD To oC_Layout_DD
    Set Server  To oC_Layout_DD

    Object oSelList is a cSigCjCJGridPromptList
        Set Size to 105 228
        Set Location to 5 5
        Set peAnchors to anAll
        Set Ordering to 1

        Procedure OnLoad_Columns
            Handle hoColumn
            Get Add_Column File_Field C_Layout.Name 200 "Name" to hoColumn
        End_Procedure

    End_Object // oSelList

Cd_End_Object // oCalendar_Layout_sl
