*** Settings ***
Library  SeleniumLibrary

*** Variables ***

${browser}  chrome
${url}  https://demowebshop.tricentis.com/register

*** Test Cases ***
MouseActions
    Open Browser       https://swisnl.github.io/jQuery-contextMenu/demo.html       ${browser}
    Maximize Browser Window
 
    #right click
    Open Context Menu    //span[text()='right click me']    # open context menu--right click on element identified by locator
    Sleep    3s

    #double click
    Go To   https://testautomationpractice.blogspot.com/    # Go To- Navigates the current browser window to the provided url.
    Maximize Browser Window
    Double Click Element    //button[text()='Copy Text']
    Sleep    3s

    # drag and drop
    Go To    http://www.dhtmlgoodies.com/scripts/drag-drop-custom/demo-drag-drop-3.html
    Maximize Browser Window
    # Drags the element identified by locator into the target element.The locator argument is the locator of the dragged element and the target is the locator of the target.
    Drag And Drop    id:box4    id:box104    # src    target
    Sleep    3s

MouseHover_Tooltip_Validation
    # MouseHover to open and validate Ajax tooltip
    Open Browser    http://www.dhtmlgoodies.com/scripts/ajax-tooltip/ajax-tooltip.html    chrome
    Maximize Browser Window
    Mouse Over   //td[text()='JS Calendar']/ancestor::tr//a[text()='Info']    
    Sleep    3s 
    Element Should Contain    id:ajax_tooltip_content    JS Calendar    ignore_case=True    # Verifies that element locator contains text expected. To get locator of anything inside tooltip content, pause the debugger using setTimeout(()->{debugger;},5000)
    Click Link    Close