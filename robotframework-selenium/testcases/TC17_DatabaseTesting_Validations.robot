*** Settings ***
Library    DatabaseLibrary
Library    OperatingSystem
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

Insert multiple records into table    Skip
    Table Must Exist    User    # f table exists then perform insert
    ${output}=   Execute Sql Script    robotframework-selenium/testdata/insert_users.sql    
    Should Be Equal As Strings    ${output}    None
    Row Count Is Greater Than X    Select * from User;    0    # number of rows>0 means records present/inserted in table

Retrieve all records from table
    @{queryresults}=    Query    select * from test_schema.User;    # returns result as list (list of tuples, each tuple storing all column values for each record) -so store in list variable
   # ${items}    Catenate    SEPARATOR=       @{queryresults}
   # Log To Console    ${items}    # (1, 'Johny', 'Canady')(2, 'Ram', 'Sena')(3, 'Duke', 'Paul')(4, 'Jerson', 'Layman')(5, 'George', 'Divit')
   # Log    many    @{queryresults}
    Log To Console    ${queryresults}    # [(1, 'Johny', 'Canady'), (2, 'Ram', 'Sena'), (3, 'Duke', 'Paul'), (4, 'Jerson', 'Layman'), (5, 'George', 'Divit')]
Retrieve specific columns from table
    @{queryresults}=    Query    select first_name,last_name from test_schema.User;    # list of tuples with only selected column values
    Log To Console    ${queryresults}    # [('Johny', 'Canady'), ('Ram', 'Sena'), ('Duke', 'Paul'), ('Jerson', 'Layman'), ('George', 'Divit')]
    # to retrieve each column value
    Log To Console    ${queryresults[0][1]} ${queryresults[0][0]}    # Canady Johny 
    Log To Console    ${queryresults[1][0]} ${queryresults[1][1]}    # Ram Sena

Retrieve records as list of dictionaries
    @{queryresults}=    Query    select * from test_schema.User;    \    True    # returnAsDict is set as True --each record is a separate dictionary with items having column names as keys and specific column values for that row as value
    Log To Console    ${queryresults}  # [{'id': 1, 'first_name': 'Johny', 'last_name': 'Canady'}, {'id': 2, 'first_name': 'Ram', 'last_name': 'Sena'}, {'id': 3, 'first_name': 'Duke', 'last_name': 'Paul'}, {'id': 4, 'first_name': 'Jerson', 'last_name': 'Layman'}, {'id': 5, 'first_name': 'George', 'last_name': 'Divit'}]
    Log To Console    ${queryresults[2]}[first_name] ${queryresults[2]}[last_name]    # Duke Paul
    Should Be Equal As Strings    ${queryresults[4]}[last_name]    Divit

Validate Table Description
    @{queryresults}=    Description    Select * from User Limit 1;
    Log To Console    ${queryresults}    # [('id', 3, None, 11, 11, 0, True), ('first_name', 253, None, 40, 40, 0, True), ('last_name', 253, None, 40, 40, 0, True)]
    ${output}=    Set Variable    ${queryresults[0]}
    Should Be Equal As Strings    ${output}    ('id', 3, None, 11, 11, 0, True)
    ${output}=    Set Variable    ${queryresults[1]}
    Should Be Equal As Strings    ${output}    ('first_name', 253, None, 40, 40, 0, True)
    ${output}=    Set Variable    ${queryresults[2]}
    Should Be Equal As Strings    ${output}    ('last_name', 253, None, 40, 40, 0, True)

Delete All records from table    Skip    msg=Skip delete all records delete
    Table Must Exist    User
    Delete All Rows From Table    User
