//*************************************************************************
//*                                                                       *
//*  Confidential Trade Secret.                                           *
//*  Copyright (c) 1997-2005 Mertech Data Systems Inc, Miami Florida      *
//*  All rights reserved.                                                 *
//*  DataFlex is a registered trademark of Data Access Corporation.       *
//*                                                                       *
//*************************************************************************
USE UI

//================================================================================================
// 2.1.15 - marcelo 04/20/2000
//      DO_GETFILENUMBER_DRIVERNAME has been changed to handle ORAFlex and SQLFlex driver only
// 2.1.16 - marcelo 05/09/2000
//      call_Oracle_Stored_Function was not binding all variables when calling Oracle function
// 2.1.17 - marcelo 05/12/2000
//      including DF_FETCH_FIELD_COUNT and DF_FETCH_FIELDNUMBER attributes
// 2.1.18 - marcelo 05/21/2000
//      Call_Oracle_Stored_Function was binding wrong variable names
// 2.1.19 - marcelo 05/22/2000
//      Stored Procedure/function calls now are handling file field buffer as arguments properly
// 2.2.0 -  marcelo 06/24/2000
//      SET_SCHEMA_NAME and SET_CURRENT_SERVER are avaliable for ORAFlex 3.x
// 2.2.1 -  marcelo 06/30/2000
//      LOGGED_USERS returns current number of driver's users logged
// 2.2.2 -  marcelo 07/10/2000
//      MERTECH_WARNING_MESSAGE has been created to enable/disable warning message when restructuring table
// 2.2.3 -  marcelo 08/09/2000
//      REEXEC_ORACLE_STORED_PROCEDURE has been created allowing reexecution of current procedure
//      REEXEC_STORED_PROCEDURE
// 2.2.4 -  marcelo 08/23/2000
//      SQL_CANCEL_QUERY_STMT can be used for delete an opened cursor for embedded sql purposes
// 2.2.5 -  marcelo 09/03/2000
//      DISABLE_SELECT_COLUMNS_ERRORS has been implemented to allow cSQLdbList objects disabling select columns
//      error message to come up
// 2.2.6 -  marcelo 10/03/2000
//      We are forcing our local variables to be LOCAL variables to avoid any kind of crashing problem
// 2.2.7 -  marcelo 10/11/2000
//      An attribute named DF_FILE_RETRIEVE_RECNUM is available. By default it's true. When we set that to false
//      ORAFlex/SQLFlex won't retrieve recnum value generated for the new row.
// 2.2.8 -  marcelo 12/06/2000
//      SQL_REFRESH_CACHE has been implemented allowing the use to refresh the current cache forcing the next
//      FIND command to retrieve the record from the data base
// 2.2.9 -  marcelo 12/13/2000
//      Check if the argument value lenght is great than zero inside SET_SQL_CONSTRAINT before making the call_driver call. This
//      will avoid a crashing problem with VDF
// 2.2.10 - marcelo 01/04/2001
//      Fixing sintaxe error problem when calling SQL Server stored procedure
// 2.2.11 - marcelo 01/05/2001
//      We implemented a SQL_START_TRANSACTION_STMT command for starting a transaction when using embedded SQL statement.
//      This is only required when using against SQLFlex
//      SQL_COMMIT_STMT and SQL_ROLLBACK_STMT now has a supported code to SQLFlex
// 2.2.12 - marcelo 02/15/2001
//      CALL_SQLFLEX7_PROCEDURE wasn't been compiled properly when having more than 12 parameters.
//      CALL_SQLFLEX7_PROCEDURE wasn't binding local variables properly.
//      Working around for CALL_DRIVER crashing problem when using VDF7 has been implemented.
// 2.2.13 - marcelo 03/01/2001
//      NATIVE_OPTIMIZATION has been implemented for been used with SQLFlex. It can change the native optimization used.
// 2.2.14 - marcelo 05/16/2001
//      MAXIMUM_NUMBER_OF_USERS returns the maximum number of users for your current driver license
// 2.2.15 - marcelo 06/01/2001
//      GET_SQL_NUM_COLS retrieves the number of columns returned by current Query
//      GET_SQL_NUM_ROWS retrieves the number of rows afected by current Query
//      GET_SQL_COL_NAME retrieves the column name and size for a column returned by current Query
// 2.2.16 - marcelo 08/15/2001
//      SET_ISOLATION_LEVEL can be used from SQLFlex to Controls the default transaction locking behavior for
//      SELECT statements issued by a connection.
//      We have implemented support for DF_FILE_GET_SERVERNAME_FROM_LOGIN, DF_FILE_GET_DATABASENAME_FROM_LOGIN, DF_FILE_GET_SCHEMANAME_FROM_LOGIN
//      get/set_attributes.
//        - marcelo 08/21/2001
//      SET_SESSION_PARAMETER has been implemented. We can use this attribute before doing a LOGIN using SQLFlex to TURN ON/OFF
//      automatic OLEDB Oem to ANSI translation
// 2.2.17 - marcelo 12/12/2001
//      We defined DF_LOCK_TYPE_PAGE. This lock type is supported by SQLFlex only
// 2.2.18 - MARCELO 04/22/2002
//      GET_SERVER_CFG has been implemented. Using this command we can retrieve the following informations from DB Server: Server Revision;
//      support for Descending index segments; support for Case Insensitive index segments
// 2.2.19 - MARCELO 05/06/2002
//      SET_MAX_OPEN_CURSORS and GET_MAX_OPEN_CURSORS are available for SQLFlex now.
//      SET_SQL_LOCK_TIMEOUT and GET_SQL_LOCK_TIMEOUT had been implemented for SQLFlex
//        - MARCELO 05/07/2002
//      Increase Integer argument buffer length as argument for Oracle procedure call to keep the maximum Integer value allowed
// 2.2.20 - MARCELO 05/20/2002
//      Add support for DB2 driver
//      CALL_DB2_PROCEDURE has been created for calling DB2 stored procedures
//      KEEP_FILES_OPEN os been supported by MDSDB2 and SQLFlex
// 2.3.1  - MARCELO 06/07/2002
//      We are supporting constants, window entries, file fields as arguments for stored procedure call
// 2.3.2  - MARCELO 06/10/2002
//      CALL_DB2_PROCEDURE will set ERR to true if Procedure doesn't exist.
// 2.3.3  - MARCELO 06/22/2002
//      GET_MORE_RESULTS and GET_RESULTS can be used for retrieving a Result Set returned by a DB2 stored procedure
// 2.3.4  - MARCELO 08/02/2002
//      GET_CURRENT_USER_NAME can be used to retrieve the logged user name when using trusted connection in DB2
// 2.3.5  - MARCELO 12/09/2002
//      Add support for using more than one global cursor for embedded SQL purpose
// 2.3.6  - MARCELO 01/02/2003
//      Add Enum List for Inverse Key types
//      SET_DEFAULT_DATABASE_NAME and GET_DEFAULT_DATABASE_NAME had been implemented for SQLFlex 8. You can use these commands
//      to set/get the default user database
// 2.3.7  - MARCELO 01/10/2003
//      SQL_SET_LOCAL_TD_PATH and SQL_GET_LOCAL_TD_PATH can be used for Set/Get Local TD path
// 2.3.8  - MARCELO 03/06/2003
//      CREATE_DB2_DATABASE can be used for creating a DB2 database with the same DataFlex collating sequence
// 2.3.9  - MARCELO 03/25/2003
//      Crashing issue on Linux when executing Embedded SQL commands
// 2.3.10 - MARCELO 03/27/2003
//      GET_SQL_NUM_COLS command has been renamed to SQL_GET_NUM_COLS
//      GET_SQL_NUM_ROWS command has been renamed to SQL_GET_NUM_ROWS
//      GET_SQL_COL_NAME command has been renamed to SQL_GET_COL_NAME
//      SQL_FETCH_COLUMN can be used to retrieve a specific column value from current row retrieved by SQL_FETCH_NEXT_ROW
// 2.3.11 - MARCELO 04/03/2003
//      GET_SERVER_CFG retrieve Server Minor Revision now when using SERVER_MIN_REVISION argument
// 2.3.12 - MARCELO 04/14/2003
//      Attribute DF_FILE_NAME_SPACE is available for set/get PostgreSQL Schema Name
// 2.3.13 - MARCELO 04/30/2003
//      SQL_FETCH_NEXT_ROW does support many arguments without compilation error
//      Add missing argument for CALL_DRIVER command call for SQL_ROLLBACK_STMT and SQL_COMMIT_STMT
// 2.3.14 - MARCELO 05/27/2003
//      SET_SESSION_PARAMETER is supported for ORAFlex as well (since version 3.2.1.8)
//      CALL_SQLFLEX7_PROCEDURE will retrieve the output arguments even if an error happens
// 2.3.15 - MARCELO 07/14/2003
//      Add new commands MDS_SET_PROCEDURE_NAME,  MDS_SET_PROCEDURE_PARAMETER, MDS_PROCEDURE_EXECUTE and MDS_GET_PROCEDURE_PARAMETER
//      for calling Oracle Stored procedure
// 2.3.16 - MARCELO 08/08/2003
//      Add new command MDS_GET_OUTPUT_VALUE for embedded SQL statements
//      Add definition for DF_FIELD_NATIVE_NAME attribute
// 2.3.17 - MARCELO 08/27/2003
//      Renamed MDS_SET_PROCEDURE_NAME,  MDS_SET_PROCEDURE_PARAMETER, MDS_PROCEDURE_EXECUTE, MDS_GET_PROCEDURE_PARAMETER, MDS_GET_OUTPUT_VALUE
//      to SQL_SET_PROCEDURE_NAME,  SQL_SET_PROCEDURE_PARAMETER, SQL_PROCEDURE_EXECUTE, SQL_GET_PROCEDURE_PARAMETER, SQL_GET_OUTPUT_VALUE
//      Add command SQL_ESCAPE_STRING for MySQLFlex and PGFlex, which Escapes special characters in a string for use in a SQL statement
// 2.3.18 - MARCELO 09/02/2003
//       Add a global function SQLESCAPESTRING which calls the command SQL_ESCAPE_STRING
// 2.3.19 - MARCELO 10/17/2003
//       Add new macro commands SQL_SET_FUNCTION_NAME, SQL_SET_FUNCTION_PARAMETER, SQL_FUNCTION_EXECUTE, SQL_GET_FUNCTION_RETURN, SQL_GET_FUNCTION_PARAMETER
// 2.3.20 - MARCELO 10/29/2003
//       Extend SQL_ESCAPE_STRING support for SQLFlex 8
// 2.4.0  - MARCELO 03/09/2004
//       Extend SQL_REFRESH_CACHE support for SQLFlex 8
// 2.4.1  - MARCELO 03/30/2004
//       Add SQL_GET_STATEMENT macro command which can be used to retrieve the Embedded SQL Statement executed
// 2.4.2  - MARCELO 04/22/2004
//       Renamed command GET_CURRENT_SERVER to GET_CURRENT_SQL_SERVER due incopatibilities with VDF
// 2.4.3  - MARCELO 05/10/2004
//       Renamed command SET_CURRENT_SERVER to SET_CURRENT_SQL_SERVER due incopatibilities with VDF
//       Removed SET_HOST_NAME/GET_HOST_NAME commands
// 2.4.4   - MARCELO 05/26/2004
//       Extend SQL_ESCAPE_STRING support for ORAFlex 8
// 2.4.5   - MARCELO 07/13/2004
//       Extend SET_SQL_CONSTRAINT and SQL_CONSTRAINT for MySQLFlex and PgFlex
//         - MARCELO 07/15/2004
//       SET_DATABASE_PORT and GET_DATABASE_PORT can be used with MySQLFlex and PgFlex to specify DB PORT for connection
//         - MARCELO 07/19/2004
//       Add CALL_PGSQL_STORED_FUNCTION which can be used to call PostgreSQL SQL Functions
// 2.4.6   - MARCELO 11/03/2004
//       SET_DATABASE_SOCKET and GET_DATABASE_SOCKET can be used with MySQLFlex to set/get the default socket used for connection
// 2.4.7   - MARCELO 11/17/2004
//       Add SET_AUTENTICATION_MODE command which can be used before an Oracle LOGIN to set the autentication mode used
//       (DEFAULT or SYSDBA)
//       Add CALLDRV_DIRECT_PATH_LOAD
// 2.4.8   - MARCELO 12/07/2004
//       Error "syntax error at or near ," when using CALL_PGSQL_STORED_FUNCTION with variables as command arguments
// 2.4.9   - MARCELO 01/04/2005
//       Extend GET_SERVER_CFG adding an option allowing to retrieve the complete DB Server Version Description
// 2.4.10  - MARCELO 02/07/2004
//       Add support for File Attribures DF_FILE_OEM_TRANSLATION and DF_FILE_EPOCH_YEAR
// 2.4.11  - MARCELO 02/18/2005
//       Fixed issue in GET_DATABASE_NAME when using it with PgFlex
// 2.4.12  - MARCELO 03/23/2005
//       Add new commands for Oracle LOB manipulation : SQL_LOB_READ, SQL_LOB_WRITE, SQL_LOB_LENGTH, SQL_LOB_APPEND, SQL_LOB_ERASE,
//            SQL_LOB_TRUNCATE, SQL_LOB_LOADFROMFILE
//       Add new command SQL_INITIALIZE_SEQUENCE which can be used to initilize Oracle Recnum's Sequence
//       Add new command DIRECT_PATH_LOAD which can be used for Load Data Process thru Oracle Direct Path Load interface
//  2.4.13  - MARCELO 03/28/2005
//       Redefine positions for DF_MESSAGE_PROGRESS_STATUS and DF_MESSAGE_PROGRESS_CONTINUE
//  2.4.14  - MARCELO 04/04/2005
//      Add support for Embedded SQL generic cursor commands to PgFlex
//  2.4.15  - MARCELO 04/06/2005
//      Extend SQL_INITIALIZE_SEQUENCE to support PgFlex
//      Extend GET_SERVER_CFG adding a newer option named SERVER_ENCODING
//      Add new commands GET_CLIENT_CFG and SET_CLIENT_CFG
//  2.4.16
//      Add SQL_SAVE_SET_ATTRIBUTES which can be used to set up SQL Server Bulk Copy Parameters for SQLFlex usage
//  2.4.17
//      Add DO_BIND_PAR_RET for internal use only. This will be used by CALL_ORACLE_STORED_FUNCTION
//  2.4.18
//      Extend GET_SERVER_CFG adding a new option named CONNECTION_ACTIVE
//  2.4.19 - MARCELO 07/14/2005
//      Add commands to call MySQL stored procedure/function
//  2.4.20 - MARCELO 07/20/2005
//      Add command GET_CONNECTION_STATUS
//  2.4.21 - MARCELO 08/03/2005
//      Optimize DO_PASS_ARGUMENTS
//  2.5.0 - MARCELO 08/29/2005
//      SET_ISOLATION_LEVEL has been extended to MySQLFlex
//      Add SQL_ENABLE_RECONNECT which is supported by MySQLFlex. This command enable the MySQL auto-connect driver option
//      Add SQL_END_SAVERECORD which can be used to END the SAVE/SAVERECORD along with SQL_LOB_WRITE in MySQLFlex
//      Add SQL_ENABLE_RECONNECT for MySQLFlex
//      Extend SQL_SET_PROCEDURE_NAME, SQL_SET_PROCEDURE_PARAMETER, SQL_PROCEDURE_EXECUTE, SQL_GET_PROCEDURE_PARAMETER to support MySQLFlex
//      Extend SQL_SET_FUNCTION_NAME, SQL_SET_FUNCTION_PARAMETER, SQL_FUNCTION_EXECUTE, SQL_GET_FUNCTION_RETURN, SQL_GET_FUNCTION_PARAMETER to support MySQLFlex
//  2.5.1 - MARCELO 09/07/2005
//      SQL_SET_PROCEDURE_PARAMETER will inform the data type parameter to the driver
//  2.5.2 - MARCELO 09/15/2005
//      CALL_STORED_PROCEDURE is been supported by SQLFlex
//      GET_SQL_CONSTRAINT can be used to retrieve the current Constraint expression
//        - MARCELO 09/22/2005
//      SQL_GET_COL_ATTRIBUTE can be used to retrieve the Select statement column attributes
//      SQL_NEXT_RESULT_SET can be used to find out if there another resultset available
//   2.5.3 - MARCELO 10/27/2005
//      Extend SET_MAX_OPEN_CURSORS, GET_MAX_OPEN_CURSORS, GET_OPENED_CURSORS to PgFlex
//   2.5.4 - MARCELO 11/28/2005
//      Add AvailableSQLServers and AvailableSQLServerName functions which can be used to enumerate available SQL Servers
//   2.5.5 - MARCELO 03/21/2006
//      ACTIVATE_TIME_STAMP was not setting the proper values for the CALL_DRIVER command call
//   2.5.6 - MARCELO 05/26/2006
//      Extend SET_CLIENT_CFG macro command and add UNIQUE_CHECKS to enable/disable uniqueness checks for secondary indexes in InnoDB tables
//   2.5.7 - MARCELO 07/25/2006
//      Create Function and Procedure Set for UseRowCountInTransactions
//      Add new options DF_STRUCTEND_OPT_FORCE_INVK and DF_STRUCTEND_OPT_OLD_INVK_NAME used by Structure_End
//   2.5.8 - MARCELO 10/10/2006
//      Add Procedure Set and Function SqlUseDataflexDateFormat which can be used to set the date format for the date columns returned by the embedded SQL Select statements
//   2.5.9 - MARCELO 11/21/2006
//      Extend SET_CLIENT_CFG and GET_CLIENT_CFG then we can set/get the encoding used by a specific database.
//             Besides of that GET_CLIENT_CFG has a new attribute "ENCODING_ID" which one can be used to retrieve the encoding Id for the given database
//   2.5.10 - MARCELO 12/14/2006
//      Change the default value for constants in DO_BIND_PARAMETERS
//   2.5.11 - MARCELO 03/12/2007
//      Add new Procedure Set and Function named SqlForceFieldsNotNull. This is going to Force ORAFlex and MySQLFlex to save a Null-Able column with a NOT NULL value
//--------------------------------------------------------------------------------------------------------------------------------------------------------------
//

#REM -----------------------------------------------
#REM Mertech Data Systems Inc. - www.mertechdata.com
#REM mertech.inc Version 2.5.11
#REM -----------------------------------------------

#REPLACE DF_FILE_PRIMARY_KEY  (DF_FILE_RECORD_REREAD+1)
//#REPLACE DF_FILE_INDEX_NAME   (DF_FILE_RECORD_REREAD+2)
#REPLACE DF_FILE_NUMBER_INVERSE_KEYS (DF_FILE_RECORD_REREAD+3)
//#REPLACE DF_FILE_INDEX_STATUS (DF_FILE_RECORD_REREAD+4)
#REPLACE DF_FILE_SET_MODE               (DF_FILE_RECORD_REREAD+5)
#REPLACE DF_FILE_DATABASENAME           (DF_FILE_RECORD_REREAD+6)
#REPLACE DF_FILE_MAX_ROWS               (DF_FILE_RECORD_REREAD+7)
#REPLACE DF_FILE_TABLE_NAME             (DF_FILE_RECORD_REREAD+8)
#REPLACE DF_FILE_CACHE_MODE             (DF_FILE_RECORD_REREAD+9)
#REPLACE DF_FILE_STORAGE_BASE           (DF_FILE_RECORD_REREAD+10)
#REPLACE DF_FILE_STATIC                 (DF_FILE_RECORD_REREAD+11)
#REPLACE DF_FILE_SERVER_NAME            (DF_FILE_RECORD_REREAD+12)
#REPLACE DF_FETCH_FIELD_COUNT           (DF_FILE_RECORD_REREAD+13)
#REPLACE DF_FILE_TABLESPACE_NAME        (DF_FILE_RECORD_REREAD+14)
#REPLACE DF_FETCH_FIELDNUMBER           (DF_FILE_RECORD_REREAD+15)
#REPLACE DF_FILE_INDEXTABLESPACE_NAME   (DF_FILE_RECORD_REREAD+16)
#REPLACE DF_FILE_RETRIEVE_RECNUM        (DF_FILE_RECORD_REREAD+17)
#REPLACE DF_FILE_NAME_SPACE             (DF_FILE_RECORD_REREAD+18)

#REPLACE DF_FILE_STORAGE_PCTFREE (DF_FILE_RECORD_REREAD+19)
#REPLACE DF_FILE_STORAGE_PCTUSED (DF_FILE_RECORD_REREAD+21)
#REPLACE DF_FILE_STORAGE_INITIAL (DF_FILE_RECORD_REREAD+23)
#REPLACE DF_FILE_STORAGE_NEXT    (DF_FILE_RECORD_REREAD+25)
#REPLACE DF_FILE_ALLOW_NULL      (DF_FILE_RECORD_REREAD+27)

#REPLACE DF_FILE_GET_SERVERNAME_FROM_LOGIN      (DF_FILE_RECORD_REREAD+29)
#REPLACE DF_FILE_GET_DATABASENAME_FROM_LOGIN    (DF_FILE_RECORD_REREAD+31)
#REPLACE DF_FILE_GET_SCHEMANAME_FROM_LOGIN      (DF_FILE_RECORD_REREAD+33)

#REPLACE DF_FILE_PRESERVE_RECNUM                |CI184

#REPLACE DF_FILE_OEM_TRANSLATION                (DF_FILE_RECORD_REREAD+51)
#REPLACE DF_FILE_EPOCH_YEAR                     (DF_FILE_RECORD_REREAD+53)

#REPLACE DF_FILE_USE_ROWCOUNT_IN_TRANSACTIONS   |CI628

