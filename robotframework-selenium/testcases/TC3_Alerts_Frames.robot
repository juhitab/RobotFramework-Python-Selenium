*** Settings ***
# import all libraries
Library  SeleniumLibrary

*** Variables ***
# define the variables commonly used in test cases
${browser}      chrome
${url}      https://testautomationpractice.blogspot.com/

*** Test Cases ***
HandlingAlerts
    Open Browser    ${url}    ${browser}
    Maximize Browser Window

    #Alert
    Click Element    //button[text()='Alert']     # opens alert
    Sleep    3s    To see the alert box    # reason
    # Handle Alert    # Handles the current alert and returns its message.--default action is ACCEPT
    ${alertmessage}=    Handle Alert    action=ACCEPT    timeout=3    # this timeout works same as wait for expected condition alert_is_present, also no need to specify ACCEPT (it's default)
    Log To Console     ${alertmessage}    # prints in console- I am an alert box! --can verify this text--keyword also present(see below)

    # confirm box
    Click Element    //button[text()='Confirm Box']    # opens laert
    Wait For Expected Condition    Alert is present    timeout=4    # won't keep the script waiting if alert is found, so to see the alert give sleep
    Sleep    2s
    Handle Alert    DISMISS    # timeout is not needed, as it is same as providing wait for expected conditioin above

    # leave the alert open
    Click Element    //button[text()='Confirm Box']    # opens alert
    ${alertmessage}=    Handle Alert    LEAVE    # alert left open
    Log To Console    ${alertmessage}    # Press a button!

    # better way to validate the text in alert box
    Alert Should Be Present    text=Press a button!    action=DISMISS    timeout=3    # Verifies that an alert is present. by default, accepts it. If text is a non-empty string, then it is used to verify alert's message.
    # Alert Should Be Present    Press a button!    # verifies the text and accepts alert
    Alert Should Not Be Present    DISMISS    5s    # Verifies that no alert is present.If the alert actually exists, the action argument determines how it should be handled. By default, the alert is accepted
    
    # prompt box --enter text into alert box
    Click Element    //button[text()='Prompt']    # opens alert
    Input Text Into Alert    David    timeout=3    # default action, accpeted
    Click Element    //button[text()='Prompt']    # opens alert
    Input Text Into Alert    Tom    LEAVE    3s    # action=LEAVE

Handling Frames
    Open Browser    https://demo.guru99.com/test/guru99home/    ${browser}
    Maximize Browser Window

    Select Frame    a077aa5e    # locator can be name id or xpath or the frame WebElement
    ${framelink}=    Get Element Attribute    css:a    href   # css: is locator mechanism (like id: or xpath:)--a is anchor tag <a>, since only 1 <a> present inside this frame
    Log To Console    ${framelink}    # http://www.guru99.com/live-selenium-project.html
    Should Contain    ${framelink}    selenium-project    
    Click Link    ${framelink}    # When using the default locator strategy, links are searched using id, name, href and the link text.
    Unselect Frame    # first need to unselect frame to go back to main frame, to select another frame

    # select second frame
    Select Frame    //div[@id="rt-showcase"]//iframe
    Click Element    id:player    # plays video inside frame
    Unselect Frame