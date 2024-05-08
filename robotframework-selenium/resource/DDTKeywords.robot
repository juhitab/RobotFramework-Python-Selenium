*** Settings ***
Library    SeleniumLibrary
*** Variables ***
${url}     https://admin-demo.nopcommerce.com/login?ReturnUrl=%2Fadmin%2F
${browser}    chrome
*** Keywords ***
Launch App
    Open Browser    ${url}        ${browser}
    Maximize Browser Window
Close App
    Close All Browsers

Open Login Page       # optional
    Go To    ${url}

Set Email
    [Arguments]    ${username}    # arguments (test data) to be passed from script or excel or csv
    Input Text    id:Email     ${username}

Set Password
    [Arguments]    ${password}
    Input Text    id:Password     ${password}

Click Login
    Click Button    //button[@type="submit"]

Click logout
    Click Link    Logout

Error Message Should Be Visible    # invalid login
    Page Should Contain    Login was unsuccessful

DashBoard Page Should be Visible
    Page Should Contain    Dashboard