*** Settings ***
Library    SeleniumLibrary

*** Keywords ***

Launch App
    [Arguments]    ${AppURL}    ${AppBrowser}
    Open Browser    ${AppURL}    ${AppBrowser}
    Maximize Browser Window
    # ${title}=    Get Title
    # RETURN    ${title}    # or use Return From Keyword as below, since RETURN will be deprecated
    # Return From Keyword    ${title}    # instead of these 2 lines of Get Title and Return From Keyword {title}, use Run Keyword and Return (single line)
    Run Keyword And Return    Get Title    # arguments can be passed here, but Get Title takes no args    #Runs the specified keyword and returns from the enclosing user keyword.
    
Login To App
    [Arguments]    ${uid}    ${pwd}
    Wait Until Element Is Visible    username    7
    Input Text    username    ${uid}
    Input Password    password    ${pwd}
    Click Button     xpath://button[@type='submit']
    Wait Until Element Is Visible    //p[@class="oxd-userdropdown-name"]    8
    Run Keyword And Return    Get Text    //p[@class="oxd-userdropdown-name"]