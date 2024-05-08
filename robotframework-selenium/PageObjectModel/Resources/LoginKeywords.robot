*** Settings ***
Variables    ../PageObjects/Locators.py

Library    SeleniumLibrary

*** Keywords ***
Launch Insurance App
    [Arguments]    ${url}    ${browser}    # coming from test case
    Open Browser    ${url}    ${browser}
    Maximize Browser Window

Set Login Email ID
    [Arguments]    ${email}
    Input Text    ${loginEmail}    ${email}    # ${loginEmail} is the locator strategy defined in Locators.py (imported) --loginEmail = 'id:email'

Set Login Password
    [Arguments]    ${password}
    Input Text    ${loginPassword}    ${password}

Click Login Button
    Click Button    ${loginButton}
Wait for login
    Wait Until Page Contains    Broker Insurance WebPage    20s     Login is taking longer time than expected

Verify Successful Login
    [Arguments]    ${email}
    Page Should Contain    Signed in as
    Page Should Contain     ${email}

Logout from App
    Click Element    ${logoutButton}
