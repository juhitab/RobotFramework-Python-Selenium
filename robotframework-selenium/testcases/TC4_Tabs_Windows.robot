*** Settings ***
# import all libraries
Library  SeleniumLibrary

*** Variables ***
# define the variables commonly used in test cases
${browser}      chrome
${url}      https://testautomationpractice.blogspot.com/

*** Test Cases ***
Handling Tabs
    Open Browser    https://demo.guru99.com/test/guru99home/    ${browser}
    Maximize Browser Window
    # clicking on an image (image contains link) inside a frame opens a new tab
    Select Frame    a077aa5e    # locator can be name id or xpath or the frame WebElement
    # Click Link    xpath://a    # using xpath(not default locator). When using the default locator strategy, links are searched using id, name, href and the link text. (only href is present, or use xpath: or css:)
    ${framelink}=    Get Element Attribute    css:a    href   # css: is locator mechanism (like id: or xpath:)--a is anchor tag <a>, since only 1 <a> present inside this frame
    Click Link    ${framelink}    # using href (link)    # new window tab

    # Switch to tabbed window
    Switch Window    Selenium Live Project: FREE Real Time Project for Practice    timeout=4    # using title (could use url, nme or id also)
    Title Should Be    Selenium Live Project: FREE Real Time Project for Practice
    Wait Until Element Is Enabled    xpath://ul[@id="primary-menu"]//a[@href="/software-testing.html"]/span    7s
    Click Element    //ul[@id="primary-menu"]//a[@href="/software-testing.html"]/span
    Sleep    3s
    Click Link    JUnit    # link text    --navigating to a new url, on the SAME tab
    Sleep    2s
    Page Should Contain    What is Junit?

    # currently 2 tabs are open
    Switch Window    MAIN    7    # timeout, check about browser argument later
    ${listofwindows}=    Get Window Handles    # gets handles of 2 windows

    #open new window again from MAIN window- 3rd window opens, switch to it using exclusion
    Select Frame    a077aa5e    #need to select frame again, switched to tab, focus lost
    Click Link    ${framelink}
    Unselect Frame 
    Switch Window    ${listofwindows}    # list of windows to be excluded (1st and 2nd windows) --switch to 3rd window
    Sleep    3s
    Page Should Contain    Project Summary    #validation of 3rd window
    Close Window    # Closes currently opened and selected browser window/tab. --3rd window closed
     
    # ${currentwindowhandle}=    Switch Window    CURRENT   
    # Log To Console    ${currentwindowhandle}    # returns None
    # Log Title    # Logs and returns the title of the current page.   # NoSuchWindowException: Message: no such window: target window already closed   
  # [ WARN ] Keyword 'Capture Page Screenshot' could not be run on failure: Message: no such window: target window already closed from unknown error: web view not found
    
    # driver is still pointing to closed window, hence exception--need to switch to a window
    Switch Window    main
    # open new window and switch window using new 
    Select Frame    a077aa5e   
    Click Link    ${framelink}    # new window opens again (3rd window)
    Unselect Frame 
    Switch Window    NEW    4s
    Sleep    3s
    Log Title        # Logs and returns the title of the current page in log file.--Selenium Live Project: FREE Real Time Project for Practice
    
    # currently 3 windows open
    Close Browser    # Closes the current browser.--ALL windows/tabs closed (all tabs under same browser)

Handling Windows_Browsers
    Open Browser    https://www.google.com    ${browser}
    Maximize Browser Window

#open a separate browser
    Open Browser    https://demo.guru99.com/test/guru99home/    ${browser}
    Maximize Browser Window

    Switch Browser    1    # if I'm sure index 1 means 1st browser
    ${title}=    Get Title
    Log To Console    ${title}    # Google

    Switch Browser    2    
    ${title}=    Get Title
    Log To Console    ${title}    # Demo Guru99 Page

    # if not sure which index to use, store index returned by open nrowser keyword, in a variable
    ${browser3}=    Open Browser     https://www.yahoo.com    ${browser}
    Maximize Browser Window

    ${browser4}=    Open Browser     https://www.facebook.com    ff    # ff is firefox browser
    Maximize Browser Window

    Switch Browser    ${browser3}
    ${title}=    Get Title
    Log To Console    ${title}    # Yahoo | Mail, Weather, Search, Politics, News, Finance, Sports & Videos

    # using alias
    Open Browser    https://www.goindigo.in/    chrome    alias=indigo
    Maximize Browser Window

    Switch Browser    ${browser4}
    ${title}=    Get Title
    Log To Console    ${title}    # Facebook – log in or sign up

    Switch Browser    indigo
    ${title}=    Get Title
    Log To Console    ${title}    # Book Domestic & International Flights at Lowest Airfare - IndiGo

    Close Browser    # only current browser is closed -- indigo closed, others open

    Close All Browsers     #--close all open browsers
