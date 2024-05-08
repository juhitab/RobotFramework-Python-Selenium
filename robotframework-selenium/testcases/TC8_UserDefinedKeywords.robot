*** Settings ***
Library  SeleniumLibrary
Resource    ../resource/mykeywords.robot
*** Variables ***

${browser}  chrome
${url}  https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${userid}    Admin
${password}    admin123

*** Test Cases ***
Testing Userdefined Keywords

    ${title}=    Launch App    ${url}    ${browser}    # launches browser and opens App using these arguments and returns title of the page
    Should Contain   ${title}    Orange    ignore_case=True

    ${username}=    Login To App    ${userid}    ${password}    # logs in using credentials passed in arguments and returns logged in username
    Log To Console    Logged in user: ${username}    # Logged in user: Test 27Test Name user
    Close Browser