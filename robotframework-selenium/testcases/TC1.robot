*** Settings ***
# import all libraries
Library  SeleniumLibrary

*** Variables ***
# define the variables commonly used in test cases
${browser}  chrome
${url}  https://demo.nopcommerce.com/
${email}    dreamyrimis@gmail.com
${password}  admin123

*** Test Cases ***
# define the test cases
LoginTest
    open browser    ${url}     ${browser}
    LoginToApplication
    close browser

TitleValidation
    open browser    ${url}     ${browser}
    ${actualTitle}=  Get Title   #Title showing as nopCommerce demo store
    # Set Local Variable    ${actualTitle}    Get Title  # Title showing as Get Title--not taking it as keyword
    # ${actualTitle}    Set Variable    Get Title -- same as above--takes get title as string not keyword
    Title Should Be    nopCommerce demo store    Title showing as ${actualTitle}
    close browser

TestingInputBox
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    click link      link:Log in
    ${emailLocator}    Set Variable    id:Email    #this is just setting the variable value to a string "id:Email" which is a locator, everytime the variable is used in place of the locator, the element is looked up in the DOM by the driver. This is NOT storing the element in WebElement object, it is just storing the locator as a string
    Element Should Be Visible    ${emailLocator}    Element is not visible    #error message
    ${emailElement}    Get WebElement    ${emailLocator}    # this is storing the WebElement in ${emailElement} identified by locator  ${emailLocator} or id:Email
    Element Should Be Enabled    ${emailElement}    # passing the WebElement instead of locator -- element is looked up only once, stored in variable and variable is used multiple times
    
    Input Text    ${emailElement}    ${email}    Yes
    Sleep    5s    Wait to input text in email
    Clear Element Text    ${emailElement}
    Sleep    3s    Wait to clear the text
    Close Browser

RadioButton_Checkbox
    Open Browser    https://demoqa.com/radio-button    ${browser}
    Maximize Browser Window
    Set Selenium Speed  2    # Sets the delay that is waited after each Selenium command. 
    # sleep    6s 
    Scroll Element Into View    name:like    # Scrolls the element identified by locator into view.
    # Select Radio Button    group_name=like    value=impressiveRadio    # here value is id attribute
    ${impressiveRadio}    Get WebElement    id:impressiveRadio
    Execute Javascript    arguments[0].click(),${impressiveRadio}
    Select Radio Button    like    noRadio

    # checkbox
    Click Element    xpath://div[@class="element-list collapse show"]//span[text()='Check Box']
    Click Button    xpath://button[@title="Expand all"]
    Scroll Element Into View    xpath://input[@id="tree-node-angular"]/following-sibling::span[@class="rct-checkbox"]
    Select Checkbox    xpath://input[@id="tree-node-angular"]/following-sibling::span[@class="rct-checkbox"]
    Select Checkbox    xpath://input[@id="tree-node-private"]/following-sibling::span[@class="rct-checkbox"]

    Element Should Contain    id:result    "Angular" + "Private"    message=desired options not selected    ignore_case=True
RadioButton_Checkbox2
    Open Browser    https://demo.guru99.com/test/radio.html    ${browser}
    Maximize Browser Window
    ${speed} =    Get Selenium Speed
    Log To Console     ${speed}    # 0 seconds
    Set Selenium Speed    2
    Select Radio Button    group_name=webform    value=Option 2
    Radio Button Should Be Set To    webform    Option 2
    Select Radio Button    webform    Option 3

    Checkbox Should Not Be Selected    xpath://input[@value="checkbox1"]
    Select Checkbox    //input[@value="checkbox1"]
    Checkbox Should Be Selected    xpath://input[@value="checkbox1"]
    Select Checkbox    //input[@value="checkbox3"]
    
SingleDropDown
    Open Browser    https://demo.guru99.com/test/newtours/register.php    ${browser}
    Maximize Browser Window
    Scroll Element Into View    xpath://select[@name="country"]
    Select From List By Index    //select[@name="country"]    3
    ${selectedvalue}=     Get Selected List Value    xpath://select[@name="country"]    #Returns the value of selected option from selection list locator.If there are multiple selected options, the value of the first option is returned
    ${selectedlabel}=     Get Selected List Label     xpath://select[@name="country"] 
    Sleep    2s
    Log To Console   Selected Value is ${selectedvalue} and label is ${selectedlabel}    INFO
    Select From List By Label    xpath://select[@name="country"]    BAHRAIN
    Sleep    2s
    Select From List By Value    xpath://select[@name="country"]    INDIA

MultiSelectDropdown
    Open Browser    https://output.jsbin.com/osebed/2    ${browser}
    Maximize Browser Window
    Set Selenium Speed    1s
    List Should Have No Selections    id:fruits  # Verifies selection list locator has no options selected.
    @{allitems}=    Get List Items    id:fruits
    # ${items}=    Convert To String     @{allitems}    #Keyword 'BuiltIn.Convert To String' expected 1 argument, got 4.
    # ${items}=     Evaluate    ""+@{allitems} # TypeError: can only concatenate str (not "list") to str
    # ${items}=    Evaluate    "".join( @{allitems}) # joins the list elements as string
    ${items}    Catenate    SEPARATOR= -     @{allitems}
    Log To Console    ${items}    # Banana -Apple -Orange -Grape
    Select From List By Label    id:fruits    Apple
    Select From List By Value    id:fruits    grape
    
    ${selecteditems}=    Get Selected List Labels    id:fruits    # since list stored in $ means as scalar variable, can log diectly as string
    Log To Console   ${selecteditems}    # ['Apple', 'Grape']

    Unselect From List By Index    id:fruits    3    # same with lable or value
    List Selection Should Be    id:fruits    Apple
    Select All From List    id:fruits
    Unselect All From List    id:fruits

*** Keywords ***
# create own keywords
LoginToApplication
    click link      link:Log in
    Input text      id:Email    ${email}
    Input text      id:Password    ${password}
    click button    xpath://button[text()='Log in']