#REPLACE DF_FIELD_INVERSE_KEY_NAME    (DF_FIELD_NATIVE_LENGTH+1)
#REPLACE DF_FIELD_INVERSE_KEY_TYPE    (DF_FIELD_NATIVE_LENGTH+2)
#REPLACE DF_FIELD_TEXT_SEGMENT_NAME   (DF_FIELD_NATIVE_LENGTH+3)
#REPLACE DF_FIELD_TEXT_NUM_SEGMENTS   (DF_FIELD_NATIVE_LENGTH+4)
#REPLACE DF_FIELD_DEFAULT_VALUE       (DF_FIELD_NATIVE_LENGTH+5)
#REPLACE DF_FIELD_TEXT_LENGTH_SEGMENT (DF_FIELD_NATIVE_LENGTH+6)
#REPLACE DF_FIELD_TIME_ON             (DF_FIELD_NATIVE_LENGTH+8)
#REPLACE DF_FIELD_NATIVE_NAME         (DF_FIELD_NATIVE_LENGTH+9)
#REPLACE DF_FIELD_NULL                (DF_FIELD_NATIVE_LENGTH+10)
#REPLACE DF_FIELD_NATIVE_TYPE         (DF_FIELD_NATIVE_LENGTH+12)
#REPLACE DF_FIELD_NATIVE_OFFSET       (DF_FIELD_NATIVE_LENGTH+14)
#REPLACE DF_FIELD_AUTO_INCREMENT      (DF_FIELD_NATIVE_LENGTH+16)
#REPLACE DF_FIELD_GENERATE_ALWAYS     (DF_FIELD_NATIVE_LENGTH+18)

#REPLACE DF_FIELD_SEND_LONG_DATA       702

#REPLACE DF_INDEX_NATIVE_CREATED  (DF_INDEX_KEY_LENGTH+1)
#REPLACE DF_INDEX_NAME            (DF_INDEX_KEY_LENGTH+2)
#REPLACE DF_PRIMARY_KEY           (DF_INDEX_KEY_LENGTH+3)
#REPLACE DF_INDEX_PRIMARY_KEY     (DF_INDEX_KEY_LENGTH+3)
#REPLACE DF_INDEX_STATUS          (DF_INDEX_KEY_LENGTH+4)
#REPLACE DF_INDEX_STORAGE_PCTFREE (DF_INDEX_KEY_LENGTH+5)
#REPLACE DF_INDEX_UNIQUE          (DF_INDEX_KEY_LENGTH+6)
#REPLACE DF_INDEX_STORAGE_BASE    (DF_INDEX_KEY_LENGTH+7)
#REPLACE DF_INDEX_STORAGE_INITIAL (DF_INDEX_KEY_LENGTH+8)
#REPLACE DF_INDEX_STORAGE_NEXT    (DF_INDEX_KEY_LENGTH+10)
#REPLACE DF_INDEX_NATIVE_TYPE     (DF_INDEX_KEY_LENGTH+13)
#REPLACE DF_INDEX_TABLESPACE      (DF_INDEX_KEY_LENGTH+14)

#REPLACE DF_FETCH_ALL -1
#REPLACE DF_FETCH_TRUE "TRUE"
#REPLACE DF_FETCH_FALSE "FALSE"
#REPLACE DF_BIND_ALL_COLUMNS -1

// DataFlex Lock Types
//// File locking types
//#REPLACE DF_LOCK_TYPE_NONE     |CI0
//#REPLACE DF_LOCK_TYPE_FILE     |CI1
//#REPLACE DF_LOCK_TYPE_RECORD   |CI2
// SQLFlex Lock Type
#REPLACE DF_LOCK_TYPE_PAGE       |CI3

// Extended Callback Types
#REPLACE DF_MESSAGE_ERROR             |CI9
#REPLACE DF_MESSAGE_PROGRESS_STATUS   |CI20
#REPLACE DF_MESSAGE_PROGRESS_CONTINUE |CI21

#REPLACE ORAFLEX "ORA_DRV"
#REPLACE SQLFLEX "SQL_DRV"
#REPLACE MDSDB2 "MDS_DB2"
#REPLACE MDSPgSQL "MDSPGSQL"
#REPLACE Pgflex "MDSPGSQL"
#REPLACE MDSMySQL "MDSMYSQL"
#REPLACE MySQLFlex "MDSMYSQL"

// dfStructureEnd Option bits
#REPLACE DF_STRUCTEND_OPT_INDEX_ONLY    |CI16    // Internal Use Only
#REPLACE DF_STRUCTEND_OPT_FORCE_INVK    |CI32
#REPLACE DF_STRUCTEND_OPT_OLD_INVK_NAME |CI64

//
Enum_List  //  Call_Driver Functions
    DEfine CALLDRV_LICENSE_ENVIRONMENT_SET      FOR 0
    Define CALLDRV_ORA_CURRENT_SQL_SERVER       FOR 6
    Define CALLDRV_CURRENT_SQL_SERVER           FOR 19
    Define CALLDRV_SQL_MAX_CURSORS              FOR 26
    Define CALLDRV_SQLLOADER_FIELDS_TERM        FOR 30
    Define CALLDRV_SQLLOADER_DECIMAL_SEP        FOR 31
    Define CALLDRV_SQLFLEX_MAX_CURSORS          FOR 37

    Define CALLDRV_GET_RETURNED_COLUMNS         FOR 39
    Define CALLDRV_GET_RETURNED_ROWS            FOR 40
    Define CALLDRV_GET_COLUMN_ATTRIBUTE         FOR 41
    Define CALLDRV_START_TXTGEN_AFTER_RECNUM    FOR 42
    Define CALLDRV_FINISH_TXTGEN_AFTER_RECNUM   FOR 43
    Define CALLDRV_SET_ISOLATION_LEVEL          FOR 44
    Define CALLDRV_GET_SERVER_CFG               FOR 45
    Define CALLDRV_SET_SQL_LOCK_TIMEOUT         FOR 46
    Define CALLDRV_GET_SQL_LOCK_TIMEOUT         FOR 47
    Define CALLDRV_GET_RESULTS                  FOR 48
    Define CALLDRV_GET_MORE_RESULTS             FOR 49
    Define CALLDRV_GET_CURRENT_USER_NAME        FOR 50
    Define CALLDRV_OPEN_EMBEDDED_CURSOR         FOR 51
    Define CALLDRV_CLOSE_EMBEDDED_CURSOR        FOR 52
    Define CALLDRV_SET_CURRENT_EMBEDDED_CURSOR  FOR 53
    Define CALLDRV_GET_CURRENT_EMBEDDED_CURSOR  FOR 54
    Define CALLDRV_SET_MAX_EMBEDDED_CURSOR      FOR 55
    Define CALLDRV_GET_MAX_EMBEDDED_CURSOR      FOR 56
    Define CALLDRV_SQL_TRANSACTION              FOR 57
    Define CALLDRV_LOCAL_TD_PATH                FOR 58
    Define CALLDRV_CREATE_DB                    FOR 59
    Define CALLDRV_ESCAPE_STRING                FOR 60
    Define CALLDRV_SET_PROC_ATTRIBUTE_TYPE      FOR 61
    Define CALLDRV_SQL_REFRESH_CACHE            FOR 62
    Define CALLDRV_GET_SQL_STMT                 FOR 63
    Define CALLDRV_DIRECT_PATH_LOAD             FOR 64

    Define CALLDRV_READ_LOB                     FOR 65
    Define CALLDRV_WRITE_LOB                    FOR 66
    Define CALLDRV_APPEND_LOB                   FOR 67
    Define CALLDRV_LENGTH_LOB                   FOR 68
    Define CALLDRV_LOADFROMFILE_LOB             FOR 69
    Define CALLDRV_ERASE_LOB                    FOR 70
    Define CALLDRV_TRUNCATE_LOB                 FOR 71
    Define CALLDRV_INITIALIZE_SEQUENCE          FOR 72
    Define CALLDRV_CLIENT_CFG                   FOR 73
    Define CALLDRV_END_SAVERECORD               FOR 74
    Define CALLDRV_ENABLE_RECONNECT             FOR 75
    Define CALLDRV_ENUMERATE_SERVER             FOR 76
    Define CALLDRV_USE_ROWCOUNT_IN_TRANSACTIONS FOR 77
    Define CALLDRV_USE_DFLEX_DATE_FORMAT        FOR 78
    Define CALLDRV_FORCE_FIELDS_NOT_NULL        FOR 79
End_Enum_List

Enum_List  //  CALL_DRIVE_LIC_ENV_SET
    Define CALLDRV_DRIVER_REVISION              FOR 0
    Define CALLDRV_COMPANY_NAME                 FOR 1
    Define CALLDRV_SERIAL_NUMBER                FOR 2
    Define CALLDRV_LICENSED_USERS               FOR 3
    Define CALLDRV_MAJOR_REVISION               FOR 4
    Define CALLDRV_VERSION_COMMENTS             FOR 5
    Define CALLDRV_OEM_TRANSALTION              FOR 6
    Define CALLDRV_SET_DB_PORT                  FOR 7
    Define CALLDRV_GET_DB_PORT                  FOR 8
    Define CALLDRV_SET_DB_SOCKET                FOR 9
    Define CALLDRV_GET_DB_SOCKET                FOR 10
    Define CALLDRV_SET_AS_SYSDBA                FOR 11
End_Enum_List

Enum_List  // CALLDRV_ENUMERATE_SERVER_OPTION
    Define CALLDRV_ENUMERATE_SERVER_COUNT       FOR 0
    Define CALLDRV_ENUMERATE_SERVER_SERVER      FOR 1
End_Enum_List

Enum_List
    Define CALLDRV_VALUE_GET                    FOR 0
    Define CALLDRV_VALUE_SET                    FOR 1
End_Enum_List

// Inverse Key types
Enum_List
    Define REGULAR_SEG              FOR -1
    Define INVK_CASE_SEG            FOR 0
    Define INVK_DESC_SEG            FOR 1
    Define INVK_DESC_AND_CASE_SEG   FOR 2
End_Enum_List

// DB2 Index Types
Enum_List
    Define REG_INDEX        FOR 0
    Define REV_INDEX        FOR 1
    Define CLUST_INDEX      FOR 2
    Define REV_CLUST_INDEX  FOR 3
End_Enum_List

// Oracle Procedure Arguments type
Enum_List
    Define IS_NONE    FOR 0
    Define IS_IN      FOR 1
    Define IS_OUT     FOR 2
    Define IS_IN_OUT  FOR 3
    Define IS_RSET    FOR 4
End_Enum_List

#IFDEF _NPAR#
#ELSE
    INTEGER _NPAR#
#ENDIF
#IFDEF _DRIVERNAME#
#ELSE
    STRING _DRIVERNAME#
#ENDIF

