*** Settings ***
Library    SeleniumLibrary
Library    DependencyLibrary.py
Resource    ../Resources/LoginKeywords.robot

*** Variables ***
${url}    https://demo.guru99.com/insurance/v1/index.php
${browser}    headlessfirefox
${userid}    ab@ab.com
${password}    ab1234

*** Test Cases ***
Verify Login To Application
    [Tags]    sanity    
    Launch Insurance App    ${url}    ${browser}
    Set Login Email ID    ${userid} 
    Set Login Password    ${password} 
    Click Login Button
    Wait for login
    Verify Successful Login    ${userid}    # verify the login for this user
    

Logout from App    
    [Tags]    sanity
    Depends On Test    Verify Login To Application
    Logout from App
    Close Browser    # built in keyword, not a user defined keyword