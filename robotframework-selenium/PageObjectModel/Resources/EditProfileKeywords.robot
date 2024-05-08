*** Settings ***
Library    SeleniumLibrary
Variables    ../PageObjects/Locators.py

*** Keywords ***
Go To Edit Profile
    Click Link    ${editProfile}
Verify Edit Profile Page
    Page Should Contain    Editing user profile
Select Title
    [Arguments]    ${title}
    Select From List By Label    ${titleDrpdn}    ${title}
Enter Surname
     [Arguments]    ${last_name}
     Input Text    ${surname}     ${last_name}  
Enter FirstName
     [Arguments]    ${fname}
     Input Text    ${firstname}     ${fname}  
Enter Phone Number
    [Arguments]    ${phNum}
     Input Text    ${phone}     ${phNum}  
Select Date of Birth
    [Arguments]    ${year}    ${month}    ${day}
    Select From List By Label    ${birth_year}    ${year}
    Select From List By Label    ${birth_month}    ${month}
    Select From List By Label    ${birth_day}    ${day}
Select License Type
    [Arguments]    ${type}
    Select Radio Button    ${licenseTypeName}    ${type}    # groupname  value (id or value attribute)
    Radio Button Should Be Set To    ${licenseTypeName}    ${type} 
Select license Period
    [Arguments]    ${period}
    Select From List By Label    ${licensePeriod}    ${period}
Select Occupation
    [Arguments]    ${occup}
    Select From List By Label    ${occupation}    ${occup}
Enter Address
    [Arguments]    ${street}     ${city}    ${country}
    Input Text    ${address_street}    ${street}
    Input Text    ${address_city}    ${city}
    Input Text    ${address_country}    ${country}

Enter Postcode
    [Arguments]    ${code}
    Input Text    ${postcode}    ${code}
Click Update User Button
    Click Button    ${updateUserBtn}
