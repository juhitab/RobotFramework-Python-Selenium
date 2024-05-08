*** Settings ***
Library    SeleniumLibrary

Resource    ../Resources/EditProfileKeywords.robot
Resource    ../Resources/LoginKeywords.robot

*** Variables ***
${url}    https://demo.guru99.com/insurance/v1/index.php
${browser}    headlesschrome
${userid}    ab@ab.com
${password}    ab1234

*** Test Cases ***
Edit Profile Test
    [Tags]    regression
    Launch Insurance App    ${url}    ${browser}    # keywords from resource -LoginKeywords.robot
    Set Login Email ID    ${userid} 
    Set Login Password    ${password} 
    Click Login Button
    Go To Edit Profile            # from here keywords from resource-EditProfileKeywords.robot
    Select Title    Doctor
    Enter FirstName    Lean
    Enter Surname       Paul
    Enter Phone Number    9865748983
    Select Date of Birth    1994    March    21
    Select License Type    f 
    Select license Period    4
    Select Occupation    Surgeon
    Enter Address    Colony Street     Melbourne    Australia
    Enter Postcode    200120
    Click Update User Button