//Last Revised: 2003-03-25 By: Marcelo
#COMMAND DO_DECLARE_BASIC_VARIABLES# .
    #IFDEF __#DO_DECLARE_BASIC_VARIABLES#
    #ELSE
        #REPLACE __#DO_DECLARE_BASIC_VARIABLES# "0"
        #IFDEF _RET#
        #ELSE
            INTEGER _RET#
        #ENDIF
        #IFDEF _BLANK#
        #ELSE
            STRING _BLANK#
        #ENDIF
        #IFDEF _ARG1#
        #ELSE
            // MARCELO 03/25/2003 Avoid crashing issue on Linux
        #IF (!b & 4)                     // do this if inside a procedure/function
                #IF (!Zg = 0)
                    !A [] $0456 |CI0
                    #FREF OBJ$!Za$LNUM !a       // and tell flex to update it later.
                #ENDIF
            #ENDIF
            #REPLACE _ARG1# |SS!ZG  // we want to create a local string
        #ENDIF

        #IFDEF _ARG2#
        #ELSE
            // MARCELO 03/25/2003 Avoid crashing issue on Linux
            #IF (!b & 4)                    // do this if inside a procedure/function
                #IF (!Zg = 0)
                    !A [] $0456 |CI0
                    #FREF OBJ$!Za$LNUM !a       // and tell flex to update it later.
                #ENDIF
            #ENDIF
            #REPLACE _ARG2# |SS!ZG  // we want to create a local string
        #ENDIF

        #IFDEF _DRIVERNAME#
        #ELSE
            STRING _DRIVERNAME#
        #ENDIF
        #IFDEF _NPAR#
        #ELSE
            INTEGER _NPAR#
        #ENDIF
        #IFDEF _LOCSTR#
        #ELSE
            #IF (!b & 4)                     // do this if inside a procedure/function
                #IF (!Zg = 0)
                    !A [] $0456 |CI0
                    #FREF OBJ$!Za$LNUM !a       // and tell flex to update it later.
                #ENDIF
            #ENDIF
            #REPLACE _LOCSTR# |SS!ZG  // we want to create a local string
        #ENDIF
        #IFDEF _FID#
        #ELSE
            INTEGER _FID#
        #ENDIF
        #IFDEF _LLONG#
        #ELSE
            INTEGER _LLONG#
        #ENDIF

        MOVE "" to _BLANK#
    #ENDIF
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND DO_GETFILENUMBER_DRIVERNAME# R .
    #IFDEF _COUNT#
    #ELSE
        INTEGER _COUNT#
    #ENDIF
    #IFDEF _IND#
    #ELSE
        INTEGER _IND#
    #ENDIF
    #IFDEF !1
        MOVE !1 TO FILENUMBER
    #ELSE
        #SET Q$ !1.RECNUM
        !A [] $82 |CI!q FILENUMBER
    #ENDIF

    IF FILENUMBER GT 0 ;
        GET_ATTRIBUTE DF_FILE_DRIVER OF FILENUMBER TO _DRIVERNAME#
    ELSE BEGIN
        GET_ATTRIBUTE DF_NUMBER_DRIVERS TO _COUNT#
        FOR _IND# FROM 1 TO _COUNT#
            GET_ATTRIBUTE DF_DRIVER_NAME OF _IND# TO _DRIVERNAME#
            MOVE (UPPERCASE(_DRIVERNAME#)) TO _DRIVERNAME#
            IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2 OR _DRIVERNAME# EQ MDSPgSQL OR _DRIVERNAME# EQ MDSMySQL) MOVE _COUNT# TO _IND#
            ELSE MOVE "" TO _DRIVERNAME#
        LOOP
    END
    IF (_DRIVERNAME# NE ORAFLEX AND _DRIVERNAME# NE SQLFLEX AND _DRIVERNAME# NE MDSDB2 AND _DRIVERNAME# NE MDSPgSQL AND _DRIVERNAME# NE MDSMySQL) MOVE ORAFLEX TO _DRIVERNAME# // ORAFlex is default driver
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND FETCH_FIELD
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# !1

    #IFDEF _FSTART#
    #ELSE
        INTEGER _FSTART# _FEND#
    #ENDIF
    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2 OR _DRIVERNAME# EQ MDSPgSQL OR _DRIVERNAME# EQ MDSMySQL) BEGIN
        #IFDEF _ARGS#
        #ELSE
            STRING _ARGS#
        #ENDIF
    	#IFSAME !3 TO
      		#IFTYPE !2 "I"
        		MOVE !2 TO _FSTART#
      		#ELSE
        		MOVE (LENGTH(|CS'!2')) TO _FSTART#
        		MOVE (_FSTART# - POS(",",|CS'!2')) TO _FSTART#
        		MOVE (RIGHT(|CS'!2',_FSTART#)) TO _FSTART#
      		#ENDIF
      		MOVE (UPPERCASE(!4)) TO _ARGS#
      		CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 7 CALLBACK 0 PASSING _ARGS# _BLANK# _FSTART# RESULT _RET#
      		IF _RET# EQ -1 INDICATE ERR TRUE
    	#ELSE
      		#IFSAME !3 THRU
        		#IFDEF _ARGI#
        		#ELSE
          			INTEGER _ARGI#
        		#ENDIF
        		#CHECK !2 RLGU#
        		#CHECK !4 RLGU#
        		MOVE (UPPERCASE(!6)) TO _ARGS#
        		IF (!2>!4) ERROR 77
        		ELSE ;
          			FOR _ARGI# FROM !2 TO !4
            			CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 7 CALLBACK 0 PASSING _ARGS# _BLANK# _ARGI# RESULT _RET#
            			IF _RET# EQ -1 INDICATE ERR TRUE
          			LOOP
      		#ENDIF
    	#ENDIF
    END // IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2 OR _DRIVERNAME# EQ MDSPgSQL)
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SELECT_COLUMNS_FIND
  	#IFCLASS !1 "V"
    	#IFDEF !2
    	#ELSE
      		CHECK !1 "F"
    	#ENDIF
  	#ENDIF
  	#IFSAME !3 THRU
    	#IFDEF !2
      		#IFDEF !4
        		FETCH_FIELD !1 !2 THRU !4 TO DF_FETCH_TRUE
      		#ELSE
        		FETCH_FIELD !1 !2 THRU !1.!4 TO DF_FETCH_TRUE
      		#ENDIF
    	#ELSE
      		#IFDEF !4
        		FETCH_FIELD !1 !1.!2 THRU !4 TO DF_FETCH_TRUE
      		#ELSE
        		FETCH_FIELD !1 !1.!2 THRU !1.!4 TO DF_FETCH_TRUE
      		#ENDIF
    	#ENDIF
  	#ELSE
    	#IFDEF !2
          //FETCH_FIELD !1 !2 TO DF_FETCH_TRUE
          #IFCLASS !2 "F"
              FETCH_FIELD !1 !2 TO DF_FETCH_TRUE
//          #ELSE
//              #CHECK !2 _CVG#L
          #ENDIF
    	#ELSE
      		FETCH_FIELD !1 !1.!2 TO DF_FETCH_TRUE
    	#ENDIF
    	#IF !0>2
      		SELECT_COLUMNS_FIND !1 !3 !4 !5 !6 !7 !8 !9
    	#ENDIF
  	#ENDIF
#ENDCOMMAND
#REPLACE SET_FETCH_FIELDS SELECT_COLUMNS_FIND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND RESET_FETCH_FIELDS R R .
  	FETCH_FIELD !1 DF_FETCH_ALL TO !2
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_FOR_ONEROW R .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# !1

    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2 OR _DRIVERNAME# EQ MDSPgSQL OR _DRIVERNAME# EQ MDSMySQL) BEGIN
    	CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 12 CALLBACK 0 PASSING _BLANK# _BLANK# 0 RESULT _RET#
    	IF _RET# EQ -1 INDICATE ERR TRUE
  	END
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_REFRESH_CACHE OF R .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# !2

    IF (_DRIVERNAME# EQ ORAFLEX) BEGIN
        CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 36 CALLBACK 0 PASSING _BLANK# _BLANK# 0 RESULT _RET#
        IF _RET# EQ -1 INDICATE ERR TRUE
    END
    ELSE BEGIN
        CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION CALLDRV_SQL_REFRESH_CACHE CALLBACK 0 PASSING _BLANK# _BLANK# 0 RESULT _RET#
        IF _RET# EQ -1 INDICATE ERR TRUE
  	END
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_FOR_SET R "MAXROWS" R "CACHE""NOCACHE"
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# !1
    #IFSAME !4 CACHE
        MOVE "CACHE" TO _ARG1#
    #ELSE
        MOVE "NOCACHE" TO _ARG1#
    #ENDIF
    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2 OR _DRIVERNAME# EQ MDSMySQL OR _DRIVERNAME# EQ MDSPgSQL) BEGIN
    	CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 13 CALLBACK 0 PASSING _ARG1# _BLANK# !3 RESULT _RET#
        IF _RET# EQ -1 INDICATE ERR TRUE
    END
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_SET R .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    MOVE !1 TO _ARG2#
    INDICATE ERR FALSE
    CALL_DRIVER 0 _DRIVERNAME# FUNCTION 1 CALLBACK 0 PASSING _BLANK# _ARG2# 0 RESULT _RET#
    IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_APPEND R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    MOVE !1 TO _ARG2#
    CALL_DRIVER 0 _DRIVERNAME# FUNCTION 2 CALLBACK 0 PASSING _BLANK# _ARG2# 0 RESULT _RET#
    IF _RET# EQ -1 INDICATE ERR TRUE
    #IF (!0>1)
        SQL_APPEND !2 !3 !4 !5 !6 !7 !8 !9
    #ENDIF
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_EXECUTE
    DO_DECLARE_BASIC_VARIABLES#
    #IF (!0>0)
        SQL_SET !1
        #IF (!0>1)
            SQL_APPEND !2 !3 !4 !5 !6 !7 !8 !9
        #ENDIF
    #ENDIF
    DO_GETFILENUMBER_DRIVERNAME# 0
    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2 OR _DRIVERNAME# EQ MDSPgSQL OR _DRIVERNAME# EQ MDSMySQL) BEGIN
        CALL_DRIVER 0 _DRIVERNAME# FUNCTION 3 CALLBACK 0 PASSING _BLANK# _BLANK# 0 RESULT _RET#
        IF _RET# EQ -1 INDICATE ERR TRUE
    END
#ENDCOMMAND

//Last Revised: 2004-11-09 By: Marcelo
#COMMAND LOCK_TABLE R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# !1

    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ MDSDB2) BEGIN
    	LOCK
    	CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 16 CALLBACK 0 PASSING _BLANK# _BLANK# 0 RESULT _RET#
    	IF _RET# EQ -1 INDICATE ERR TRUE
  	END
  	#IF !0>1
    	LOCK_TABLE !2 !3 !4 !5 !6 !7 !8 !9
  	#ENDIF
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_CHECK_TABLE R R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2 OR _DRIVERNAME# EQ MDSPgSQL OR _DRIVERNAME# EQ MDSMySQL) BEGIN
        MOVE !1 TO _ARG1#
        #IF (!0>2)
            APPEND _ARG1# "*" !2
            MOVE !3 TO _ARG2#
        #ELSE
            MOVE !2 TO _ARG2#
        #ENDIF
        CALL_DRIVER 0 _DRIVERNAME# FUNCTION 4 CALLBACK 0 PASSING _ARG1# _ARG2# 0 RESULT _RET#
        IF _RET# EQ 0 INDICATE FOUND FALSE
        ELSE INDICATE FOUND TRUE
    END
#ENDCOMMAND

//Last Revised: 2004-07-13 By: Marcelo
#COMMAND SET_SQL_CONSTRAINT "OF" R TO R .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# !2

    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2 OR _DRIVERNAME# EQ MDSPgSQL OR _DRIVERNAME# EQ MDSMySQL) BEGIN
        IF _DRIVERNAME# EQ SQLFLEX MOVE 36 TO _FID#
        ELSE MOVE 37 TO _FID#

        MOVE !4 TO _ARG1#
        IF (LENGTH(_ARG1#) <> 0) BEGIN
            CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION _FID# CALLBACK 0 PASSING _ARG1# _BLANK# 0 RESULT _RET#
            IF _RET# EQ -1 INDICATE ERR TRUE
        END
  	END
#ENDCOMMAND

//Last Revised: 2005-09-19 By: Marcelo
#COMMAND GET_SQL_CONSTRAINT "OF" R TO R .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# !2

    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2 OR _DRIVERNAME# EQ MDSPgSQL OR _DRIVERNAME# EQ MDSMySQL) BEGIN
        IF _DRIVERNAME# EQ SQLFLEX MOVE 36 TO _FID#
        ELSE MOVE 37 TO _FID#

        IF (LENGTH(_ARG1#) <> 0) BEGIN
            CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION _FID# CALLBACK 0 PASSING _ARG1# _BLANK# 3 RESULT _RET#
            IF _RET# EQ -1 INDICATE ERR TRUE
            ELSE MOVE _ARG1# TO !4
        END
  	END
#ENDCOMMAND

//Last Revised: 2004-07-13 By: Marcelo
#COMMAND SQL_CONSTRAINT "OF" R TO "ACTIVATE""DEACTIVATE" .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# !2

    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2 OR _DRIVERNAME# EQ MDSPgSQL OR _DRIVERNAME# EQ MDSMySQL) BEGIN
        IF _DRIVERNAME# EQ SQLFLEX MOVE 36 TO _FID#
        ELSE MOVE 37 TO _FID#

        #IFSAME !4 ACTIVATE
            CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION _FID# CALLBACK 0 PASSING _BLANK# _BLANK# 1 RESULT _RET#
        #ELSE
            CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION _FID# CALLBACK 0 PASSING _BLANK# _BLANK# 2 RESULT _RET#
        #ENDIF
    	IF _RET# EQ -1 INDICATE ERR TRUE
  	END
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND CREATE_TD_FILE R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    CALL_DRIVER 0 _DRIVERNAME# FUNCTION 5 CALLBACK 0 PASSING _BLANK# _BLANK# !1 RESULT _RET#
    IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND OPEN_INT
  	#IFDEF _DRIVERNAME#
  	#ELSE
    	STRING _DRIVERNAME#
  	#ENDIF

  	#IFSAME !2 AS // CHECK IF THERE IS A INTERMEDIATE FILE TO OPEN
    	#IFDEF _FILENAME#
    	#ELSE
       		STRING _FILENAME#
    	#ENDIF
    	MOVE (UPPERCASE(!1)) TO _FILENAME#
    	IF (POS(".INT",_FILENAME#) EQ 0) BEGIN
       		DIRECT_INPUT CHANNEL 9 (!1 + ".INT")
       		[ NOT SEQEOF ] BEGIN // OPEN THE INTERMEDIATE FILE
         		CLOSE_INPUT CHANNEL 9
                 DO_GETFILENUMBER_DRIVERNAME# 0
         		API_OPEN (_DRIVERNAME#+":"+!1) !2 !3 !4 !5 !6 !7 !8 !9
       		END
       		[ SEQEOF ] BEGIN // THERE ISN'T INTERMEDIATE FILE
         		INDICATE ERR FALSE
         		CLOSE_INPUT CHANNEL 9
         		API_OPEN !1 !2 !3 !4 !5 !6 !7 !8 !9
       		END
    	END
    	ELSE BEGIN
       		REPLACE ".INT" IN _FILENAME# WITH ""
            DO_GETFILENUMBER_DRIVERNAME# 0
       		API_OPEN (_DRIVERNAME#+":"+!1) !2 !3 !4 !5 !6 !7 !8 !9
    	END
  	#ELSE
    	#IFDEF _FILENAME#
    	#ELSE
       		STRING _FILENAME#
    	#ENDIF
     	#IFDEF _RET#
     	#ELSE
        	STRING _RET#
     	#ENDIF
     	DECLARE_DATAFILE !1
     	#IFDEF !1
         	MOVE !1 TO FILENUMBER
     	#ELSE
	    	#SET Q$ !1.RECNUM
        	!A [] $82 |CI!q FILENUMBER
     	#ENDIF
       	GET_ATTRIBUTE DF_FILE_ROOT_NAME of FILENUMBER to _FILENAME#
       	MOVE (UPPERCASE(_FILENAME#)) TO _FILENAME#
       	IF (POS(".INT",_FILENAME#) NE 0) BEGIN
        	REPLACE ".INT" IN _FILENAME# WITH ""
            DO_GETFILENUMBER_DRIVERNAME# 0
			API_OPEN (_DRIVERNAME#+":"+_FILENAME#) AS !1
       	END
       	ELSE API_OPEN !1 !2 !3 !4 !5 !6 !7 !8 !9
  	#ENDIF
#ENDCOMMAND

//==========================================
// SELECT STUFFS
//==========================================

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_SET_STMT "OF""TO"""
    DO_DECLARE_BASIC_VARIABLES#
  	#IFSAME !1 OF
        DO_GETFILENUMBER_DRIVERNAME# !2
    	#CHECK !3 "TO"
    	MOVE !4 TO _ARG2#
  	#ELSE
        DO_GETFILENUMBER_DRIVERNAME# 0
    	MOVE 0 TO FILENUMBER
    	#CHECK !1 "TO"
    	MOVE !2 TO _ARG2#
  	#ENDIF

    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2 OR _DRIVERNAME# EQ MDSPgSQL OR _DRIVERNAME# EQ MDSMySQL) BEGIN
      	CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 22 CALLBACK 0 PASSING _BLANK# _ARG2# 0 RESULT _RET#
      	IF _RET# EQ -1 INDICATE ERR TRUE
    	#IFSAME !1 OF
        	#IF (!0>4)
            	SQL_APPEND_STMT !1 !2 !3 !5 !6 !7 !8 !9
        	#ENDIF
    	#ELSE
       		#IF (!0>2)
            	SQL_APPEND_STMT !1 !3 !4 !5 !6 !7 !8 !9
       		#ENDIF
    	#ENDIF
  	END
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_APPEND_STMT "OF""TO"""
    DO_DECLARE_BASIC_VARIABLES#
  	#IFSAME !1 OF
        DO_GETFILENUMBER_DRIVERNAME# !2
    	#CHECK !3 "TO"
    	MOVE !4 TO _ARG2#
  	#ELSE
        DO_GETFILENUMBER_DRIVERNAME# 0
    	MOVE 0 TO FILENUMBER
    	#CHECK !1 "TO"
    	MOVE !2 TO _ARG2#
  	#ENDIF
    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2 OR _DRIVERNAME# EQ MDSPgSQL OR _DRIVERNAME# EQ MDSMySQL) BEGIN
  		CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 22 CALLBACK 0 PASSING _BLANK# _ARG2# 1 RESULT _RET#
    	IF _RET# EQ -1 INDICATE ERR TRUE
    	#IFSAME !1 OF
        	#IF (!0>4)
            	SQL_APPEND_STMT !1 !2 !3 !5 !6 !7 !8 !9
        	#ENDIF
    	#ELSE
       		#IF (!0>2)
            	SQL_APPEND_STMT !1 !3 !4 !5 !6 !7 !8 !9
       		#ENDIF
    	#ENDIF
  	END
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND APPEND_UPDATE_COLUMN R "FOR" R
	#IFDEF _IFIELD#
	#ELSE
		INTEGER _IFIELD#
        STRING _SFIELD#
	#ENDIF
	// GET FIELDNUMBER
    MOVE (LENGTH(|CS'!3')) TO _IFIELD#
    MOVE (_IFIELD# - POS(",",|CS'!3')) TO _IFIELD#
    MOVE (RIGHT(|CS'!3',_IFIELD#)) TO _IFIELD#
	// GET COLUMN NAME
	GET_ATTRIBUTE DF_FIELD_NAME OF FILENUMBER _IFIELD# TO _SFIELD#
	// WRITE , COLUMN NAME = VALUE
  	MOVE (","*_SFIELD#*"="*STRING(!1)) TO _ARG2#
  	CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 22 CALLBACK 0 PASSING _BLANK# _ARG2# 1 RESULT _RET#
    IF _RET# EQ -1 INDICATE ERR TRUE
	#IF (!0>3)
		APPEND_UPDATE_COLUMN !1 FOR !4 !5 !6 !7 !8 !9
	#ENDIF
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_APPEND_UPDCOL_STMT "OF" R "VALUE" R "FOR" R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# !2
   	#CHECK !3 "VALUE"
   	#CHECK !5 "FOR"
	APPEND_UPDATE_COLUMN !4 FOR !6 !7 !8 !9
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_PREPARE_STMT "OF"""
    DO_DECLARE_BASIC_VARIABLES#
  	#IFSAME !1 OF
        DO_GETFILENUMBER_DRIVERNAME# !2
  	#ELSE
    	#CHECK !1 .
        DO_GETFILENUMBER_DRIVERNAME# 0
    	MOVE 0 TO FILENUMBER
  	#ENDIF
    CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 22 CALLBACK 0 PASSING _BLANK# _BLANK# 2 RESULT _RET#
  	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_BIND_COLUMN R R .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# !1

  	#IFDEF _IBINDF#
  	#ELSE
    	INTEGER _IBINDF#
  	#ENDIF
  	#IFTYPE !2 "I"
    	MOVE !2 TO _IBINDF#
  	#ELSE
    	MOVE (LENGTH(|CS'!2')) TO _IBINDF#
    	MOVE (_IBINDF# - POS(",",|CS'!2')) TO _IBINDF#
    	MOVE (RIGHT(|CS'!2',_IBINDF#)) TO _IBINDF#
  	#ENDIF
  	MOVE _IBINDF# TO _ARG1#
  	CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 22 CALLBACK 0 PASSING _ARG1# _BLANK# 3 RESULT _RET#
  	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_BINDCOLUMNS_STMT "OF" !R "TO" !R
  	#IFDEF !4
    	SQL_BIND_COLUMN !2 !4
  	#ELSE
    	SQL_BIND_COLUMN !2 !2.!4
  	#ENDIF
  	#IF (!0>4)
    	SQL_BINDCOLUMNS_STMT !1 !2 !3 !5 !6 !7 !8 !9
  	#ENDIF
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_EXECUTE_STMT "OF"""
    DO_DECLARE_BASIC_VARIABLES#
  	#IFSAME !1 OF
        DO_GETFILENUMBER_DRIVERNAME# !2
  	#ELSE
        DO_GETFILENUMBER_DRIVERNAME# 0
    	MOVE 0 TO FILENUMBER
    	#IF (!0>0)
      		SQL_SET_STMT TO !1
      		#IF (!0>1)
        		SQL_APPEND_STMT TO !2 !3 !4 !5 !6 !7 !8 !9
      		#ENDIF
    	#ENDIF
  	#ENDIF
  	CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 22 CALLBACK 0 PASSING _BLANK# _BLANK# 5 RESULT _RET#
  	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_START_TRANSACTION_STMT .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    IF (_DRIVERNAME# EQ ORAFlex) BEGIN
      CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 22 CALLBACK 0 PASSING _BLANK# _BLANK# 9 RESULT _RET#
  		IF _RET# EQ -1 INDICATE ERR TRUE
    END
    ELSE IF (_DRIVERNAME# EQ SQLFlex OR _DRIVERNAME# EQ MDSPgSQL  OR _DRIVERNAME# EQ MDSMySQL) BEGIN
             CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION CALLDRV_SQL_TRANSACTION CALLBACK 0 PASSING _BLANK# _BLANK# 0 RESULT _RET#
             IF _RET# EQ -1 INDICATE ERR TRUE
         END
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_COMMIT_STMT .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    IF (_DRIVERNAME# EQ ORAFlex) BEGIN
  		CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 22 CALLBACK 0 PASSING _BLANK# _BLANK# 7 RESULT _RET#
  		IF _RET# EQ -1 INDICATE ERR TRUE
	END
    ELSE IF (_DRIVERNAME# EQ SQLFlex OR _DRIVERNAME# EQ MDSPgSQL OR _DRIVERNAME# EQ MDSMySQL) BEGIN
            CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION CALLDRV_SQL_TRANSACTION CALLBACK 0 PASSING _BLANK# _BLANK# 1 RESULT _RET#
            IF _RET# EQ -1 INDICATE ERR TRUE
         END
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_ROLLBACK_STMT .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    IF (_DRIVERNAME# EQ ORAFlex) BEGIN
	  	CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 22 CALLBACK 0 PASSING _BLANK# _BLANK# 8 RESULT _RET#
  		IF _RET# EQ -1 INDICATE ERR TRUE
    END
    ELSE IF (_DRIVERNAME# EQ SQLFlex OR _DRIVERNAME# EQ MDSPgSQL OR _DRIVERNAME# EQ MDSMySQL) BEGIN
            CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION CALLDRV_SQL_TRANSACTION CALLBACK 0 PASSING _BLANK# _BLANK# 2 RESULT _RET#
            IF _RET# EQ -1 INDICATE ERR TRUE
         END
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_FETCH_NEXT_ROW """OF""INTO"
    DO_DECLARE_BASIC_VARIABLES#
  	#IFSAME !1 OF
        DO_GETFILENUMBER_DRIVERNAME# !2
    	#CHECK !3 .
  	#ELSE
        DO_GETFILENUMBER_DRIVERNAME# 0
  	#ENDIF
  	CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 22 CALLBACK 0 PASSING _BLANK# _BLANK# 6 RESULT _RET#
  	IF _RET# NE 0 INDICATE FOUND FALSE
  	ELSE BEGIN
    	INDICATE FOUND TRUE
    	MOVE 0 TO _NPAR#
    	#IFSAME !1 INTO
            DDO_GET_BIND_PARAMETERS !2 !3 !4 !5 !6 !7 !8 !9
    	#ENDIF
  	END
#ENDCOMMAND

//Last Revised: 2003-03-27 By: Marcelo
#COMMAND SQL_GET_NUM_COLS "OF""TO"
    DO_DECLARE_BASIC_VARIABLES#
  	#IFSAME !1 OF
        DO_GETFILENUMBER_DRIVERNAME# !2
        #CHECK !5 .
  	#ELSE
        #IFSAME !1 TO
            DO_GETFILENUMBER_DRIVERNAME# 0
            #CHECK !3 .
        #ENDIF
  	#ENDIF
    CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION CALLDRV_GET_RETURNED_COLUMNS CALLBACK 0 PASSING _BLANK# _BLANK# 0 RESULT _RET#
    #IF !0=2
        MOVE _RET# TO !2
    #ELSE
        MOVE _RET# TO !4
    #ENDIF
#ENDCOMMAND
#REPLACE GET_SQL_NUM_COLS SQL_GET_NUM_COLS

//Last Revised: 2003-03-27 By: Marcelo
#COMMAND SQL_GET_NUM_ROWS "OF""TO"
    DO_DECLARE_BASIC_VARIABLES#
  	#IFSAME !1 OF
        DO_GETFILENUMBER_DRIVERNAME# !2
        #CHECK !5 .
  	#ELSE
        #IFSAME !1 TO
            DO_GETFILENUMBER_DRIVERNAME# 0
            #CHECK !3 .
        #ENDIF
  	#ENDIF
    CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION CALLDRV_GET_RETURNED_ROWS CALLBACK 0 PASSING _BLANK# _BLANK# 0 RESULT _RET#
    #IF !0=2
        MOVE _RET# TO !2
    #ELSE
        MOVE _RET# TO !4
    #ENDIF
#ENDCOMMAND
#REPLACE GET_SQL_NUM_ROWS SQL_GET_NUM_ROWS

//Last Revised: 2003-03-27 By: Marcelo
#COMMAND SQL_GET_COL_NAME
    DO_DECLARE_BASIC_VARIABLES#
  	#IFSAME !1 OF
        DO_GETFILENUMBER_DRIVERNAME# !2
        #CHECK !7 .
        MOVE !3 TO _LLONG#
  	#ELSE
        #IFSAME !2 TO
            DO_GETFILENUMBER_DRIVERNAME# 0
            #CHECK !5 .
            MOVE !1 TO _LLONG#
        #ENDIF
  	#ENDIF
    MOVE (REPEAT(" ", 60)) TO _ARG1#

    CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION CALLDRV_GET_COLUMN_ATTRIBUTE CALLBACK 0 PASSING _ARG1# _BLANK# _LLONG# RESULT _RET#
    IF _RET# EQ -1 INDICATE ERR TRUE
    ELSE BEGIN
        #IFSAME !1 OF
            MOVE _ARG1# TO !5
            #IF !0=6
                MOVE _RET# TO !6
            #ENDIF
        #ELSE
            MOVE _ARG1# TO !3
            #IF !0=4
                MOVE _RET# TO !4
            #ENDIF
        #ENDIF
    END
#ENDCOMMAND
#REPLACE GET_SQL_COL_NAME SQL_GET_COL_NAME

Define SQL_GET_COL_ATTRIB_SIZE           For 1
Define SQL_GET_COL_ATTRIB_DECIMALS       For 2
Define SQL_GET_COL_ATTRIB_LABEL          For 3
Define SQL_GET_COL_ATTRIB_COLUMN_NAME    For 4
Define SQL_GET_COL_ATTRIB_TABLE_NAME     For 5
Define SQL_GET_COL_ATTRIB_SQLTYPE        For 6
Define SQL_GET_COL_ATTRIB_NULLABLE       For 7
Define SQL_GET_COL_ATTRIB_DFTYPE         For 8

//Last Revised: 2005-09-22 By: Marcelo
#COMMAND SQL_GET_COL_ATTRIBUTE "OF" R "SIZE""DECIMALS""LABEL""COLUMN_NAME""TABLE_NAME""SQLTYPE""NULLABLE""DFTYPE" "TO" R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    #IFSAME !3 SIZE
        MOVE SQL_GET_COL_ATTRIB_SIZE TO _ARG2#
    #ELSE
        #IFSAME !3 DECIMALS
            MOVE SQL_GET_COL_ATTRIB_DECIMALS TO _ARG2#
        #ELSE
            #IFSAME !3 LABEL
                MOVE SQL_GET_COL_ATTRIB_LABEL TO _ARG2#
            #ELSE
                #IFSAME !3 COLUMN_NAME
                    MOVE SQL_GET_COL_ATTRIB_COLUMN_NAME TO _ARG2#
                #ELSE
                    #IFSAME !3 TABLE_NAME
                        MOVE SQL_GET_COL_ATTRIB_TABLE_NAME TO _ARG2#
                    #ELSE
                        #IFSAME !3 SQLTYPE
                            MOVE SQL_GET_COL_ATTRIB_SQLTYPE TO _ARG2#
                        #ELSE
                            #IFSAME !3 NULLABLE
                                MOVE SQL_GET_COL_ATTRIB_NULLABLE TO _ARG2#
                            #ELSE
                                MOVE SQL_GET_COL_ATTRIB_DFTYPE TO _ARG2#
                            #ENDIF
                        #ENDIF
                    #ENDIF
                #ENDIF
            #ENDIF
        #ENDIF
    #ENDIF

    MOVE !2 TO _LLONG#

    CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION CALLDRV_GET_COLUMN_ATTRIBUTE CALLBACK 0 PASSING _ARG1# _ARG2# _LLONG# RESULT _RET#
    IF _RET# EQ -1 INDICATE ERR TRUE
    ELSE MOVE _ARG1# TO !5
#ENDCOMMAND

//Last Revised: 2005-09-22 By: Marcelo
#COMMAND SQL_NEXT_RESULT_SET """OF"
    DO_DECLARE_BASIC_VARIABLES#
  	#IFSAME !1 OF
        DO_GETFILENUMBER_DRIVERNAME# !2
    	#CHECK !3 .
  	#ELSE
        DO_GETFILENUMBER_DRIVERNAME# 0
  	#ENDIF
    CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 22 CALLBACK 0 PASSING _BLANK# _BLANK# 8 RESULT _RET#
  	IF _RET# NE 0 INDICATE FOUND FALSE
    ELSE INDICATE FOUND TRUE
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND DDO_PASS_ARGUMENTS
    DO_PASS_ARGUMENTS !1
    #IF !0>1
        #IFSAME !1 BINDING
        #ELSE
            DDO_PASS_ARGUMENTS !2 !3 !4 !5 !6 !7 !8 !9
        #ENDIF
    #ENDIF
#ENDCOMMAND

//Last Revised: 2005-08-03 By: Marcelo
#COMMAND DO_PASS_ARGUMENTS
  	#IFDEF _NPAR#
  	#ELSE
        INTEGER _NPAR#
  	#ENDIF
    #IFSAME !1 BINDING
    // DON'T DO ANYTHING ELSE
    #ELSE
        #IFSAME !1 SQLOUT
        #ELSE
          #IFSAME !1 PASSING
              IF (_NPAR# = 0 AND _DRIVERNAME# = SQLFLEX OR _DRIVERNAME# = MDSDB2 OR _DRIVERNAME# = MYSQLFLEX) MOVE "(" TO _ARG1#
          #ELSE
              IF (_NPAR# > 0) SQL_APPEND_STMT TO ", "
              INCREMENT _NPAR#

              IF (_DRIVERNAME# EQ PGFLEX) MOVE !1 TO _ARG1#
              ELSE IF (_DRIVERNAME# = MYSQLFLEX ) MOVE ("@"+STRING(_NPAR#)) TO _ARG1#
                    ELSE IF _DRIVERNAME# EQ ORAFLEX MOVE (":PAR"+STRING(_NPAR#)) TO _ARG1#
                        ELSE MOVE "? " TO _ARG1#
          #ENDIF
              SQL_APPEND_STMT TO _ARG1#
        #ENDIF
        #IF (!0 > 1)
            DO_PASS_ARGUMENTS !2 !3 !4 !5 !6 !7 !8 !9
        #ENDIF
    #ENDIF
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND DDO_BIND_PARAMETERS
    DO_BIND_PARAMETERS !1
    #IF !0>1
        #IFSAME !1 BINDING
        // DON'T DO ANYTHING ELSE
        #ELSE
            DDO_BIND_PARAMETERS !2 !3 !4 !5 !6 !7 !8 !9
        #ENDIF
    #ENDIF
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND DO_BIND_PARAMETERS
    #IFDEF _NPAR#
    #ELSE
        INTEGER _NPAR#
    #ENDIF
    #IFDEF _SIZE#
    #ELSE
        INTEGER _SIZE#
    #ENDIF
    #IFDEF _IDECSEP#
    #ELSE
        INTEGER _IDECSEP#
    #ENDIF
    #IFDEF _DEFVAL#
    #ELSE
        #IF (!b & 4)                     // do this if inside a procedure/function
            #IF (!Zg = 0)
                !A [] $0456 |CI0
                #FREF OBJ$!Za$LNUM !a       // and tell flex to update it later.
            #ENDIF
        #ENDIF
        #REPLACE _DEFVAL# |SS!ZG  // we want to create a local string
    #ENDIF

    #IFSAME !1 BINDING
    // DON'T DO ANYTHING ELSE
    #ELSE
        #IFSAME !1 PASSING
        #ELSE
            #IFSAME !1 SQLOUT
            #ELSE
                #IFCLASS !1 _C
                    MOVE !1 TO _ARG1#
                    MOVE (LENGTH(_ARG1#)+1) TO _SIZE#
                    // MARCELO 12/14/2006
                    // We will change the default value here due a stored procedure call in ORAFlex
                    // MOVE " " TO _DEFVAL#
                    MOVE "" TO _DEFVAL#
                #ELSE
                    #IFTYPE !1 "I"
                        MOVE 20 TO _SIZE#
                        MOVE 0 TO _DEFVAL#
                    #ELSE
                        #IFTYPE !1 "N"
                            MOVE 50 TO _SIZE#
                            MOVE 0 TO _DEFVAL#
                        #ELSE
                            #IFTYPE !1 "D"
                                MOVE 20 TO _SIZE#
                                MOVE "" TO _DEFVAL#
                            #ELSE
                                #IFTYPE !1 "S"
                                    IF (POS("|VS",|CS'!1') NE 0 OR POS("|WS",|CS'!1') NE 0) MOVE 255 TO _SIZE#
                                    ELSE MOVE 16384 TO _SIZE#
                                    MOVE "" TO _DEFVAL#
                                #ENDIF
                            #ENDIF
                        #ENDIF
                    #ENDIF
                #ENDIF

                INCREMENT _NPAR#
                IF _DRIVERNAME# EQ ORAFLEX MOVE (":PAR"+STRING(_NPAR#)) TO _ARG2#
                ELSE IF _DRIVERNAME# EQ MYSQLFLEX MOVE ("@"+STRING(_NPAR#)) TO _ARG2#
                     ELSE MOVE " " TO _ARG2#

                // Default decimal separator should be dot (.)
                GET_ATTRIBUTE DF_DECIMAL_SEPARATOR TO _IDECSEP#
                SET_ATTRIBUTE DF_DECIMAL_SEPARATOR TO 46 // (.) WILL BE DECIMAL SEPARATOR
                MOVE !1 TO _ARG1#
                SET_ATTRIBUTE DF_DECIMAL_SEPARATOR TO _IDECSEP#

                IF (LENGTH(_ARG1#) = 0) MOVE _DEFVAL# TO _ARG1#

                //DO_GETFILENUMBER_DRIVERNAME# 0
                CALL_DRIVER 0 _DRIVERNAME# FUNCTION 23 CALLBACK 0 PASSING _ARG1# _ARG2# _SIZE# RESULT _RET#
            #ENDIF
        #ENDIF
        #IF (!0>1)
            DO_BIND_PARAMETERS !2 !3 !4 !5 !6 !7 !8 !9
        #ENDIF
    #ENDIF
#ENDCOMMAND

//Last Revised: 2005-05-16 By: Marcelo
#COMMAND DO_BIND_PAR_RET
    #IFDEF _NPAR#
    #ELSE
        INTEGER _NPAR#
    #ENDIF
    #IFDEF _SIZE#
    #ELSE
        INTEGER _SIZE#
    #ENDIF
    #IFDEF _IDECSEP#
    #ELSE
        INTEGER _IDECSEP#
    #ENDIF
    #IFDEF _DEFVAL#
    #ELSE
        #IF (!b & 4)                     // do this if inside a procedure/function
            #IF (!Zg = 0)
                !A [] $0456 |CI0
                #FREF OBJ$!Za$LNUM !a       // and tell flex to update it later.
            #ENDIF
        #ENDIF
        #REPLACE _DEFVAL# |SS!ZG  // we want to create a local string
    #ENDIF

    MOVE !1 TO _ARG1#

    #IFCLASS !1 _C
        MOVE (LENGTH(_ARG1#)+1) TO _SIZE#
        MOVE " " TO _DEFVAL#
    #ELSE
        MOVE !1 TO _ARG1#
        #IFTYPE !1 "I"
            MOVE 10 TO _SIZE#
            MOVE 0 TO _DEFVAL#
        #ELSE
            #IFTYPE !1 "N"
                MOVE 25 TO _SIZE#
                MOVE 0 TO _DEFVAL#
            #ELSE
                #IFTYPE !1 "D"
                    MOVE 11 TO _SIZE#
                    MOVE "" TO _DEFVAL#
                #ELSE
                    #IFTYPE !1 "S"
                        IF (POS("|VS",|CS'!1') NE 0 OR POS("|WS",|CS'!1') NE 0) MOVE 255 TO _SIZE#
                        ELSE MOVE 16384 TO _SIZE#
                        MOVE "" TO _DEFVAL#
                    #ENDIF
                #ENDIF
            #ENDIF
        #ENDIF
    #ENDIF

    MOVE (":PAR_RET") TO _ARG2#
    IF (LENGTH(_ARG1#) = 0) MOVE _DEFVAL# TO _ARG1#

    //DO_GETFILENUMBER_DRIVERNAME# 0
    CALL_DRIVER 0 _DRIVERNAME# FUNCTION 23 CALLBACK 0 PASSING _ARG1# _ARG2# _SIZE# RESULT _RET#
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND DDO_GET_BIND_PARAMETERS
    DO_GET_BIND_PARAMETERS !1
    #IF !0>1
        DDO_GET_BIND_PARAMETERS !2 !3 !4 !5 !6 !7 !8 !9
    #ENDIF
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND DO_GET_BIND_PARAMETERS
  	#IFDEF _NPAR#
  	#ELSE
    	INTEGER _NPAR#
  	#ENDIF
    #IFDEF _LLOC#
    #ELSE
        // MARCELO 03/25/2003 Avoid crashing issue on Linux
       #IF (!b & 4)                     // do this if inside a procedure/function
            #IF (!Zg = 0)
                !A [] $0456 |CI0
                #FREF OBJ$!Za$LNUM !a       // and tell flex to update it later.
            #ENDIF
        #ENDIF
        #REPLACE _LLOC# |SS!ZG  // we want to create a local string
    #ENDIF
    #IFDEF _IDECSEP#
    #ELSE
        INTEGER _IDECSEP#
    #ENDIF

    #IFSAME !1 BINDING
    // DON'T DO ANYTHING ELSE
    #ELSE
        #IFSAME !1 SQLOUT
        #ELSE
            #IFCLASS !1 _CE
                INCREMENT _NPAR#
            #ELSE
                DO_GETFILENUMBER_DRIVERNAME# 0

                INCREMENT _NPAR#

                #IFDEF FMAC_VERSION
                    If FMAC_VERSION eq 7 MOVE (REPEAT(" ", 1000)) TO _LLOC# // marcelo 06/28/2000 to avoid VDF 7 crashing problems
                    Else MOVE (REPEAT(" ", 16384)) TO _LLOC#
                #ELSE
                    MOVE (REPEAT(" ", 16384)) TO _LLOC#
                #ENDIF

                IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ MDSDB2 OR _DRIVERNAME# EQ MySQLFlex) BEGIN
                    CALL_DRIVER 0 _DRIVERNAME# FUNCTION 24 CALLBACK 0 PASSING _LLOC# _BLANK# _NPAR# RESULT _RET#
                END
                ELSE BEGIN
                    MOVE _NPAR# TO _ARG1#
                    CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 22 CALLBACK 0 PASSING _ARG1# _LLOC# 7 RESULT _RET#
                END
                GET_ATTRIBUTE DF_DECIMAL_SEPARATOR TO _IDECSEP#
                SET_ATTRIBUTE DF_DECIMAL_SEPARATOR TO 46 // (.) WILL BE DECIMAL SEPARATOR
                MOVE _LLOC# TO !1
                SET_ATTRIBUTE DF_DECIMAL_SEPARATOR TO _IDECSEP#
            #ENDIF
        #ENDIF
        #IF (!0>1)
            DO_GET_BIND_PARAMETERS !2 !3 !4 !5 !6 !7 !8 !9
        #ENDIF
    #ENDIF
#ENDCOMMAND

//Last Revised: 2003-08-27 By: Marcelo
// SQL_GET_OUTPUT_VALUE <POSITION> TO <VARIABLE>
#COMMAND SQL_GET_OUTPUT_VALUE R "TO" R
  #IFDEF _NPOS#
  #ELSE
      INTEGER _NPOS#
  #ENDIF
  SQL_GET_NUM_COLS TO _NPOS#
  IF (!1 <= _NPOS#) BEGIN
      #IFDEF _NPOS#
          MOVE _NPAR# TO _NPOS#       // Save _NPAR#
      #ENDIF
      MOVE (!1 -1) TO _NPAR#
      DO_GET_BIND_PARAMETERS !3
      #IFDEF _NPOS#
          MOVE _NPOS# TO _NPAR#
      #ENDIF
  END
  ELSE BEGIN
      ERROR 4099                  // Bad Parameter
  END
#ENDCOMMAND
#REPLACE MDS_GET_OUTPUT_VALUE SQL_GET_OUTPUT_VALUE

//Last Revised: 2003-03-27 By: Marcelo
#COMMAND SQL_FETCH_COLUMN R INTO R
  	#IFDEF _NPAR#
  	#ELSE
    	INTEGER _NPAR#
  	#ENDIF
    #IFDEF _LLOC#
    #ELSE
        // MARCELO 03/25/2003 Avoid crashing issue on Linux
       #IF (!b & 4)                     // do this if inside a procedure/function
            #IF (!Zg = 0)
                !A [] $0456 |CI0
                #FREF OBJ$!Za$LNUM !a       // and tell flex to update it later.
            #ENDIF
        #ENDIF
        #REPLACE _LLOC# |SS!ZG  // we want to create a local string
    #ENDIF
    #IFDEF _IDECSEP#
    #ELSE
        INTEGER _IDECSEP#
    #ENDIF

    DO_GETFILENUMBER_DRIVERNAME# 0

    MOVE !1 TO _NPAR#

    #IFDEF FMAC_VERSION
        If FMAC_VERSION eq 7 MOVE (REPEAT(" ", 1000)) TO _LLOC# // marcelo 06/28/2000 to avoid VDF 7 crashing problems
        Else MOVE (REPEAT(" ", 16384)) TO _LLOC#
    #ELSE
        MOVE (REPEAT(" ", 16384)) TO _LLOC#
    #ENDIF

    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ MDSDB2) BEGIN
        CALL_DRIVER 0 _DRIVERNAME# FUNCTION 24 CALLBACK 0 PASSING _LLOC# _BLANK# _NPAR# RESULT _RET#
    END
    ELSE BEGIN
        MOVE _NPAR# TO _ARG1#
        CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 22 CALLBACK 0 PASSING _ARG1# _LLOC# 7 RESULT _RET#
    END

    GET_ATTRIBUTE DF_DECIMAL_SEPARATOR TO _IDECSEP#
    SET_ATTRIBUTE DF_DECIMAL_SEPARATOR TO 46 // (.) WILL BE DECIMAL SEPARATOR
    MOVE _LLOC# TO !3
    SET_ATTRIBUTE DF_DECIMAL_SEPARATOR TO _IDECSEP#
#ENDCOMMAND

//Last Revised: 2005-08-03 By: Marcelo
#COMMAND CALL_ORACLE_STORED_PROCEDURE R "PASSING"""
  	#IFDEF _NPAR#
  	#ELSE
    	INTEGER _NPAR#
  	#ENDIF
  	MOVE 0 TO _NPAR#
  	INDICATE ERR FALSE
  	SQL_SET_STMT TO "BEGIN "
    SQL_APPEND_STMT TO !1 "( "
  	#IF (!0>2)
        DDO_PASS_ARGUMENTS !3 !4 !5 !6 !7 !8 !9
  	#ENDIF
    SQL_APPEND_STMT TO  " ); END;"
    SQL_PREPARE_STMT
  	#IF (!0>2)
    	[ NOT ERR ] BEGIN
      		IF _NPAR# GT 0 BEGIN
            	MOVE 0 TO _NPAR#
                DDO_BIND_PARAMETERS !3 !4 !5 !6 !7 !8 !9
      		END
    	END
  	#ENDIF
    SQL_EXECUTE_STMT
  	[ NOT ERR ] BEGIN
    	If ( _NPAR# GT 0 ) BEGIN
      		MOVE 0 TO _NPAR#
            DDO_GET_BIND_PARAMETERS !3 !4 !5 !6 !7 !8 !9
    	END
  	END
#ENDCOMMAND

//Last Revised: 2005-08-29 By: Marcelo
#COMMAND SQL_SET_PROCEDURE_NAME R "NUMPAR" R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    #IFDEF _NPOS#
  	#ELSE
        INTEGER _NPOS#
  	#ENDIF

  	MOVE 0 TO _NPAR#
  	INDICATE ERR FALSE

    if (_DRIVERNAME# = ORAFlex) ;
        send MertechInc_SQL_SET_ORAPROCEDURE_NAME !1 !3
    else if (_DRIVERNAME# = MYSQLFLEX) ;
        send MertechInc_SQL_SET_MYPROCEDURE_NAME !1 !3
#ENDCOMMAND
#REPLACE MDS_SET_PROCEDURE_NAME SQL_SET_PROCEDURE_NAME

//Last Revised: 2005-08-29 By: Marcelo
#COMMAND SQL_SET_FUNCTION_NAME R "NUMPAR" R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    #IFDEF _NPOS#
  	#ELSE
        INTEGER _NPOS#
  	#ENDIF

    MOVE 0 TO _NPAR#
  	INDICATE ERR FALSE

    if (_DRIVERNAME# = ORAFlex) ;
        send MertechInc_SQL_SET_ORAFUNCTION_NAME !1 !3
    else if (_DRIVERNAME# = MYSQLFLEX) ;
        send MertechInc_SQL_SET_MYFUNCTION_NAME !1 !3
#ENDCOMMAND

//Last Revised: 2005-09-07 By: Marcelo
#COMMAND SQL_SET_PROCEDURE_PARAMETER R "TO" R """IN""OUT""IN_OUT""RSET"
    #IFDEF _NPOS#

        #IFTYPE !3 "D"
            MOVE DF_DATE TO _ARG1#
        #ELSE
            MOVE " " TO _ARG1#
        #ENDIF

        IF (!1 <= _NPAR#) BEGIN
            MOVE _NPAR# TO _NPOS#       // Save _NPAR#
            MOVE (!1 -1) TO _NPAR#

            #IFDEF _LLONG#
            #ELSE
                INTEGER _LLONG#
            #ENDIF

            #IF (!0 = 4)
              #IFSAME !4 IN
                  MOVE IS_IN TO _LLONG#
              #ELSE
                  #IFSAME !4 OUT
                      MOVE IS_OUT TO _LLONG#
                  #ELSE
                      #IFSAME !4 OUT
                          MOVE IS_IN_OUT TO _LLONG#
                      #ELSE
                          MOVE IS_RSET TO _LLONG#
                      #ENDIF
                  #ENDIF
              #ENDIF
            #ELSE
                  MOVE IS_NONE TO _LLONG#
            #ENDIF

            CALL_DRIVER 0 _DRIVERNAME# FUNCTION CALLDRV_SET_PROC_ATTRIBUTE_TYPE CALLBACK 0 PASSING _ARG1# _BLANK# _LLONG# RESULT _RET#

            DO_BIND_PARAMETERS !3
            MOVE _NPOS# TO _NPAR#
        END
        ELSE BEGIN
            ERROR 4099                  // Bad Parameter
        END
  	#ELSE
        #REM SQL_SET_PROCEDURE_NAME MUST BE EXECUTED FIRST
  	#ENDIF
#ENDCOMMAND
#REPLACE MDS_SET_PROCEDURE_PARAMETER SQL_SET_PROCEDURE_PARAMETER

#COMMAND SQL_SET_FUNCTION_PARAMETER R "TO" R """IN""OUT""IN_OUT"
  #IF !0=4
    SQL_SET_PROCEDURE_PARAMETER !1 TO !3 !4
  #ELSE
    SQL_SET_PROCEDURE_PARAMETER !1 TO !3 IN
  #ENDIF
#ENDCOMMAND

//Last Revised: 2005-08-29 By: Marcelo
#COMMAND SQL_PROCEDURE_EXECUTE
    send MertechInc_SQL_PROCEDURE_EXECUTE
#ENDCOMMAND
#REPLACE MDS_PROCEDURE_EXECUTE SQL_PROCEDURE_EXECUTE

//Last Revised: 2005-08-29 By: Marcelo
#COMMAND SQL_FUNCTION_EXECUTE
    send MertechInc_SQL_FUNCTION_EXECUTE _DRIVERNAME#
#ENDCOMMAND

//Last Revised: 2003-08-27 By: Marcelo
#COMMAND SQL_GET_PROCEDURE_PARAMETER R "TO" R
    #IFDEF _NPOS#
        IF (!1 <= _NPAR#) BEGIN
            MOVE _NPAR# TO _NPOS#       // Save _NPAR#
            MOVE (!1 -1) TO _NPAR#
            DO_GET_BIND_PARAMETERS !3
            MOVE _NPOS# TO _NPAR#
        END
        ELSE BEGIN
            ERROR 4099                  // Bad Parameter
        END
  	#ELSE
        #REM SQL_SET_PROCEDURE_NAME MUST BE EXECUTED FIRST
  	#ENDIF
#ENDCOMMAND
#REPLACE MDS_GET_PROCEDURE_PARAMETER SQL_GET_PROCEDURE_PARAMETER

#COMMAND SQL_GET_FUNCTION_RETURN "TO" R
    #IFDEF _NPOS#
        MOVE _NPAR# TO _NPOS#       // Save _NPAR#
        MOVE 0 TO _NPAR#
        DO_GET_BIND_PARAMETERS !2
        MOVE _NPOS# TO _NPAR#
  	#ELSE
        #REM SQL_SET_FUNCTION_NAME MUST BE EXECUTED FIRST
  	#ENDIF
#ENDCOMMAND

#COMMAND SQL_GET_FUNCTION_PARAMETER R "TO" R
    SQL_GET_PROCEDURE_PARAMETER (!1 + 1) TO !3
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND REEXEC_ORACLE_STORED_PROCEDURE R "PASSING"""
  	#IFDEF _NPAR#
  	#ELSE
    	INTEGER _NPAR#
  	#ENDIF
  	MOVE 0 TO _NPAR#
    SQL_SET_STMT TO " "
    INDICATE ERR FALSE
  	#IF (!0>2)
        DO_PASS_ARGUMENTS !3 !4 !5 !6 !7 !8 !9
    	[ NOT ERR ] BEGIN
      		IF _NPAR# GT 0 BEGIN
            	MOVE 0 TO _NPAR#
                DO_BIND_PARAMETERS !3 !4 !5 !6 !7 !8 !9
      		END
    	END
  	#ENDIF
    SQL_EXECUTE_STMT
  	[ NOT ERR ] BEGIN
    	If ( _NPAR# GT 0 ) BEGIN
      		MOVE 0 TO _NPAR#
            DO_GET_BIND_PARAMETERS !3 !4 !5 !6 !7 !8 !9
    	END
  	END
#ENDCOMMAND

//Last Revised: 2005-09-15 By: Marcelo
#COMMAND CALL_STORED_PROCEDURE R "PASSING""BINDING"""
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    IF (_DRIVERNAME# EQ MySQLFlex) CALL_MYSQL_STORED_PROCEDURE !1 !2 !3 !4 !5 !6 !7 !8 !9
    ELSE IF (_DRIVERNAME# EQ SQLFlex) CALL_SQLSERVER_PROCEDURE !1 !2 !3 !4 !5 !6 !7 !8 !9
    ELSE CALL_ORACLE_STORED_PROCEDURE !1 !2 !3 !4 !5 !6 !7 !8 !9

#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND REEXEC_STORED_PROCEDURE R "PASSING""BINDING"""
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    REEXEC_ORACLE_STORED_PROCEDURE !1 !2 !3 !4 !5 !6 !7 !8 !9
#ENDCOMMAND

//Last Revised: 2004-07-19 By: Marcelo
#COMMAND CALL_STORED_FUNCTION R "RETURNS" R "PASSING"""
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    IF (_DRIVERNAME# EQ MDSPGSQL) CALL_PGSQL_STORED_FUNCTION !1 !2 !3 !4 !5 !6 !7 !8 !9
    ELSE IF (_DRIVERNAME# EQ MySQLFlex) CALL_MYSQL_STORED_FUNCTION !1 !2 !3 !4 !5 !6 !7 !8 !9
         ELSE CALL_ORACLE_STORED_FUNCTION !1 !2 !3 !4 !5 !6 !7 !8 !9
    #ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_TEXT_MESSAGE R .
    DO_DECLARE_BASIC_VARIABLES#

  	MOVE !1 TO _ARG1#
    DO_GETFILENUMBER_DRIVERNAME# 0
  	CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 17 CALLBACK 0 PASSING _ARG1# _BLANK# 0 RESULT _RET#
  	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2006-12-27 By: Marcelo
#COMMAND OUTPUT_INT_FILE "FOR" R "TO" R .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# !2

    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSMySQL OR _DRIVERNAME# EQ MDSPgSQL) BEGIN
    	MOVE !4 TO _ARG1#
        IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ MDSDB2 OR _DRIVERNAME# EQ MDSPgSQL) ;
            CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 19 CALLBACK 0 PASSING _ARG1# _BLANK# 0 RESULT _RET#
        ELSE ;
            CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 16 CALLBACK 0 PASSING _ARG1# _BLANK# 0 RESULT _RET#
    	IF _RET# EQ -1 INDICATE ERR TRUE
  	END
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_ERROR_MESSAGE R .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    MOVE (REPEAT(" ",800)) to _LOCSTR#
    CALL_DRIVER 0 _DRIVERNAME#  FUNCTION 14 CALLBACK 0 PASSING _BLANK# _LOCSTR# 0 RESULT _RET#
    IF _RET# EQ -1 INDICATE ERR TRUE
    MOVE _LOCSTR# TO !1
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND MERTECH_WARNING_MESSAGE "ENABLED""DISABLED" .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    #IFSAME !1 DISABLED
        CALL_DRIVER 0 _DRIVERNAME#  FUNCTION 34 CALLBACK 0 PASSING _BLANK# _BLANK# 1 RESULT _RET#
    #ELSE
        CALL_DRIVER 0 _DRIVERNAME#  FUNCTION 34 CALLBACK 0 PASSING _BLANK# _BLANK# 0 RESULT _RET#
    #ENDIF
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND DISABLE_SELECT_COLUMNS_ERRORS "ENABLED""DISABLED" .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    #IFSAME !1 DISABLED
        CALL_DRIVER 0 _DRIVERNAME#  FUNCTION 35 CALLBACK 0 PASSING _BLANK# _BLANK# 1 RESULT _RET#
    #ELSE
        CALL_DRIVER 0 _DRIVERNAME#  FUNCTION 35 CALLBACK 0 PASSING _BLANK# _BLANK# 0 RESULT _RET#
    #ENDIF
#ENDCOMMAND

//==================================
// SQLFlex Commands
//==================================

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQLFlex_REVISION #CRUG .
    DO_DECLARE_BASIC_VARIABLES#
    INDICATE ERR FALSE
    MOVE (REPEAT(" ",255)) to !1
    CALL_DRIVER 0 SQLFlex FUNCTION 0 CALLBACK 0 PASSING _BLANK# !1 0 RESULT _RET#
	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQLFlex_MAJOR_REVISION #CRUG .
    DO_DECLARE_BASIC_VARIABLES#
    INDICATE ERR FALSE
    MOVE (REPEAT(" ",255)) to !1
    CALL_DRIVER 0 SQLFlex FUNCTION 0 CALLBACK 0 PASSING _BLANK# !1 4 RESULT _RET#
	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND LOGGED_USERS #CRUG .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 33 CALLBACK 0 PASSING _BLANK# _BLANK# 0 RESULT _RET#
    MOVE _RET# TO !1
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND MAXIMUM_NUMBER_OF_USERS #CRUG .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    INDICATE ERR FALSE
    MOVE (REPEAT(" ",255)) to !1
    CALL_DRIVER 0 _DRIVERNAME# FUNCTION 0 CALLBACK 0 PASSING _BLANK# !1 3 RESULT _RET#
	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SET_DATABASE_NAME "TO" R .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    INDICATE ERR FALSE
    MOVE !2 TO _ARG1#
    IF (_DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSMySQL OR _DRIVERNAME# EQ MDSPgSQL) BEGIN
        CALL_DRIVER 0 _DRIVERNAME# FUNCTION 9 CALLBACK 0 PASSING _ARG1# _BLANK# 0 RESULT _RET#
        IF _RET# EQ -1 INDICATE ERR TRUE
    END
#ENDCOMMAND

//Last Revised: 2005-02-18 By: Marcelo
#COMMAND GET_DATABASE_NAME "TO" #CRUG .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    INDICATE ERR FALSE
    MOVE (REPEAT(" ",255)) to _ARG1#
    IF (_DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSMySQL OR _DRIVERNAME# EQ MDSPgSQL) BEGIN
       CALL_DRIVER 0 _DRIVERNAME# FUNCTION 9 CALLBACK 0 PASSING _ARG1# _BLANK# 1 RESULT _RET#
       IF _RET# EQ -1 INDICATE ERR TRUE
       [  ERR ] MOVE ""     TO !2
       [ ~ERR ] MOVE _ARG1# TO !2
    END
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SET_SCHEMA_NAME "TO" R .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    INDICATE ERR FALSE
    MOVE !2 TO _ARG1#
  	IF _DRIVERNAME# EQ SQLFLEX ;
        CALL_DRIVER 0 SQLFlex FUNCTION 10 CALLBACK 0 PASSING _ARG1# _BLANK# 0 RESULT _RET#
    ELSE ;
        CALL_DRIVER 0 ORAFlex FUNCTION 8 CALLBACK 0 PASSING _ARG1# _BLANK# 0 RESULT _RET#
	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND GET_SCHEMA_NAME "TO" #CRUG .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    INDICATE ERR FALSE
    MOVE (REPEAT(" ",255)) to _ARG1#
  	IF _DRIVERNAME# EQ SQLFLEX ;
        CALL_DRIVER 0 SQLFlex FUNCTION 10 CALLBACK 0 PASSING _ARG1# _BLANK# 1 RESULT _RET#
    ELSE ;
        CALL_DRIVER 0 ORAFlex FUNCTION 8 CALLBACK 0 PASSING _ARG1# _BLANK# 1 RESULT _RET#
	IF _RET# EQ -1 INDICATE ERR TRUE
    [  ERR ] MOVE ""     TO !2
    [ ~ERR ] MOVE _ARG1# TO !2
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_USE_DATABASE R .
  DO_DECLARE_BASIC_VARIABLES#
  DO_GETFILENUMBER_DRIVERNAME# 0
  MOVE !1 TO _ARG1#
  IF (_DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSMySQL OR _DRIVERNAME# EQ MDSPgSQL) Begin
    CALL_DRIVER 0 _DRIVERNAME# FUNCTION 18 CALLBACK 0 PASSING _ARG1# _BLANK# 0 RESULT _RET#
    IF _RET# EQ -1 INDICATE ERR TRUE
  END
#ENDCOMMAND

//Last Revised: 2004-05-10 By: Marcelo
#COMMAND SET_CURRENT_SQL_SERVER "TO" R .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    INDICATE ERR FALSE
    MOVE !2 TO _ARG1#
    IF _DRIVERNAME# EQ ORAFLEX ;
        CALL_DRIVER 0 ORAFlex FUNCTION CALLDRV_ORA_CURRENT_SQL_SERVER CALLBACK 0 PASSING _ARG1# _BLANK# 0 RESULT _RET#
    ELSE ;
        CALL_DRIVER 0 _DRIVERNAME# FUNCTION CALLDRV_CURRENT_SQL_SERVER CALLBACK 0 PASSING _ARG1# _BLANK# 0 RESULT _RET#
	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND
#IFDEF SET_CURRENT_SERVER
#ELSE
    #REPLACE SET_CURRENT_SERVER SET_CURRENT_SQL_SERVER
#ENDIF

//Last Revised: 2004-05-10 By: Marcelo
#COMMAND GET_CURRENT_SQL_SERVER "TO" #CRUG .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    MOVE (REPEAT(" ",255)) to _ARG1#
    IF _DRIVERNAME# EQ ORAFlex ;
        CALL_DRIVER 0 ORAFlex FUNCTION CALLDRV_ORA_CURRENT_SQL_SERVER CALLBACK 0 PASSING _ARG1# _BLANK# 1 RESULT _RET#
    ELSE ;
        CALL_DRIVER 0 _DRIVERNAME# FUNCTION CALLDRV_CURRENT_SQL_SERVER CALLBACK 0 PASSING _ARG1# _BLANK# 1 RESULT _RET#
	IF _RET# EQ -1 INDICATE ERR TRUE
    [  ERR ] MOVE ""     TO !2
    [ ~ERR ] MOVE _ARG1# TO !2
#ENDCOMMAND
#IFDEF GET_CURRENT_SERVER
#ELSE
    #REPLACE GET_CURRENT_SERVER GET_CURRENT_SQL_SERVER
#ENDIF

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND LOGIN_SQLFLEX #ULGR$ #ULGR$ #ULGR$ #ULG$ .
  LOGIN (!1+"*"+!4) !2 !3 "SQL_DRV"
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_CANCEL_QUERY_STMT """OF"
    DO_DECLARE_BASIC_VARIABLES#
    #IF (!0>1)
        DO_GETFILENUMBER_DRIVERNAME# !2
    #ELSE
        DO_GETFILENUMBER_DRIVERNAME# 0
    #ENDIF

    MOVE 0 to _RET#

    IF (_DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSMySQL);
        CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 22 CALLBACK 0 PASSING _BLANK# _BLANK# 4 RESULT _RET#
  	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND NATIVE_OPTIMIZATION "OF" "SERVER""TABLE" R "TO" "DEFAULT""NO_INDEXHINT"
    DO_DECLARE_BASIC_VARIABLES#
    #IFSAME !2 TABLE
        DO_GETFILENUMBER_DRIVERNAME# !3
        MOVE "" TO _ARG1#
    #ELSE
        DO_GETFILENUMBER_DRIVERNAME# 0
        MOVE !3 TO _ARG1#
        MOVE 0 TO FILENUMBER
    #ENDIF

    #IFSAME !5 DEFAULT
        MOVE 0 TO _LLONG#
    #ELSE
        MOVE 1 TO _LLONG#
    #ENDIF

    IF (_DRIVERNAME# EQ SQLFLEX or _DRIVERNAME# EQ ORAFLEX) ;
        CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 38 CALLBACK 0 PASSING _ARG1# _BLANK# _LLONG# RESULT _RET#
  	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2005-08-22 By: Marcelo
#COMMAND SET_ISOLATION_LEVEL "OF" R "TO" "DEFAULT""READ_COMMITTED""READ_UNCOMMITTED""REPEATABLE_READ""SERIALIZABLE"
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    MOVE !2 TO _ARG1#
    MOVE 0 TO FILENUMBER

    MOVE 0 TO _LLONG#
    #IFSAME !4 READ_COMMITTED
        MOVE 0 TO _LLONG#
    #ELSE
        #IFSAME !4 READ_UNCOMMITTED
            MOVE 1 TO _LLONG#
        #ELSE
            #IFSAME !4 REPEATABLE_READ
                MOVE 2 TO _LLONG#
            #ELSE
                #IFSAME !4 SERIALIZABLE
                    MOVE 3 TO _LLONG#
                #ENDIF
            #ENDIF
        #ENDIF
    #ENDIF

    IF (_DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MYSQLFLEX) ;
        CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION CALLDRV_SET_ISOLATION_LEVEL CALLBACK 0 PASSING _ARG1# _BLANK# _LLONG# RESULT _RET#
  	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2003-05-27 By: Marcelo
#COMMAND SET_SESSION_PARAMETER "OEM_TO_ANSI" "TO" R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    MOVE !3 TO _ARG1#
    MOVE 0 TO FILENUMBER

    #IFSAME !1 OEM_TO_ANSI
        MOVE 6 TO _LLONG#
    #ENDIF

    CALL_DRIVER 0 _DRIVERNAME# FUNCTION 0 CALLBACK 0 PASSING _ARG1# _BLANK# _LLONG# RESULT _RET#
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SET_SQL_LOCK_TIMEOUT "OF" R "TO" R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    MOVE !2 TO _ARG1#
    MOVE 0 TO FILENUMBER

    MOVE !4 TO _LLONG#

  	IF _DRIVERNAME# EQ SQLFLEX ;
        CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION CALLDRV_SET_SQL_LOCK_TIMEOUT CALLBACK 0 PASSING _ARG1# _BLANK# _LLONG# RESULT _RET#
  	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND GET_SQL_LOCK_TIMEOUT "OF" R "TO" R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    MOVE !2 TO _ARG1#
    MOVE "-1" TO _ARG2#
    MOVE 0 TO FILENUMBER

  	IF _DRIVERNAME# EQ SQLFLEX ;
        CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION CALLDRV_GET_SQL_LOCK_TIMEOUT CALLBACK 0 PASSING _ARG1# _ARG2# _LLONG# RESULT _RET#
    IF _RET# EQ -1 INDICATE ERR TRUE
    MOVE _ARG2# TO !4
#ENDCOMMAND

//==========================================
// SQL SERVER Stored Procedure Call engine
//==========================================

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND DO_GET_SQLSERVER_PARAMETERS
  	#IFDEF _NPAR#
  	#ELSE
    	INTEGER _NPAR#
  	#ENDIF
    #IFDEF _LOCSTR#
    #ELSE
        #IF (!b & 4)                     // do this if inside a procedure/function
            #IF (!Zg = 0)
                !A [] $0456 |CI0
                #FREF OBJ$!Za$LNUM !a       // and tell flex to update it later.
            #ENDIF
        #ENDIF
        #REPLACE _LOCSTR# |SS!ZG  // we want to create a local string
    #ENDIF

   	MOVE _NPAR# TO _ARG1#

  	#IF (!0>1)
        INCREMENT _NPAR#
        #IFSAME !2 SQLOUT
            IF (POS("|V",|CS'!1') NE 0 OR POS("|S",|CS'!1') NE 0 OR POS("|F",|CS'!1') NE 0) BEGIN
                #IFDEF FMAC_VERSION
                    If FMAC_VERSION eq 7 MOVE (REPEAT(" ", 1000)) TO _LOCSTR# // marcelo 06/28/2000 to avoid VDF 7 crashing problems
                    Else MOVE (REPEAT(" ", 16384)) TO _LOCSTR#
                #ELSE
                    MOVE (REPEAT(" ", 16384)) TO _LOCSTR#
                #ENDIF

                CALL_DRIVER FILENUMBER SQLFLEX FUNCTION 24 CALLBACK 0 PASSING _LOCSTR# _BLANK# _NPAR# RESULT _RET#
                Move _LOCSTR# TO !1
            END
            #IF (!0>2)
                DO_GET_SQLSERVER_PARAMETERS !3 !4 !5 !6 !7 !8 !9
            #ENDIF
        #ELSE
            DO_GET_SQLSERVER_PARAMETERS !2 !3 !4 !5 !6 !7 !8 !9
        #ENDIF
    #ENDIF
#ENDCOMMAND // DO_GET_SQLSERVER_PARAMETERS

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND DO_BIND_SQLSERVER_PARAMETERS
    #IFDEF _NPAR#
    #ELSE
        INTEGER _NPAR#
    #ENDIF
    #IFDEF _SIZE#
    #ELSE
        INTEGER _SIZE#
    #ENDIF
    #IFDEF _LOCSTR#
    #ELSE
        #IF (!b & 4)                     // do this if inside a procedure/function
            #IF (!Zg = 0)
                !A [] $0456 |CI0
                #FREF OBJ$!Za$LNUM !a       // and tell flex to update it later.
            #ENDIF
        #ENDIF
        #REPLACE _LOCSTR# |SS!ZG  // we want to create a local string
    #ENDIF
    #IFDEF _PARTYPE#
    #ELSE
      STRING _PARTYPE#
    #ENDIF

    #IFSAME !1 BINDING
    #ELSE
        #IFSAME !2 SQLOUT
            Move "OUTPUT" TO _PARTYPE#
        #ELSE
            Move "INPUT" TO _PARTYPE#
        #ENDIF

        IF (POS("|V",|CS'!1') NE 0 OR POS("|S",|CS'!1') NE 0 OR POS("|F",|CS'!1') NE 0) BEGIN
            IF (POS("|VI",|CS'!1') NE 0 OR POS("|SI",|CS'!1') NE 0) MOVE 6 TO _SIZE#
            ELSE IF (POS("|VN",|CS'!1') NE 0 OR POS("|SN",|CS'!1') NE 0 OR POS("|FN",|CS'!1') NE 0) MOVE 25 TO _SIZE#
                ELSE IF (POS("|VD",|CS'!1') NE 0 OR POS("|SD",|CS'!1') NE 0 OR POS("|FD",|CS'!1') NE 0) MOVE 10 TO _SIZE#
                    ELSE IF (POS("|VS",|CS'!1') NE 0) MOVE 255 TO _SIZE#
                        ELSE IF (POS("|SS",|CS'!1') NE 0 OR POS("|FS",|CS'!1') NE 0) MOVE 16384 TO _SIZE#
            INCREMENT _NPAR#
            Move !1 TO _LOCSTR#
            CALL_DRIVER 0 SQLFLEX FUNCTION 23 CALLBACK 0 PASSING _PARTYPE# _LOCSTR# _SIZE# RESULT _RET#
        END
        ELSE BEGIN
            Move !1 TO _LOCSTR#
            Move (LENGTH(!1)) TO _SIZE#
            CALL_DRIVER 0 SQLFLEX FUNCTION 23 CALLBACK 0 PASSING _PARTYPE# _LOCSTR# _SIZE# RESULT _RET#
        END

        #IF (!0>1)
            #IFSAME !2 SQLOUT
                #IF (!0>2)
                    DO_BIND_SQLSERVER_PARAMETERS !3 !4 !5 !6 !7 !8 !9
                #ENDIF
            #ELSE
                DO_BIND_SQLSERVER_PARAMETERS !2 !3 !4 !5 !6 !7 !8 !9
            #ENDIF
        #ENDIF
    #ENDIF
#ENDCOMMAND // DO_BIND_SQLSERVER_PARAMETERS

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND DO_CHECK_BINDING
    #IFDEF _THEREISBINDING#
    #ELSE
        INDICATOR _THEREISBINDING#
    #ENDIF

    #IFSAME !1 BINDING
        INDICATE _THEREISBINDING# TRUE
    #ELSE
        #IF (!0>1)
            DO_CHECK_BINDING !2 !3 !4 !5 !6 !7 !8 !9
        #ENDIF
    #ENDIF
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND DO_FETCH_FIRST_ROW
    #IFSAME !1 BINDING
        SQL_FETCH_NEXT_ROW INTO !2 !3 !4 !5 !6 !7 !8 !9
    #ELSE
        #IF (!0>1)
            DO_FETCH_FIRST_ROW !2 !3 !4 !5 !6 !7 !8 !9
        #ENDIF
    #ENDIF
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND CALL_SQLFLEX7_PROCEDURE R "PASSING""BINDING"""
  	#IFDEF _NPAR#
  	#ELSE
    	INTEGER _NPAR#
  	#ENDIF
    #IFDEF _RETURNING#
    #ELSE
        INTEGER _RETURNING#
    #ENDIF
    #IFDEF _THEREISBINDING#
    #ELSE
        INDICATOR _THEREISBINDING#
    #ENDIF

    INDICATE _THEREISBINDING# FALSE

    DO_CHECK_BINDING !3 !4 !5 !6 !7 !8 !9

  	MOVE 0 TO _NPAR#
  	INDICATE ERR FALSE
    SQL_SET_STMT TO "{? = CALL "
    SQL_APPEND_STMT TO !1
    SQL_APPEND_STMT TO " "
  	#IF (!0>2)
        DDO_PASS_ARGUMENTS !2 !3 !4 !5 !6 !7 !8 !9
        IF (_NPAR# > 0) SQL_APPEND_STMT TO ")"
  	#ENDIF
    SQL_APPEND_STMT TO  " }"

    MOVE 0 TO _NPAR#

    SQL_PREPARE_STMT
    DDO_BIND_PARAMETERS _RETURNING# SQLOUT !2 !3 !4 !5 !6 !7 !8 !9

    SQL_EXECUTE_STMT
    If ( _NPAR# GT 0 ) BEGIN
        MOVE 0 TO _NPAR#
        [NOT _THEREISBINDING#] DO_GET_SQLSERVER_PARAMETERS !3 !4 !5 !6 !7 !8 !9
    END

    DO_FETCH_FIRST_ROW !3 !4 !5 !6 !7 !8 !9

#ENDCOMMAND // CALL_SQLFLEX7_PROCEDURE

#COMMAND CALL_REEXEC_SQLFLEX7_PROCEDURE R "PASSING""BINDING"""
  	#IFDEF _NPAR#
  	#ELSE
    	INTEGER _NPAR#
  	#ENDIF
    #IFDEF _RETURNING#
    #ELSE
        INTEGER _RETURNING#
    #ENDIF
    #IFDEF _THEREISBINDING#
    #ELSE
        INDICATOR _THEREISBINDING#
    #ENDIF

    SQL_SET_STMT TO ""
    MOVE 0 TO _NPAR#

    DDO_BIND_PARAMETERS _RETURNING# SQLOUT !2 !3 !4 !5 !6 !7 !8 !9

    SQL_EXECUTE_STMT
    If ( _NPAR# GT 0 ) BEGIN
        MOVE 0 TO _NPAR#
        [NOT _THEREISBINDING#] DO_GET_SQLSERVER_PARAMETERS !3 !4 !5 !6 !7 !8 !9
    END

    DO_FETCH_FIRST_ROW !3 !4 !5 !6 !7 !8 !9

#ENDCOMMAND // CALL_REEXEC_SQLFLEX7_PROCEDURE

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND CALL_SQLFLEX2_PROCEDURE R "PASSING""BINDING"""
    DO_DECLARE_BASIC_VARIABLES#
  	#IFDEF _NPAR#
  	#ELSE
    	INTEGER _NPAR#
  	#ENDIF
  	MOVE 0 TO _NPAR#
    Move SQLFLEX TO _DRIVERNAME#
  	INDICATE ERR FALSE
	// INITIALIZE THE CALL
	#IFSAME !2 BINDING
    	SQL_SET_STMT TO !1
	  	CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 22 CALLBACK 0 PASSING _BLANK# _BLANK# 5 RESULT _RET#
		SQL_FETCH_NEXT_ROW INTO !3 !4 !5 !6 !7 !8 !9
	#ELSE
   		MOVE !1 TO _ARG1#
   		CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 25 CALLBACK 0 PASSING _ARG1# _BLANK# 0 RESULT _RET#
   		IF _RET# EQ -1 INDICATE ERR TRUE
  		#IF (!0>2) // SEND THE ARGUMENTS
            [ NOT ERR ] DO_BIND_SQLSERVER_PARAMETERS !3 !4 !5 !6 !7 !8 !9
  		#ENDIF
		// EXECUTE THE CALL
  		[ NOT ERR ] BEGIN
			CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 26 CALLBACK 0 PASSING _ARG1# _BLANK# 0 RESULT _RET#
   			IF _RET# EQ -1 INDICATE ERR TRUE
		END
		// GET THE VALUES BACK
  		[ NOT ERR ] BEGIN
    		If ( _NPAR# GT 0 ) BEGIN
      			MOVE 0 TO _NPAR#
                DO_GET_SQLSERVER_PARAMETERS !3 !4 !5 !6 !7 !8 !9
    		END
  		END
    #ENDIF
#ENDCOMMAND // CALL_SQLFLEX2_PROCEDURE

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND CALL_SQLSERVER_PROCEDURE R "PASSING""BINDING"""
    #IFDEF _SQLFLEXMAJOR_REV#
    #ELSE
        INTEGER _SQLFLEXMAJOR_REV#
    #ENDIF

    INDICATE _THEREISBINDING# FALSE

    SQLFlex_MAJOR_REVISION _SQLFLEXMAJOR_REV#

    IF _SQLFLEXMAJOR_REV# GE 7 BEGIN
        CALL_SQLFLEX7_PROCEDURE !1 !2 !3 !4 !5 !6 !7 !8 !9
    END
    ELSE BEGIN
        CALL_SQLFLEX2_PROCEDURE !1 !2 !3 !4 !5 !6 !7 !8 !9
    END
#ENDCOMMAND // CALL_SQLSERVER_PROCEDURE

//Last Revised: 2002-08-23 By: Marcelo
#REPLACE CALL_SQLSERVER_STORED_PROCEDURE CALL_SQLSERVER_PROCEDURE

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND END_CALL_PROCEDURE .
    DO_DECLARE_BASIC_VARIABLES#
    CALL_DRIVER 0 SQLFLEX FUNCTION 26 CALLBACK 0 PASSING _BLANK# _BLANK# 0 RESULT _RET#
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND GET_PROCEDURE_RETURN "TO" R .
    DO_DECLARE_BASIC_VARIABLES#
    CALL_DRIVER 0 SQLFLEX FUNCTION 27 CALLBACK 0 PASSING _BLANK# _BLANK# 0 RESULT _RET#
    Move _RET# TO !2
#ENDCOMMAND

//============================
// ORAFlex Commands
//============================

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND ORAFlex_REVISION #CRUG .
    DO_DECLARE_BASIC_VARIABLES#
    MOVE (REPEAT(" ",255)) to !1
    CALL_DRIVER 0 ORAFlex FUNCTION 0 CALLBACK 0 PASSING _BLANK# !1 0 RESULT _RET#
	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND KEEP_FILES_OPEN "OF" R .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    MOVE !2 TO _ARG1#
    IF (_DRIVERNAME# EQ ORAFlex OR _DRIVERNAME# EQ MDSDB2);
        CALL_DRIVER 0 _DRIVERNAME# FUNCTION 25 CALLBACK 0 PASSING _ARG1# _BLANK# 0 RESULT _RET#
    ELSE ;
        CALL_DRIVER 0 _DRIVERNAME# FUNCTION 28 CALLBACK 0 PASSING _ARG1# _BLANK# 0 RESULT _RET#
  	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#REPLACE DONT_CLOSE_FILES KEEP_FILES_OPEN

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SET_MAX_OPEN_CURSORS "OF" R "TO" R .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    MOVE !2 TO _ARG1#
    MOVE "0"  TO _ARG2#
    IF (_DRIVERNAME# EQ ORAFlex OR _DRIVERNAME# EQ MySQLFlex OR _DRIVERNAME# EQ PgFlex);
        CALL_DRIVER 0 _DRIVERNAME# FUNCTION CALLDRV_SQL_MAX_CURSORS CALLBACK 0 PASSING _ARG1# _ARG2# !4 RESULT _RET#
    ELSE IF _DRIVERNAME# EQ SQLFlex ;
        CALL_DRIVER 0 SQLFlex FUNCTION CALLDRV_SQLFLEX_MAX_CURSORS CALLBACK 0 PASSING _ARG1# _ARG2# !4 RESULT _RET#
  	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND GET_MAX_OPEN_CURSORS "OF" R "TO" RC .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    MOVE !2 TO _ARG1#
    MOVE "1" TO _ARG2#
    IF (_DRIVERNAME# EQ ORAFlex OR _DRIVERNAME# EQ MySQLFlex OR _DRIVERNAME# EQ PgFlex);
        CALL_DRIVER 0 _DRIVERNAME# FUNCTION CALLDRV_SQL_MAX_CURSORS CALLBACK 0 PASSING _ARG1# _ARG2# 0 RESULT _RET#
    ELSE IF _DRIVERNAME# EQ SQLFlex ;
        CALL_DRIVER 0 SQLFlex FUNCTION CALLDRV_SQLFLEX_MAX_CURSORS CALLBACK 0 PASSING _ARG1# _ARG2# 0 RESULT _RET#
  	IF _RET# EQ -1 INDICATE ERR TRUE
    ELSE MOVE _RET# TO !4
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND GET_OPENED_CURSORS "OF" R "TO" RC .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    MOVE !2 TO _ARG1#
    MOVE "2" TO _ARG2#
    IF (_DRIVERNAME# EQ ORAFlex OR _DRIVERNAME# EQ MySQLFlex OR _DRIVERNAME# EQ PgFlex);
        CALL_DRIVER 0 _DRIVERNAME# FUNCTION CALLDRV_SQL_MAX_CURSORS CALLBACK 0 PASSING _ARG1# _ARG2# 0 RESULT _RET#
    ELSE IF _DRIVERNAME# EQ SQLFlex ;
        CALL_DRIVER 0 SQLFlex FUNCTION CALLDRV_SQLFLEX_MAX_CURSORS CALLBACK 0 PASSING _ARG1# _ARG2# 0 RESULT _RET#
  	IF _RET# EQ -1 INDICATE ERR TRUE
    ELSE MOVE _RET# TO !4
#ENDCOMMAND

//Last Revised: 2006-03-21 By: Marcelo
#COMMAND ACTIVATE_TIME_STAMP "OF" R "TO" "ON""OFF"  .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    #IFSAME !4 ON
        Move 1 TO _LLONG#
    #ELSE
        Move 0 TO _LLONG#
    #ENDIF
    Move !2 TO _ARG1#
    CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 27 CALLBACK 0 PASSING _ARG1# _BLANK# _LLONG# RESULT _RET#
  	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND CALL_ORACLE_STORED_FUNCTION R "RETURNS" R "PASSING"""
  	#IFDEF _NPAR#
  	#ELSE
    	INTEGER _NPAR#
  	#ENDIF
  	MOVE 0 TO _NPAR#
  	INDICATE ERR FALSE
  	SQL_SET_STMT TO "BEGIN "
    SQL_APPEND_STMT TO ":PAR_RET := "
    SQL_APPEND_STMT TO !1
    SQL_APPEND_STMT TO "( "
    #IF (!0>4)
        DO_PASS_ARGUMENTS !5 !6 !7 !8 !9
  	#ENDIF
    SQL_APPEND_STMT TO  " ); END;"
    SQL_PREPARE_STMT

    DO_BIND_PAR_RET !3

    #IF (!0>4)
    	[ NOT ERR ] BEGIN
      		IF _NPAR# GT 0 BEGIN
                MOVE 0 TO _NPAR#
                DO_BIND_PARAMETERS !5 !6 !7 !8 !9 // Bind the other arguments
      		END
    	END
  	#ENDIF
    SQL_EXECUTE_STMT
  	[ NOT ERR ] BEGIN
        MOVE 0 TO _NPAR# // Getting returned value
        DO_GET_BIND_PARAMETERS !3
        #IF (!0>4)
            DO_GET_BIND_PARAMETERS !5 !6 !7 !8 !9 // Bind the other arguments
        #ENDIF
  	END
#ENDCOMMAND

//Last Revised: 2004-07-19 By: Marcelo
#COMMAND CALL_PGSQL_STORED_FUNCTION R "RETURNS" R "PASSING"""
  	#IFDEF _NPAR#
  	#ELSE
    	INTEGER _NPAR#
  	#ENDIF
  	MOVE 0 TO _NPAR#
  	INDICATE ERR FALSE
    SQL_SET_STMT TO "SELECT "
    SQL_APPEND_STMT TO !1
    SQL_APPEND_STMT TO "( "
    #IF (!0>4)
        DO_PASS_ARGUMENTS !5 !6 !7 !8 !9
  	#ENDIF
    SQL_APPEND_STMT TO  " )"
    SQL_PREPARE_STMT

    SQL_EXECUTE_STMT
  	[ NOT ERR ] BEGIN
        CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 22 CALLBACK 0 PASSING _BLANK# _BLANK# 6 RESULT _RET#
        [ NOT ERR ] BEGIN
            MOVE 0 TO _NPAR# // Getting returned value
            DO_GET_BIND_PARAMETERS !3
        END
  	END
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND MERTECH_LANGUAGE_SUPPORT "OF" R "TO" R .
    DO_DECLARE_BASIC_VARIABLES#
    MOVE !2 TO _ARG1#
    MOVE !4 TO _ARG2#
    CALL_DRIVER 0 ORAFlex FUNCTION 28 CALLBACK 0 PASSING _ARG1# _ARG2# 0 RESULT _RET#
  	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//===========================
// BUFFER save stuffs
//===========================

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_SAVE_BUFFER_BEGIN "OF" R "TO" R .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# !2
    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2) BEGIN
    	MOVE !4 TO _ARG1#
        IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ MDSDB2) CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 20 CALLBACK 0 PASSING _ARG1# _BLANK# 0 RESULT _RET#
        ELSE CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 8 CALLBACK 0 PASSING _BLANK# _ARG1#  1 RESULT _RET#
    	IF _RET# EQ -1 INDICATE ERR TRUE
  	END
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_SAVE_BUFFER "OF" R .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# !2
    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2) BEGIN
        IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ MDSDB2) CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 20 CALLBACK 0 PASSING _BLANK# _BLANK# 1 RESULT _RET#
        ELSE CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 8 CALLBACK 0 PASSING _BLANK# _BLANK# 2 RESULT _RET#
    	IF _RET# EQ -1 INDICATE ERR TRUE
  	END
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND SQL_SAVE_BUFFER_END "OF" R .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# !2
    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2) BEGIN
        IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ MDSDB2) CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 20 CALLBACK 0 PASSING _BLANK# _BLANK# 2 RESULT _RET#
        ELSE CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 8 CALLBACK 0 PASSING _BLANK# _BLANK# 4 RESULT _RET#
    	IF _RET# EQ -1 INDICATE ERR TRUE
  	END
#ENDCOMMAND

#COMMAND SQL_SAVE_SET_ATTRIBUTES "OF" R "DISABLED""KBYTES""ROWS" #L "TABLOCK"""
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# !2
    IF (_DRIVERNAME# EQ SQLFLEX) BEGIN
      #IFSAME !3 DISABLED
      #ELSE
        #CHECK !4 _FG#L
        #IFSAME !3 KBYTES
          MOVE ("KILOBYTES_PER_BATCH = " + STRING(!4)) TO _ARG1#
        #ELSE
          MOVE ("ROWS_PER_BATCH = " + STRING(!4)) TO _ARG1#
        #ENDIF

        #IF !0 > 4
          MOVE (_ARG1# + ", TABLOCK") TO _ARG1#
        #ENDIF
      #ENDIF
      CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 8 CALLBACK 0 PASSING _ARG1# _BLANK# 7 RESULT _RET#
      IF _RET# EQ -1 INDICATE ERR TRUE
  	END
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND ENABLE_TRACE_ON TO R "ERROR_LEVEL""DEBUG_LEVEL""DETAIL_LEVEL1""DETAIL_LEVEL2""DETAIL_LEVEL3"""
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    MOVE !2 TO _ARG1#
    #IF (!0=3)
        #IFSAME !3 ERROR_LEVEL
            MOVE -1 TO _ARG2#
        #ELSE
            #IFSAME !3 DEBUG_LEVEL
                MOVE 0 TO _ARG2#
            #ELSE
                #IFSAME !3 DETAIL_LEVEL1
                    MOVE 1 TO _ARG2#
                #ELSE
                    #IFSAME !3 DETAIL_LEVEL2
                        MOVE 2 TO _ARG2#
                    #ELSE
                        MOVE 3 TO _ARG2#
                    #ENDIF
                #ENDIF
            #ENDIF
        #ENDIF
    #ELSE
        MOVE 0 TO _ARG2#
    #ENDIF

    CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 15 CALLBACK 0 PASSING _ARG1# _ARG2# 0 RESULT _RET#
  	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND // ENABLE_TRACE_ON

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND DISABLE_TRACE_ON .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION 15 CALLBACK 0 PASSING _BLANK# _BLANK# 1 RESULT _RET#
  	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2003-08-14 By: Marcelo
// CREATE_TABLE_FROM_DAT_FILE <FILE NUMBER>
#COMMAND CREATE_TABLE_FROM_DAT_FILE R .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    CALL_DRIVER !1 _DRIVERNAME# FUNCTION 30 CALLBACK 0 PASSING _BLANK# _BLANK# 0 RESULT _RET#
    IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2002-08-14 By: Marcelo
// CONVERT_DAT_FILE <FILE NUMBER>
#COMMAND CONVERT_DAT_FILE R .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    CALL_DRIVER !1 _DRIVERNAME# FUNCTION 32 CALLBACK 0 PASSING _BLANK# _BLANK# 0 RESULT _RET#
    IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2002-08-23 By: Marcelo
#COMMAND REPORT_STMT T "BY""DOWN" VFW%LGR "BREAK"""
  #CHECK !1.RECNUM _UVCWGL
  INTEGER RECCOUNT
  #SET P$ 0
  //          MOVEINT 20000 TO LINECOUNT  // start with a full page
  !A [] $82 |CI20000 |VI10
  //          MOVE 0 TO RECCOUNT
  !A [] $82 |CI0 RECCOUNT
  //          BREAKINIT           // init breakpoints
  !A [] $207
  //          INDICATE FIRSTREC TRUE      // used for subtotals
  #IFDEF FIRSTREC
  #ELSE
    #REPLACE FIRSTREC |!C
  #ENDIF
  !A [] $4028 |CI0 |CI0 FIRSTREC~

  // Retrieve the First Row
  SQL_FETCH_NEXT_ROW OF !1.FILE_NUMBER
  //#IFSAME !2 BY
  //    FIND GE !1 BY !3          // FIND first record
  //#ELSE
  //    FIND LE !1 BY !3
  //#ENDIF
  [~FOUND] GOTO END$OF$REPORT
  //          CLEARSCREEN         // start with a clear screen
  !A [] $144
  RPT.LOOP://   INDICATE SELECT TRUE      // default for SELECT
  #IFDEF SELECT
  #ELSE
    #REPLACE SELECT |!C
  #ENDIF
  !A [] $4028 |CI0 |CI0 SELECT~
  //          GOSUB RPT.SELECTION     // go to user selection
  !A [] $42 |CL0
  #FREF RPT.SELECTION !a
  //[NOT SELECT] GOTO RPT.CONT        // test SELECT
  !A [~ SELECT] $41 |CL0
  #FREF RPT.CONT !a
  BREAK$ !5 !6 !7 !8 !9       // set breakpoints
  #SET X$ !p                  // set up to break down
  [NOT FIRSTREC] BREAK$DOWN RPT.SUBTOTAL  // break down for SUBTOTAL
  #SET X$ 0               // set up to break up
  //          RELATE !1           // get related records
  !A [] $C4 !1.RECNUM
  BREAK$UP RPT.SUBHEADER      // break up for SUBHEADER
  //          INCREMENT RECCOUNT
  !A [] $083 RECCOUNT |CI0
  //          GOSUB RPT.BODY          // print body
  !A [] $42 |CL0
  #FREF RPT.BODY !a
  //          INDICATE FIRSTREC FALSE     // not first any more
  !A [] $4028 |CI0 |CI0 FIRSTREC
  RPT.CONT:

  // Retrieve the next Row from current query
  SQL_FETCH_NEXT_ROW OF !1.FILE_NUMBER
  //#IFSAME !2 BY
  //    FIND GT !1 BY !3          // FIND next record
  //#ELSE
  //    FIND LT !1 BY !3
  //#ENDIF
  //          KEYCHECK            // check keyboard
  !A [] $46
  //[FOUND NOT KEYPRESS] GOTO RPT.LOOP    // if ok, loop
  !A [FOUND ~ KEYPRESS] $41 RPT.LOOP
  //[KEYPRESS]  GOSUB RPT.KEYPRESS    // user can disable KEYPRESS
  !A [FOUND KEYPRESS]   $42 |CL0
  #FREF RPT.KEYPRESS !a
  !A [FOUND ~ KEYPRESS] $41 RPT.LOOP
  #SET X$ !p                  // set up for break down
  END.OF.REPORT:
  [~ FIRSTREC]  BREAK$DOWN RPT.SUBTOTAL $X    // break down for last subtotals
  //[FIRSTREC]  GOSUB RPT.TOTAL       // print TOTAL
  !A [~ FIRSTREC] $42 |CL0
  #FREF RPT.TOTAL !a
  //          GOTO END$OF$REPORT      // GOTO end
  !A [] $41 |CL0
  #FREF END$OF$REPORT !a
  NEWPAGE://    GOSUB RPT.HEADER      // new page, print HEADER
  !A [] $42 |CL0
  #FREF RPT.HEADER !a
  #SET X$ 0    // this will reprint the page headers if included //
  [NOT FIRSTREC] BREAK$PRT SUBHEADER      // reprint pages
  //          RETURN              // end of NEWPAGE
  !A [] $43 |CI0
  RPT.SELECTION:              // selection starts after REPORT
#ENDCOMMAND

//Last Revised: 2005-07-05 By: Marcelo
// Syntax:
//   GET_SERVER_CFG SERVER_REVISION|SUPPORT_DESC|SUPPORT_CASE|SERVER_VERSION|SERVER_ENCODING|CONNECTION_ACTIVE OF <SERVER NAME> TO <RESULT>
// Description:
//   Use this command to retrieve from database server the following informations :
//   command arguments :
//      SERVER_REVISON : Retrieve Server major revision
//      SUPPORT_DESC : <RESULT> is 1 if Server supports Descending index segments
//      SUPPORT_CASE : <RESULT> is 1 if Server supports Case Insensitive index segments
//      SERVER_VERSION : Retrieve Complete Server Version Description
//      SERVER_ENCODING : Retrieve the Server Encoding
//      CONNECTION_ACTIVE : Retrieve the Connection status. DFTRUE means connection is active
//
#COMMAND GET_SERVER_CFG "SERVER_REVISION""SERVER_MIN_REVISION""SUPPORT_DESC""SUPPORT_CASE""SERVER_VERSION""SERVER_ENCODING""CONNECTION_ACTIVE" "OF" R "TO" R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    MOVE !3 TO _ARG1#
    MOVE (REPEAT(" ", 512)) TO _ARG2#
    MOVE 0 TO FILENUMBER

    MOVE 0 TO _LLONG#
    #IFSAME !1 SERVER_REVISION
        MOVE 0 TO _LLONG#
    #ELSE
        #IFSAME !1 SUPPORT_DESC
            MOVE 1 TO _LLONG#
        #ELSE
            #IFSAME !1 SUPPORT_CASE
                MOVE 2 TO _LLONG#
            #ELSE
                #IFSAME !1 SERVER_MIN_REVISION
                    MOVE 3 TO _LLONG#
                #ELSE
                    #IFSAME !1 SERVER_VERSION
                        MOVE 4 TO _LLONG#
                    #ELSE
                        #IFSAME !1 SERVER_ENCODING
                           MOVE 5 TO _LLONG#
                        #ELSE
                           MOVE 6 TO _LLONG#
                        #ENDIF
                    #ENDIF
                #ENDIF
            #ENDIF
        #ENDIF
    #ENDIF

    CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION CALLDRV_GET_SERVER_CFG CALLBACK 0 PASSING _ARG1# _ARG2# _LLONG# RESULT _RET#
  	IF _RET# EQ -1 INDICATE ERR TRUE
    ELSE BEGIN
      #IFSAME !1 SERVER_VERSION
         MOVE _ARG2# TO !5
      #ELSE
        #IFSAME !1 SERVER_ENCODING
          MOVE _ARG2# TO !5
        #ELSE
          MOVE _RET# TO !5
        #ENDIF
      #ENDIF
    END
#ENDCOMMAND

//Last Revised: 2005-07-20 By: Marcelo
// Syntax:
//  GET_CONNECTION_STATUS of <serverName> to <variable>
// Description:
//  Use this command to retrieve the connection status from the specified server
//  command argumetns :
//    <serverName> : Server Name
//    <variable> : DFTRUE means connection is active
#COMMAND GET_CONNECTION_STATUS "OF" R "TO" R
  GET_SERVER_CFG CONNECTION_ACTIVE OF !2 TO !4
#ENDCOMMAND

//Last Revised: 2005-04-06 By: Marcelo
// Syntax:
//   GET_CLIENT_CFG ENCODING OF <SERVER NAME> [<DATABASE NAME>] TO <RESULT>
// Description:
//   Use this command to retrieve from database server the following informations :
//   command arguments :
//      ENCODING : Retrieve the Client Encoding
//
#COMMAND GET_CLIENT_CFG "ENCODING""ENCODING_ID" "OF" R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    MOVE (REPEAT(" ", 255)) TO _ARG2#

    #IFSAME !5 TO
        MOVE (!3+"*"+!4) TO _ARG1#
    #ELSE
        #CHECK !4 "TO"
        MOVE !3 TO _ARG1#
    #ENDIF

    MOVE 0 TO FILENUMBER
    #IFSAME !1 ENCODING
        MOVE 0 TO _LLONG#
    #ELSE
        MOVE 3 TO _LLONG#
    #ENDIF

    CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION CALLDRV_CLIENT_CFG CALLBACK 0 PASSING _ARG1# _ARG2# _LLONG# RESULT _RET#
  	IF _RET# EQ -1 INDICATE ERR TRUE
    ELSE BEGIN
        #IFSAME !5 TO
            MOVE _ARG2# TO !6
        #ELSE
            MOVE _ARG2# TO !5
        #ENDIF
    END
#ENDCOMMAND

//Last Revised: 2006-05-26 By: Marcelo
// Syntax:
//   SET_CLIENT_CFG ENCODING OF <SERVER NAME> [<DATABASE NAME>] TO <RESULT>
// Description:
//   Use this command to Set the following client informations :
//   command arguments :
//      ENCODING : Set the Client Encoding
//      UNIQUE_CHECKS {DFTRUE/DFFALSE}: enable/disable uniqueness checks for secondary indexes in InnoDB tables
//
#COMMAND SET_CLIENT_CFG "ENCODING""UNIQUE_CHECKS" "OF" R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0
    MOVE 0 TO FILENUMBER

    #IFSAME !1 ENCODING
        MOVE 1 TO _LLONG#
        #IFSAME !4 TO
            MOVE !3 TO _ARG1#
            MOVE !5 TO _ARG2#
        #ELSE
            MOVE (!3+"*"+!4) TO _ARG1#
            MOVE !6 TO _ARG2#
        #ENDIF
    #ELSE
        #CHECK !4 "TO"
        MOVE !3 TO _ARG1#
        MOVE 2 TO _LLONG#
        MOVE !5 TO _ARG2#
    #ENDIF

    CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION CALLDRV_CLIENT_CFG CALLBACK 0 PASSING _ARG1# _ARG2# _LLONG# RESULT _RET#
  	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//NEW
//Last Revised: 2002-08-23 By: Marcelo
// Syntax:
//   FORMAT TO USE : CALL_DB2_PROCEDURE <OWNER> <STORED_PROC_NAME> [PASSING <ARG1> <ARG2> ....<ARGn>]
// Description:
//   CALL_STORED_PROCEDURE will call a stored procedure passing arguments
#COMMAND CALL_DB2_PROCEDURE R R "PASSING""BINDING"""
    DO_DECLARE_BASIC_VARIABLES#

    #IFDEF _THEREISBINDING#
    #ELSE
        INDICATOR _THEREISBINDING#
    #ENDIF

    LOAD_DRIVER "MDS_DB2"

    INDICATE _THEREISBINDING# FALSE

    #IF (!0>3)
    DO_CHECK_BINDING !4 !5 !6 !7 !8 !9
    #ENDIF

  	MOVE 0 TO _NPAR#
  	INDICATE ERR FALSE
    SQL_SET_STMT TO "CALL "
    SQL_APPEND_STMT TO !1
    SQL_APPEND_STMT TO "."
    SQL_APPEND_STMT TO !2
    SQL_APPEND_STMT TO " "
  	#IF (!0>2)
        DDO_PASS_ARGUMENTS  !3 !4 !5 !6 !7 !8 !9
        IF (_NPAR# > 0) SQL_APPEND_STMT TO ")"
  	#ENDIF

    MOVE (UPPERCASE(!1)) TO _ARG1#
    MOVE (UPPERCASE(!2)) TO _ARG2#

    CALL_DRIVER 0 MDSDB2 FUNCTION 23 CALLBACK 0 PASSING _ARG1# _ARG2# 0 RESULT _RET#
    IF _RET# NE -1 BEGIN
        MOVE 0 TO _NPAR#

        SQL_PREPARE_STMT
        #IF (!0>2)
        DDO_BIND_PARAMETERS  !3 !4 !5 !6 !7 !8 !9
        #ENDIF

        SQL_EXECUTE_STMT
        [ NOT ERR ] BEGIN
            If ( _NPAR# GT 0 ) BEGIN
                MOVE 0 TO _NPAR#
                [NOT _THEREISBINDING#] BEGIN
                    #IF (!0>3)
                        DDO_GET_BIND_PARAMETERS  !4 !5 !6 !7 !8 !9
                    #ENDIF
                END
            END
        END
    END
    ELSE INDICATE ERR TRUE
#ENDCOMMAND // CALL_DB2_PROCEDURE

// GET_RESULT_SET INTO <Var1 Var2 Var3 ... Varn>
#COMMAND GET_RESULT_SET "INTO" R
    SQL_FETCH_NEXT_ROW !1 !2 !3 !4 !5 !6 !7 !8 !9
#ENDCOMMAND

// GET_RESULTS
#COMMAND GET_RESULTS .
    DO_DECLARE_BASIC_VARIABLES#

    CALL_DRIVER 0 MDSDB2 FUNCTION CALLDRV_GET_RESULTS CALLBACK 0 PASSING _BLANK# _BLANK# 0 RESULT _RET#
    IF _RET# EQ -1 INDICATE FINDERR TRUE
    ELSE INDICATE FOUND TRUE
#ENDCOMMAND

// GET_MORE_RESULTS
#COMMAND GET_MORE_RESULTS .
    DO_DECLARE_BASIC_VARIABLES#

    CALL_DRIVER 0 MDSDB2 FUNCTION CALLDRV_GET_MORE_RESULTS CALLBACK 0 PASSING _BLANK# _BLANK# 0 RESULT _RET#
    IF _RET# EQ -1 INDICATE FINDERR TRUE
    ELSE BEGIN
        INDICATE FOUND TRUE
        GET_RESULTS
    END
#ENDCOMMAND

// GET_RESULT_SET_NUM_COLS TO <VAR>
#COMMAND GET_RESULT_SET_NUM_COLS "TO"
    GET_SQL_NUM_COLS !1 !2
#ENDCOMMAND

// GET_RESULT_SET_COL_NAME <COL NUMBER> TO <VAR> {<SIZE>}
#COMMAND GET_RESULT_SET_COL_NAME R "TO"
    GET_SQL_COL_NAME !1 !2 !3 !4
#ENDCOMMAND

#COMMAND GET_CURRENT_USER_NAME "OF" R "TO" R .
    DO_DECLARE_BASIC_VARIABLES#

    MOVE !2 TO _ARG1#
    MOVE (REPEAT(" ", 255)) TO _ARG2#

    CALL_DRIVER 0 MDSDB2 FUNCTION CALLDRV_GET_CURRENT_USER_NAME CALLBACK 0 PASSING _ARG1# _ARG2# 0 RESULT _RET#
    MOVE _ARG2# TO !4
    IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

// CREATE_DB2_DATABASE <DB Name> <DB Alias> <Code Set> <Territory> [<Path> <NodeName> < UserId> <Password>]
#COMMAND CREATE_DB2_DATABASE R R R R
    DO_DECLARE_BASIC_VARIABLES#
    // Set DB Name
    MOVE !1 TO _ARG1#
    CALL_DRIVER 0 MDSDB2 FUNCTION CALLDRV_CREATE_DB CALLBACK 0 PASSING _ARG1# _BLANK# 0 RESULT _RET#
    // Set DB Alias
    MOVE !2 TO _ARG1#
    CALL_DRIVER 0 MDSDB2 FUNCTION CALLDRV_CREATE_DB CALLBACK 0 PASSING _ARG1# _BLANK# 1 RESULT _RET#
    // Set Code Set
    MOVE !3 TO _ARG1#
    CALL_DRIVER 0 MDSDB2 FUNCTION CALLDRV_CREATE_DB CALLBACK 0 PASSING _ARG1# _BLANK# 2 RESULT _RET#
    // Set Territory
    MOVE !4 TO _ARG1#
    CALL_DRIVER 0 MDSDB2 FUNCTION CALLDRV_CREATE_DB CALLBACK 0 PASSING _ARG1# _BLANK# 3 RESULT _RET#

    #IF (!0 > 4)
        // Set Path
        MOVE !5 TO _ARG1#
        CALL_DRIVER 0 MDSDB2 FUNCTION CALLDRV_CREATE_DB CALLBACK 0 PASSING _ARG1# _BLANK# 4 RESULT _RET#
        #IF (!0 = 8)
            // Set NodeName
            MOVE !6 TO _ARG1#
            CALL_DRIVER 0 MDSDB2 FUNCTION CALLDRV_CREATE_DB CALLBACK 0 PASSING _ARG1# _BLANK# 5 RESULT _RET#
            // Set UserId
            MOVE !7 TO _ARG1#
            CALL_DRIVER 0 MDSDB2 FUNCTION CALLDRV_CREATE_DB CALLBACK 0 PASSING _ARG1# _BLANK# 6 RESULT _RET#
            // Set UserId
            MOVE !8 TO _ARG1#
            CALL_DRIVER 0 MDSDB2 FUNCTION CALLDRV_CREATE_DB CALLBACK 0 PASSING _ARG1# _BLANK# 7 RESULT _RET#
        #ENDIF
    #ENDIF

    CALL_DRIVER 0 MDSDB2 FUNCTION CALLDRV_CREATE_DB CALLBACK 0 PASSING _BLANK# _BLANK# 8 RESULT _RET#
    IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2005-04-04 By: Marcelo
#COMMAND SQL_OPEN_CURSOR_STMT "OF""TO""" R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    #IFSAME !1 OF
        MOVE !2 TO _ARG1#
    	#CHECK !3 "TO"
  	#ELSE
        MOVE "" TO _ARG1#
    	#CHECK !1 "TO"
  	#ENDIF

    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2 OR _DRIVERNAME# EQ MDSPgSQL OR _DRIVERNAME# EQ MDSMySQL) BEGIN
        CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION CALLDRV_OPEN_EMBEDDED_CURSOR CALLBACK 0 PASSING _ARG1# _BLANK# 0 RESULT _RET#
      	IF _RET# EQ -1 INDICATE ERR TRUE
    	#IFSAME !1 OF
            MOVE _RET# TO !4
    	#ELSE
            MOVE _RET# TO !2
    	#ENDIF
  	END
#ENDCOMMAND

//Last Revised: 2005-04-04 By: Marcelo
#COMMAND SQL_CLOSE_CURSOR_STMT "OF""TO""" R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    #IFSAME !1 OF
        MOVE !2 TO _ARG1#
    	#CHECK !3 "TO"
        MOVE !4 TO _LLONG#
  	#ELSE
        MOVE "" TO _ARG1#
    	#CHECK !1 "TO"
        MOVE !2 TO _LLONG#
  	#ENDIF

    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2 OR _DRIVERNAME# EQ MDSPgSQL OR _DRIVERNAME# EQ MDSMySQL) BEGIN
        CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION CALLDRV_CLOSE_EMBEDDED_CURSOR CALLBACK 0 PASSING _ARG1# _BLANK# _LLONG# RESULT _RET#
      	IF _RET# EQ -1 INDICATE ERR TRUE
  	END
#ENDCOMMAND

//Last Revised: 2005-04-04 By: Marcelo
#COMMAND SQL_SET_CURRENT_CURSOR_STMT "OF""TO""" R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    #IFSAME !1 OF
        MOVE !2 TO _ARG1#
    	#CHECK !3 "TO"
        MOVE !4 TO _LLONG#
  	#ELSE
        MOVE "" TO _ARG1#
    	#CHECK !1 "TO"
        MOVE !2 TO _LLONG#
  	#ENDIF

    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2 OR _DRIVERNAME# EQ MDSPgSQL OR _DRIVERNAME# EQ MDSMySQL) BEGIN
        CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION CALLDRV_SET_CURRENT_EMBEDDED_CURSOR CALLBACK 0 PASSING _ARG1# _BLANK# _LLONG# RESULT _RET#
      	IF _RET# EQ -1 INDICATE ERR TRUE
  	END
#ENDCOMMAND

//Last Revised: 2005-04-04 By: Marcelo
#COMMAND SQL_GET_CURRENT_CURSOR_STMT "OF""TO""" R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    #IFSAME !1 OF
        MOVE !2 TO _ARG1#
    	#CHECK !3 "TO"
  	#ELSE
        MOVE "" TO _ARG1#
    	#CHECK !1 "TO"
  	#ENDIF

    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2 OR _DRIVERNAME# EQ MDSPgSQL OR _DRIVERNAME# EQ MDSMySQL) BEGIN
        CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION CALLDRV_GET_CURRENT_EMBEDDED_CURSOR CALLBACK 0 PASSING _ARG1# _BLANK# 0 RESULT _RET#
      	IF _RET# EQ -1 INDICATE ERR TRUE
    	#IFSAME !1 OF
            MOVE _RET# TO !4
    	#ELSE
            MOVE _RET# TO !2
    	#ENDIF
  	END
#ENDCOMMAND

//Last Revised: 2005-04-04 By: Marcelo
#COMMAND SQL_SET_MAX_CURSORS_STMT "OF""TO""" R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    #IFSAME !1 OF
        MOVE !2 TO _ARG1#
    	#CHECK !3 "TO"
        MOVE !4 TO _LLONG#
  	#ELSE
        MOVE "" TO _ARG1#
    	#CHECK !1 "TO"
        MOVE !2 TO _LLONG#
  	#ENDIF

    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2 OR _DRIVERNAME# EQ MDSPgSQL OR _DRIVERNAME# EQ MDSMySQL) BEGIN
        CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION CALLDRV_SET_MAX_EMBEDDED_CURSOR CALLBACK 0 PASSING _ARG1# _BLANK# _LLONG# RESULT _RET#
      	IF _RET# EQ -1 INDICATE ERR TRUE
  	END
#ENDCOMMAND

//Last Revised: 2005-04-04 By: Marcelo
#COMMAND SQL_GET_MAX_CURSORS_STMT "OF""TO""" R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    #IFSAME !1 OF
        MOVE !2 TO _ARG1#
    	#CHECK !3 "TO"
  	#ELSE
        MOVE "" TO _ARG1#
    	#CHECK !1 "TO"
  	#ENDIF

    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2 OR _DRIVERNAME# EQ MDSPgSQL OR _DRIVERNAME# EQ MDSMySQL) BEGIN
        CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION CALLDRV_GET_MAX_EMBEDDED_CURSOR CALLBACK 0 PASSING _ARG1# _BLANK# 0 RESULT _RET#
      	IF _RET# EQ -1 INDICATE ERR TRUE
    	#IFSAME !1 OF
            MOVE _RET# TO !4
    	#ELSE
            MOVE _RET# TO !2
    	#ENDIF
  	END
#ENDCOMMAND

//Last Revised: 2005-04-04 By: Hideraldo
#COMMAND SQL_SET_LOCAL_TD_PATH "TO" R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    MOVE !2 TO _ARG1#
    MOVE 0  TO _LLONG#

    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2 OR _DRIVERNAME# EQ MDSMySQL OR _DRIVERNAME# EQ MDSPGSQL) BEGIN
        CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION CALLDRV_LOCAL_TD_PATH CALLBACK 0 PASSING _ARG1# _BLANK# _LLONG# RESULT _RET#
        IF _RET# EQ -1 INDICATE ERR TRUE
    END
#ENDCOMMAND

//Last Revised: 2005-04-04 By: Hideraldo
#COMMAND SQL_GET_LOCAL_TD_PATH "TO" R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    MOVE 1  TO _LLONG#

    IF (_DRIVERNAME# EQ ORAFLEX OR _DRIVERNAME# EQ SQLFLEX OR _DRIVERNAME# EQ MDSDB2 OR _DRIVERNAME# EQ MDSMySQL OR _DRIVERNAME# EQ MDSPGSQL) BEGIN
        CALL_DRIVER FILENUMBER _DRIVERNAME# FUNCTION CALLDRV_LOCAL_TD_PATH CALLBACK 0 PASSING _ARG1# _BLANK# _LLONG# RESULT _RET#
        IF _RET# EQ -1 INDICATE ERR TRUE
        ELSE MOVE _ARG1# TO !2
    END
#ENDCOMMAND

//Last Revised: 2003-04-08 By: Marcelo
#COMMAND GET_DRIVER_REVISION "TO" R .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    MOVE (REPEAT(" ",255)) to !2
    CALL_DRIVER 0 _DRIVERNAME# FUNCTION 0 CALLBACK 0 PASSING _BLANK# !2 0 RESULT _RET#
	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

#COMMAND SET_DATABASE_PORT "OF" "MYSQL""PGSQL" "TO" R .
    DO_DECLARE_BASIC_VARIABLES#

    #IFSAME !2 TO MYSQL
        MOVE MDSMySQL TO _DRIVERNAME#
    #ELSE
        MOVE MDSPGSQL TO _DRIVERNAME#
    #ENDIF

    IF (_DRIVERNAME# EQ MDSMySQL OR _DRIVERNAME# EQ MDSPGSQL) BEGIN
        MOVE !4 TO _ARG1#
        CALL_DRIVER 0 _DRIVERNAME# FUNCTION CALLDRV_LICENSE_ENVIRONMENT_SET CALLBACK 0 PASSING _ARG1# _BLANK# CALLDRV_SET_DB_PORT RESULT _RET#
        IF _RET# EQ -1 INDICATE ERR TRUE
    END
#ENDCOMMAND

#COMMAND GET_DATABASE_PORT "OF" "MYSQL""PGSQL" "TO" R .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    #IFSAME !2 TO MYSQL
        MOVE MDSMySQL TO _DRIVERNAME#
    #ELSE
        MOVE MDSPGSQL TO _DRIVERNAME#
    #ENDIF

    IF (_DRIVERNAME# EQ MDSMySQL OR _DRIVERNAME# EQ MDSPGSQL) BEGIN
        MOVE (REPEAT(" ",255)) to !4
        CALL_DRIVER 0 _DRIVERNAME# FUNCTION CALLDRV_LICENSE_ENVIRONMENT_SET CALLBACK 0 PASSING !4 _BLANK# CALLDRV_GET_DB_PORT RESULT _RET#
        IF _RET# EQ -1 INDICATE ERR TRUE
    END
#ENDCOMMAND

//Last Revised: 2004-11-03 By: Marcelo
#COMMAND SET_DATABASE_SOCKET "OF" "MYSQL" "TO" R .
    DO_DECLARE_BASIC_VARIABLES#

    MOVE MDSMySQL TO _DRIVERNAME#

    IF (_DRIVERNAME# EQ MDSMySQL) BEGIN
        MOVE !4 TO _ARG1#
        CALL_DRIVER 0 _DRIVERNAME# FUNCTION CALLDRV_LICENSE_ENVIRONMENT_SET CALLBACK 0 PASSING _ARG1# _BLANK# CALLDRV_SET_DB_SOCKET RESULT _RET#
        IF _RET# EQ -1 INDICATE ERR TRUE
    END
#ENDCOMMAND

//Last Revised: 2004-11-03 By: Marcelo
#COMMAND GET_DATABASE_SOCKET "OF" "MYSQL" "TO" R .
    DO_DECLARE_BASIC_VARIABLES#

    MOVE MDSMySQL TO _DRIVERNAME#

    IF (_DRIVERNAME# EQ MDSMySQL) BEGIN
        MOVE (REPEAT(" ",255)) to !4
        CALL_DRIVER 0 _DRIVERNAME# FUNCTION CALLDRV_LICENSE_ENVIRONMENT_SET CALLBACK 0 PASSING !4 _BLANK# CALLDRV_GET_DB_SOCKET RESULT _RET#
        IF _RET# EQ -1 INDICATE ERR TRUE
    END
#ENDCOMMAND

//Last Revised: 2004-11-17 By: Marcelo
#COMMAND SET_AUTENTICATION_MODE "OF" "ORACLE" "TO" "SYSDBA""DEFAULT" .
    DO_DECLARE_BASIC_VARIABLES#

    MOVE ORAFlex TO _DRIVERNAME#

    #IFSAME !4 SYSDBA
        MOVE 1 to _ARG1#
    #ELSE
        MOVE 0 to _ARG1#
    #ENDIF
    CALL_DRIVER 0 _DRIVERNAME# FUNCTION CALLDRV_LICENSE_ENVIRONMENT_SET CALLBACK 0 PASSING _ARG1# _BLANK# CALLDRV_SET_AS_SYSDBA RESULT _RET#
    IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

//Last Revised: 2003-08-27 By: Marcelo
#COMMAND SQL_ESCAPE_STRING "OF" R "TO" R
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    IF (_DRIVERNAME# EQ MDSMySQL OR _DRIVERNAME# EQ MDSPgSQL OR _DRIVERNAME# EQ SQLFlex  OR _DRIVERNAME# EQ ORAFlex) BEGIN
        MOVE !2 TO _ARG1#

        #IFDEF FMAC_VERSION
            If FMAC_VERSION eq 7 MOVE (REPEAT(" ", 1000)) TO _ARG2# // marcelo 06/28/2000 to avoid VDF 7 crashing problems
            Else MOVE (REPEAT(" ", 16384)) TO _ARG2#
        #ELSE
            MOVE (REPEAT(" ", 16384)) TO _ARG2#
        #ENDIF

        CALL_DRIVER 0 _DRIVERNAME# FUNCTION CALLDRV_ESCAPE_STRING CALLBACK 0 PASSING _ARG1# _ARG2# _NPAR# RESULT _RET#

        MOVE _ARG2# TO !4
    END
#ENDCOMMAND

//Last Revised: 2003-09-02 By: Marcelo
FUNCTION SQLESCAPESTRING GLOBAL STRING SARG RETURNS STRING
  LOCAL STRING LSARG
  SQL_ESCAPE_STRING OF SARG TO LSARG
  FUNCTION_RETURN LSARG
END_FUNCTION

//Last Revised: 2005-12-13 By: Marcelo
#COMMAND SQL_GET_STATEMENT "TO" #UGRLEC #L%U #L% .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    IF (_DRIVERNAME# EQ MDSMySQL or _DRIVERNAME# EQ ORAFlex) BEGIN
        #IF !0>2
          MOVE !3 TO _LLONG#   // Length

          #IF !0>3            // Start Position
            MOVE !4 TO _ARG2#
          #ELSE
            MOVE 0 TO _ARG2#
          #ENDIF
        #ELSE
            MOVE 0 TO _LLONG#
            MOVE 0 TO _ARG2#
        #ENDIF
        #IFDEF FMAC_VERSION
            If FMAC_VERSION eq 7 MOVE (REPEAT(" ", 1000)) TO _ARG2# // marcelo 06/28/2000 to avoid VDF 7 crashing problems
            Else MOVE (REPEAT(" ", 16384)) TO _ARG1#
        #ELSE
            MOVE (REPEAT(" ", 16384)) TO _ARG1#
        #ENDIF

        CALL_DRIVER 0 _DRIVERNAME# FUNCTION CALLDRV_GET_SQL_STMT CALLBACK 0 PASSING _ARG1# _ARG2# _LLONG# RESULT _RET#

        MOVE _ARG1# TO !2
    END
#ENDCOMMAND

//Last Revised: 2005-03-18 By: Marcelo
#COMMAND DIRECT_PATH_LOAD "OF" R "FROM" R

  DO_DECLARE_BASIC_VARIABLES#
  DO_GETFILENUMBER_DRIVERNAME# 0

  IF (_DRIVERNAME# EQ ORAFlex) BEGIN
    !A  [~ERR] $086 !4.File_Number _LLONG#
    CALL_DRIVER !2.File_Number ORAFlex FUNCTION CALLDRV_DIRECT_PATH_LOAD CALLBACK 0 PASSING _BLANK# _BLANK# _LLONG# RESULT _RET#
    IF _RET# EQ -1 INDICATE ERR TRUE
    #IF (!0=5)
       #CHECK !5 RLGU#
       !A  [~ERR] $086 _RET# !5
       !A  [ERR] $086 |CI0 !5
    #ENDIF
  End

#ENDCOMMAND

//Last Revised: 2005-03-21 By: Marcelo
#COMMAND SQL_INITIALIZE_SEQUENCE "OF" R .
  DO_DECLARE_BASIC_VARIABLES#
  DO_GETFILENUMBER_DRIVERNAME# !2

  IF (_DRIVERNAME# EQ ORAFlex OR _DRIVERNAME# EQ PgFlex) BEGIN
    CALL_DRIVER !2.File_Number _DRIVERNAME# FUNCTION CALLDRV_INITIALIZE_SEQUENCE CALLBACK 0 PASSING _BLANK# _BLANK# _LLONG# RESULT _RET#
    IF _RET# EQ -1 INDICATE ERR TRUE
  End
#ENDCOMMAND

//Last Revised: 2005-03-18 By: Marcelo
#COMMAND SQL_LOB_APPEND "OF" R R .
  DO_DECLARE_BASIC_VARIABLES#
  DO_GETFILENUMBER_DRIVERNAME# !2

  IF (_DRIVERNAME# EQ ORAFlex) BEGIN
    Move !3 To _LLONG#

    CALL_DRIVER !2.File_Number ORAFlex FUNCTION CALLDRV_APPEND_LOB CALLBACK 0 PASSING _BLANK# _BLANK# _LLONG# RESULT _RET#
    IF _RET# EQ -1 INDICATE ERR TRUE
  End
#ENDCOMMAND

//Last Revised: 2005-03-18 By: Marcelo
#COMMAND SQL_LOB_LENGTH "OF" R R "TO" R .

  DO_DECLARE_BASIC_VARIABLES#
  DO_GETFILENUMBER_DRIVERNAME# !2

  IF (_DRIVERNAME# EQ ORAFlex) BEGIN
    Move !3 To _LLONG#

    CALL_DRIVER !2.File_Number ORAFlex FUNCTION CALLDRV_LENGTH_LOB CALLBACK 0 PASSING _BLANK# _BLANK# _LLONG# RESULT _RET#
    MOVE _RET# to !5
  End
#ENDCOMMAND

//Last Revised: 2005-03-18 By: Marcelo
#COMMAND SQL_LOB_READ "OF" R R "FIRST""NEXT"
  DO_DECLARE_BASIC_VARIABLES#
  DO_GETFILENUMBER_DRIVERNAME# !2

  IF (_DRIVERNAME# EQ ORAFlex OR _DRIVERNAME# EQ MySQLFlex) BEGIN
    Move !3 To _LLONG#

    #IFSAME !4 FIRST
        MOVE "0" TO _ARG1#
    #ELSE
        MOVE "1" TO _ARG1#
    #ENDIF

    CALL_DRIVER !2.File_Number _DRIVERNAME# FUNCTION CALLDRV_READ_LOB CALLBACK 0 PASSING _ARG1# _BLANK# _LLONG# RESULT _RET#
    IF _RET# EQ -1 INDICATE ERR TRUE
    #IF (!0=5)
       #CHECK !5 RLGU#
       !A  [~ERR] $086 _RET# !5
       !A  [ERR] $086 |CI0 !5
    #ENDIF
  End
#ENDCOMMAND

//Last Revised: 2005-03-18 By: Marcelo
#COMMAND SQL_LOB_WRITE "OF" R R .
  DO_DECLARE_BASIC_VARIABLES#
  DO_GETFILENUMBER_DRIVERNAME# !2

  IF (_DRIVERNAME# EQ ORAFlex OR _DRIVERNAME# EQ MySQLFlex) BEGIN
    Move !3 To _LLONG#
    CALL_DRIVER !2.File_Number _DRIVERNAME# FUNCTION CALLDRV_WRITE_LOB CALLBACK 0 PASSING _BLANK# _BLANK# _LLONG# RESULT _RET#
    IF _RET# EQ -1 INDICATE ERR TRUE
  End

#ENDCOMMAND

//Last Revised: 2005-03-18 By: Marcelo
#COMMAND SQL_LOB_LOADFROMFILE "OF" R R "FROM" R R .
  DO_DECLARE_BASIC_VARIABLES#
  DO_GETFILENUMBER_DRIVERNAME# !2

  IF (_DRIVERNAME# EQ ORAFlex) BEGIN
    Move !3 To _LLONG#
    MOVE !5 TO _ARG1#
    MOVE !6 TO _ARG2#

    CALL_DRIVER !2.File_Number ORAFlex FUNCTION CALLDRV_LOADFROMFILE_LOB CALLBACK 0 PASSING _ARG1# _ARG2# _LLONG# RESULT _RET#
    IF _RET# EQ -1 INDICATE ERR TRUE
  End
#ENDCOMMAND

//Last Revised: 2005-03-18 By: Marcelo
#COMMAND SQL_LOB_ERASE "OF" R R R R .
  DO_DECLARE_BASIC_VARIABLES#
  DO_GETFILENUMBER_DRIVERNAME# !2

  IF (_DRIVERNAME# EQ ORAFlex) BEGIN
    Move !3 To _LLONG#
    MOVE !4 TO _ARG1#
    MOVE !5 TO _ARG2#

    CALL_DRIVER !2.File_Number ORAFlex FUNCTION CALLDRV_ERASE_LOB CALLBACK 0 PASSING _ARG1# _ARG2# _LLONG# RESULT _RET#
    IF _RET# EQ -1 INDICATE ERR TRUE
  End
#ENDCOMMAND

//Last Revised: 2005-03-18 By: Marcelo
#COMMAND SQL_LOB_TRUNCATE "OF" R R "TO" R .
  DO_DECLARE_BASIC_VARIABLES#
  DO_GETFILENUMBER_DRIVERNAME# !2

  IF (_DRIVERNAME# EQ ORAFlex) BEGIN
    Move !3 To _LLONG#
    MOVE !5 TO _ARG1#

    CALL_DRIVER !2.File_Number ORAFlex FUNCTION CALLDRV_TRUNCATE_LOB CALLBACK 0 PASSING _ARG1# _BLANK# _LLONG# RESULT _RET#
    IF _RET# EQ -1 INDICATE ERR TRUE
  End
#ENDCOMMAND

//
// MYSQL Specific Macro Commands
//

#COMMAND SQL_END_SAVERECORD "OF" R
  DO_GETFILENUMBER_DRIVERNAME# !2

  IF (_DRIVERNAME# EQ MySQLFlex) BEGIN
    CALL_DRIVER !2.File_Number _DRIVERNAME# FUNCTION CALLDRV_END_SAVERECORD CALLBACK 0 PASSING _BLANK# _BLANK# 0 RESULT _RET#
    IF _RET# EQ -1 INDICATE ERR TRUE
  End
#ENDCOMMAND

//Last Revised: 2005-08-23 By: Marcelo
#COMMAND SQL_ENABLE_RECONNECT "OF" R "TO" R .
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    MOVE !2 TO _ARG1#
    IF (_DRIVERNAME# EQ MySQLFlex);
        CALL_DRIVER 0 _DRIVERNAME# FUNCTION CALLDRV_ENABLE_RECONNECT CALLBACK 0 PASSING _ARG1# _BLANK# !4 RESULT _RET#
  	IF _RET# EQ -1 INDICATE ERR TRUE
#ENDCOMMAND

 ////////// Internal Macro Commands, Procedures and Functions

//Last Revised: 2005-08-29 By: Marcelo
#COMMAND CALL_MYSQL_STORED_PROCEDURE R "PASSING"""
    #IFDEF _ALL_PAR_POS#
    #ELSE
        INTEGER _ALL_PAR_POS#
    #ENDIF

    !A [] $82 |CI0 _ALL_PAR_POS#

    SQL_SET_PROCEDURE_NAME !1 NUMPAR (!0-2)

    #IF (!0>2)
        DO_SET_ALL_PROCEDURE_PARAMATERS !3 !4 !5 !6 !7 !8 !9
    #ENDIF

    SQL_PROCEDURE_EXECUTE

    #IF (!0>2)
        !A [] $82 |CI0 _ALL_PAR_POS#
        DO_GET_ALL_PROCEDURE_PARAMATERS !3 !4 !5 !6 !7 !8 !9
    #ENDIF
#ENDCOMMAND // CALL_MYSQLFLEX_PROCEDURE

//Last Revised: 2005-08-29 By: Marcelo
#COMMAND DO_SET_ALL_PROCEDURE_PARAMATERS
    INCREMENT _ALL_PAR_POS#
    SQL_SET_PROCEDURE_PARAMETER _ALL_PAR_POS# to !1 IN_OUT
    #IF !0>1
        DO_SET_ALL_PROCEDURE_PARAMATERS !2 !3 !4 !5 !6 !7 !8 !9
    #ENDIF
#ENDCOMMAND

//Last Revised: 2005-08-29 By: Marcelo
#COMMAND DO_GET_ALL_PROCEDURE_PARAMATERS
    INCREMENT _ALL_PAR_POS#
    SQL_GET_PROCEDURE_PARAMETER _ALL_PAR_POS# to !1
    #IF !0>1
        DO_GET_ALL_PROCEDURE_PARAMATERS !2 !3 !4 !5 !6 !7 !8 !9
    #ENDIF
#ENDCOMMAND

//Last Revised: 2005-08-29 By: Marcelo
#COMMAND CALL_MYSQL_STORED_FUNCTION R "RETURNS" R "PASSING"""
    #IFDEF _ALL_PAR_POS#
    #ELSE
        INTEGER _ALL_PAR_POS#
    #ENDIF

    !A [] $82 |CI0 _ALL_PAR_POS#

    #IF (!0>4)
        SQL_SET_FUNCTION_NAME !1 NUMPAR (!0-4)
        DO_SET_ALL_FUNCTION_PARAMATERS !5 !6 !7 !8 !9
    #ELSE
        SQL_SET_FUNCTION_NAME !1 NUMPAR 0
    #ENDIF

    SQL_PROCEDURE_EXECUTE

    SQL_GET_FUNCTION_RETURN to !3
#ENDCOMMAND

//Last Revised: 2005-08-29 By: Marcelo
#COMMAND DO_SET_ALL_FUNCTION_PARAMATERS
    INCREMENT _ALL_PAR_POS#
    SQL_SET_FUNCTION_PARAMETER _ALL_PAR_POS# to !1 IN
    #IF !0>1
        DO_SET_ALL_FUNCTION_PARAMATERS !2 !3 !4 !5 !6 !7 !8 !9
    #ENDIF
#ENDCOMMAND

//Last Revised: 2005-08-29 By: Marcelo
#COMMAND DO_GET_ALL_PROCEDURE_PARAMATERS
    INCREMENT _ALL_PAR_POS#
    SQL_GET_PROCEDURE_PARAMETER _ALL_PAR_POS# to !1
    #IF !0>1
        DO_GET_ALL_PROCEDURE_PARAMATERS !2 !3 !4 !5 !6 !7 !8 !9
    #ENDIF
#ENDCOMMAND

//Last Revised: 2005-08-29 By: Marcelo
 Procedure MertechInc_SQL_PROCEDURE_EXECUTE
    SQL_EXECUTE_STMT
 End_Procedure

//Last Revised: 2005-08-29 By: Marcelo
 Procedure MertechInc_SQL_FUNCTION_EXECUTE String sDriverName
    send MertechInc_SQL_PROCEDURE_EXECUTE
    if (sDriverName = MYSQLFLEX) begin
        SQL_FETCH_NEXT_ROW
    end
 End_Procedure

//Last Revised: 2005-08-29 By: Marcelo
 Procedure MertechInc_SQL_SET_MYPROCEDURE_NAME String strProcName Integer iNumpar
    Local Integer liPos#

    MOVE 0 TO _NPAR#
  	INDICATE ERR FALSE

    MOVE MySQLFlex TO _DRIVERNAME#

    SQL_SET_STMT TO "CALL "
    SQL_APPEND_STMT TO strProcName
    SQL_APPEND_STMT TO "("
    For liPos# From 1 TO iNumpar
        DO_PASS_ARGUMENTS liPos#
    Loop
    SQL_APPEND_STMT TO ")"

    SQL_PREPARE_STMT
 End_Procedure

//Last Revised: 2005-08-29 By: Marcelo
 Procedure MertechInc_SQL_SET_ORAPROCEDURE_NAME String strProcName Integer iNumpar
    Local Integer liPos#
    MOVE 0 TO _NPAR#
  	INDICATE ERR FALSE

    MOVE ORAFlex TO _DRIVERNAME#

    SQL_SET_STMT TO "BEGIN "
    SQL_APPEND_STMT TO strProcName
    SQL_APPEND_STMT TO "( "
    For liPos# From 1 TO iNumpar
        DO_PASS_ARGUMENTS liPos#
    Loop
    SQL_APPEND_STMT TO  " ); END;"
    SQL_PREPARE_STMT
 End_Procedure

//Last Revised: 2005-06-29 By: Marcelo
 Procedure MertechInc_SQL_SET_MYFUNCTION_NAME String strProcName Integer iNumpar
     Local Integer liPos#

    MOVE MySQLFlex TO _DRIVERNAME#

    SQL_SET_STMT TO "SELECT "
    SQL_APPEND_STMT TO strProcName
    SQL_APPEND_STMT TO "("
    For liPos# From 1 TO iNumpar
        DO_PASS_ARGUMENTS liPos#
    Loop
    SQL_APPEND_STMT TO ")"

    SQL_PREPARE_STMT
 End_Procedure

//Last Revised: 2005-06-29 By: Marcelo
 Procedure MertechInc_SQL_SET_ORAFUNCTION_NAME String strProcName Integer iNumpar
    Local Integer liPos# liLLong#
    Local String lsArg2# lsBlank#

  	SQL_SET_STMT TO "BEGIN "
    SQL_APPEND_STMT TO ":PAR_RET := "
    SQL_APPEND_STMT TO strProcName
    SQL_APPEND_STMT TO "( "
    For liPos# From 1 TO iNumpar
        DO_PASS_ARGUMENTS liPos#
    Loop
    SQL_APPEND_STMT TO  " ); END;"
    SQL_PREPARE_STMT

    MOVE IS_OUT TO liLLong#
    move " " to lsBlank#
    CALL_DRIVER 0 ORAFLEX FUNCTION CALLDRV_SET_PROC_ATTRIBUTE_TYPE CALLBACK 0 PASSING lsBlank# lsBlank# liLLong# RESULT _RET#

    INCREMENT _NPAR#
    MOVE ":PAR_RET" TO lsArg2#
    CALL_DRIVER 0 _DRIVERNAME# FUNCTION 23 CALLBACK 0 PASSING _BLANK# lsArg2# 16384 RESULT _RET#
End_Procedure

Function AvailableSQLServers Returns Integer
    Local Integer liRet#
    Local String lsBlank#

    move " " to lsBlank#
    CALL_DRIVER 0 SQLFLEX FUNCTION CALLDRV_ENUMERATE_SERVER CALLBACK 0 PASSING lsBlank# lsBlank# CALLDRV_ENUMERATE_SERVER_COUNT RESULT liRet#

    function_return liRet#
End_Function

Function AvailableSQLServerName Integer item# Returns String
    Local Integer liRet#
    Local String lsArg1# lsArg2# lsBlank#

    move item# to lsArg2#
    CALL_DRIVER 0 SQLFLEX FUNCTION CALLDRV_ENUMERATE_SERVER CALLBACK 0 PASSING lsArg1# lsArg2# CALLDRV_ENUMERATE_SERVER_SERVER RESULT liRet#

    function_return lsArg1#

    Function_Return
End_Function

//Last Revised: 2006-07-24 By: Marcelo
Procedure Set UseRowCountInTransactions global String server# Integer value#
    Local Integer liRet#
    Local String lsArg1# lsArg2#

    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    move server# to lsArg1#
    move value# to lsArg2#

    CALL_DRIVER 0 _DRIVERNAME# FUNCTION CALLDRV_USE_ROWCOUNT_IN_TRANSACTIONS CALLBACK 0 PASSING lsArg1# lsArg2# CALLDRV_VALUE_SET RESULT liRet#
    IF liRet# EQ -1 INDICATE ERR TRUE
End_Procedure

//Last Revised: 2006-07-24 By: Marcelo
Function UseRowCountInTransactions Global String serverName# Returns Integer
    Local Integer liRet#
    Local String lsBlank#
    Local String lsArg1#

    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    move serverName# to lsArg1#
    move " " to lsBlank#
    CALL_DRIVER 0 _DRIVERNAME# FUNCTION CALLDRV_USE_ROWCOUNT_IN_TRANSACTIONS CALLBACK 0 PASSING lsArg1# lsBlank# CALLDRV_VALUE_GET RESULT liRet#

    function_return liRet#
End_Function

//Last Revised: 2006-10-10 By: Marcelo
Procedure Set SqlUseDataflexDateFormat global Integer value#
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    If _DRIVERNAME# eq SQLFlex Begin
        move value# to _ARG1#
        CALL_DRIVER 0 _DRIVERNAME# FUNCTION CALLDRV_USE_DFLEX_DATE_FORMAT CALLBACK 0 PASSING _ARG1# _BLANK# CALLDRV_VALUE_SET RESULT _RET#
        IF _RET# EQ -1 INDICATE ERR TRUE
    End
End_Procedure

//Last Revised: 2006-10-10 By: Marcelo
Function SqlUseDataflexDateFormat Global Returns Integer
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    If _DRIVERNAME# eq SQLFlex Begin
        CALL_DRIVER 0 _DRIVERNAME# FUNCTION CALLDRV_USE_DFLEX_DATE_FORMAT CALLBACK 0 PASSING _BLANK# _BLANK# CALLDRV_VALUE_GET RESULT _RET#
    End
    Else Move DFFALSE to _RET#

    function_return _RET#
End_Function

//Last Revised: 2007-03-12 By: Marcelo
Procedure Set SqlForceFieldsNotNull global Integer value#
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    If (_DRIVERNAME# eq ORAFlex OR _DRIVERNAME# eq MySQLFlex) Begin
        move value# to _ARG1#
        CALL_DRIVER 0 _DRIVERNAME# FUNCTION CALLDRV_FORCE_FIELDS_NOT_NULL CALLBACK 0 PASSING _ARG1# _BLANK# CALLDRV_VALUE_SET RESULT _RET#
        IF _RET# EQ -1 INDICATE ERR TRUE
    End
End_Procedure

//Last Revised: 2007-03-12 By: Marcelo
Function SqlForceFieldsNotNull Global Returns Integer
    DO_DECLARE_BASIC_VARIABLES#
    DO_GETFILENUMBER_DRIVERNAME# 0

    If (_DRIVERNAME# eq ORAFlex OR _DRIVERNAME# eq MySQLFlex) Begin
        CALL_DRIVER 0 _DRIVERNAME# FUNCTION CALLDRV_FORCE_FIELDS_NOT_NULL CALLBACK 0 PASSING _BLANK# _BLANK# CALLDRV_VALUE_GET RESULT _RET#
    End
    Else Move DFFALSE to _RET#

    function_return _RET#
End_Function

