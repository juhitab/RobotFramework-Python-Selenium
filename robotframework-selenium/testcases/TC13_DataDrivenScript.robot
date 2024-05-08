*** Settings ***
Library  SeleniumLibrary
Resource    ../resource/DDTKeywords.robot

Suite Setup    Launch App    # run before this test Suite (before all test cases)
Suite Teardown    Close App    # run after this test Suite (after running all test cases)
# Test Template    Invalid Login    # define template at Suite level to be applicable to all tests in this Suite

*** Test Cases ***    
# create multiple test cases depending on all the different combinations of test data for data driven testing(invalid creds)
Correct Email Incorrect Passowrd    admin@yourstore.com    admin12    # test case names with credentials to be passed as arguments in Test Template
    [Template]    Invalid Login    # define template at test level

Correct Email Empty Passowrd    admin@yourstore.com    ${EMPTY}
    [Template]    Invalid Login
Incorrect Email Correct Passowrd    admin12@yourstore.com    admin
    [Template]    Invalid Login
Incorrect Email Incorrect Passowrd    admin@yourstore.com    admin12
    [Template]    Invalid Login
Incorrect Email Empty Passowrd    admin23@yourstore.com    ${EMPTY}
    [Template]    Invalid Login
Correct Email Correct Password    admin@yourstore.com    admin    # valid creds
    [Template]    Valid Login

*** Keywords ***
Invalid Login
    [Arguments]    ${userid}    ${password}
    Set Email    ${userid}
    Set Password    ${password}
    Click Login
    Error Message Should Be Visible

Valid Login
    [Arguments]    ${userid}    ${password}
    Set Email    ${userid}
    Set Password    ${password}
    Click Login
    DashBoard Page Should be Visible