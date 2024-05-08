*** Settings ***
# import all libraries
Library  SeleniumLibrary
Library    OperatingSystem

*** Variables ***
# define the variables commonly used in test cases
${browser}      chrome
${url}      https://www.goindigo.in/

*** Test Cases ***
Capture Screenshot
    Open Browser    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login    ${browser}
    Maximize Browser Window
    Sleep    3s
    # Capture Element Screenshot(locator: WebElement | None | str, filename: str = selenium-element-screenshot-{index}.png)
    
    # providing filepath
    #screenshots folder is not present, but created automatically by script
    Capture Element Screenshot    //img[@alt="company-branding"]     C:/vscode-workspace/screenshots/orangebrand.png   # Captures a screenshot from the element identified by locator and embeds it into log file.
    File Should Exist    C:/vscode-workspace/screenshots/orangebrand.png    # but next time TC is run, this screenshot is replced by new since path is same

    # An absolute path to the created element screenshot is returned
    ${elementscreenPath}=    Capture Element Screenshot    //div[@class="orangehrm-login-logo"]//img[@alt="orangehrm-logo"]    # not providing path--creates in home directory
    Log To Console    ${elementscreenPath}    # C:\vscode-workspace\results\selenium-element-screenshot-3.png --stored in results folder in homedirectory with filename: selenium-element-screenshot-{index}.png

    # provide filepath using index - to make a unique path, previous screenshot not replaced
    Capture Element Screenshot    "company-branding"    C:/vscode-workspace/screenshots/orangebrand_{index}.png    # index starts from 1-checks if file already present inside folder, checks for next index
    File Should Exist    C:/vscode-workspace/screenshots/orangebrand_1.png    #can't pass {index} as variable here--need to pass absolute value
    # for images default locator strategy name id, src, alt- here alt="company-branding"
    
    #embed in log file
    Capture Element Screenshot    //img[@alt="company-branding"]    EMBED    # screenshot is embedded as Base64 image to the log.html. file is not created in the filesystem.

    #capture screenshot for page --all types similar to Capture Element screenshot
    Capture Page Screenshot    C:/vscode-workspace/screenshots/orangePage.png

    ${pagescreenPath}=    Capture Page Screenshot    # no path specified, stores screenshot in results folder in homedriectory and returns path
    Log To Console    ${pagescreenPath}    # C:\vscode-workspace\results\selenium-screenshot-44.png

    ${pagescreenPath}=    Capture Page Screenshot    C:/vscode-workspace/screenshots/orangePage_{index03}.png    # formatting index with 3 digits
    Log To Console    ${pagescreenPath}

    Capture Page Screenshot    embed    # screenshot embede to log file, but not present in filesystem
    File Should Not Exist    embed

Capture Screenshot_2
    Open Browser    https://www.goindigo.in/    ${browser}
    Maximize Browser Window
    # Switch Window    NEW
    Sleep    6s
    # Click Element    id="salePopupCloseBtn"
    Wait Until Element Is Enabled    //p[contains(@class,"MuiTypography")]/i[@class="ri-subtract-line"]    10s
    Click Element    //p[contains(@class,"MuiTypography")]/i[@class="ri-subtract-line"]
    Wait Until Element Is Visible    //a[@aria-label="Indigo"]    7
    Sleep    3s
    # Capture Element Screenshot(locator: WebElement | None | str, filename: str = selenium-element-screenshot-{index}.png)

    #screenshots folder is not present, but created automatically by script
    Capture Element Screenshot    //a[@aria-label="Indigo"]     C:/vscode-workspace/screenshots/indigolabel.png   # Captures a screenshot from the element identified by locator and embeds it into log file.
    File Should Exist    C:/vscode-workspace/screenshots/indigolabel.png

    # An absolute path to the created element screenshot is returned
    ${elementscreenPath}=    Capture Element Screenshot    //a/span[text()='Book Hotels']/ancestor::ul    # not providing path--creates in home directory
    Log To Console    ${elementscreenPath}
    # File Should Exist    ${OUTPUT_FILE}/

    Capture Page Screenshot    C:/vscode-workspace/screenshots/indigoPage.png
