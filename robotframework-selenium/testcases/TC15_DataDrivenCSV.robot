*** Settings ***
Library  SeleniumLibrary
Resource    ../resource/DDTKeywords.robot
Library     DataDriver    ../testdata/ddtLogindataCSV.csv

Suite Setup    Launch App    # run before this test Suite (before all test cases)
Suite Teardown    Close App    # run after this test Suite (after running all test cases)
Test Template    Invalid Login    # define template at Suite level to be applicable to all tests in this Suite

*** Test Cases ***  
# create single test case- run multiple times with multiple sets of from csv
Login with user ${username} and password ${password}    Default    UserData   # user ${username} and password ${password} whole thing is included in testcase name

*** Keywords ***
Invalid Login
    [Arguments]    ${username}    ${password}    # credentials/data coming from csv and passed to Test Template
    # argument name should match with those provided in csv sheet, say if here userid is given, and csv contains {username} --[ ERROR ] Calling method '_start_suite' of listener 'DataDriver' failed: ValueError: Unassigned requiered argument detected: ${userid}.
    Set Email    ${username}
    Set Password    ${password}
    Click Login
    Error Message Should Be Visible
