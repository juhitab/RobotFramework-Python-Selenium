*** Settings ***
Library    DatabaseLibrary
Library    OperatingSystem
Library    Collections
# SeleniumLibrary is not required here --no web automation is done, only database operations
Suite Setup    Connect To Database    ${dbApiModule}    ${dbName}    ${dbUsername}    ${dbPassword}    ${dbHost}    ${dbPort}    # need to specify every variable if variable names are passed according to their position in arguments, else need to specify which parameter you are assigning the variable like dbName=${dbName}
Suite Teardown    Disconnect From Database

*** Variables ***
${dbApiModule}    pymysql
${dbName}    test_schema
${dbUsername}    root
${dbPassword}    Password@1
${dbHost}    LocalHost
${dbPort}    3306

*** Test Cases ***

Create table User    Skip    Skip table create
    ${output}=    Execute Sql String    Create table User (id integer unique, first_name varchar(10), last_name varchar(10));
    Should Be Equal As Strings    ${output}    None
Check if table exists
    Table Must Exist    User    "User table does not exist"    # error message
Insert a record into table    #Skip    Skip single record entry
    Table Must Exist    User    "User table does not exist"    # error message
    ${output}=    Execute Sql String    Insert into User Values(001, 'Johny', 'Canady');
    Should Be Equal As Strings    ${output}    None
    Check If Exists In Database    Select * from User where first_name='Johny';

Delete a record from table    #Skip    msg=Skip record delete
    Check If Exists In Database        Select * from User where id=001;
    ${output}=    Execute Sql String    delete from user where id=001;
    Should Be Equal As Strings    ${output}    None 
    Check If Not Exists In Database    Select * from User where id=001;
Insert multiple records into table
     ${output}=   Execute Sql Script    robotframework-selenium/testdata/insert_users.sql    #../testdata/insert_users.sql    #C:/vscode-workspace/robotframework-selenium/testdata/insert_users.sql    
     Should Be Equal As Strings    ${output}    None
     Row Count Is Equal To X    Select * from User;    5
    
Count rows in table
    # ${rowcount}    Execute Sql String    Select count(*) from User; this will return None
    ${rowcount}    Query    Select count(*) from User;    # returns list of tuples [(5,)]--tuple with single element (5,)
    ${rowcount}=    Convert To String   ${rowcount[0][0]}    # 5
    #${rowcount}    Row Count    Select * from User;    # direct keyword to get row count
    Log To Console    Row count of User table: ${rowcount}    # Row count of User table: 5

Count rows in table2    # converting list of tuple to single value
    # ${rowcount}    Execute Sql String    Select count(*) from User; this will return None
    ${rowcount}    Query    Select count(*) from User;    # returns list of tuples ((5,),)
    ${rowcount}=    Get From List   ${rowcount}    0    # get the 0th index list element --0th index tuple -- (5,) --tuple with single element
    ${rowcount}=    Convert To List    ${rowcount}    # [5] --converting the tuple (0th list element) to list
    ${rowcount}=    Get From List    ${rowcount}    0    # 5--get 0th element from list containing single element [5]
    Log To Console    Row count of User table: ${rowcount}    # Row count of User table: 5

Update a record in table
    Check If Exists In Database    Select * from User where id=003;
    ${output}=     Execute Sql String    Update test_schema.User set last_name='Layman' where id=004;
    Should Be Equal As Strings    ${output}    None

Delete All records from table    Skip    msg=Skip delete all records delete
    Delete All Rows From Table    User
Delete table user    Skip    msg=Skip db delete
    ${output}=    Execute Sql String    Drop table if exists user;
    Should Be Equal As Strings    ${output}    None