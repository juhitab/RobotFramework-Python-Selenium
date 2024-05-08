*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_url}    https://demoqa.com
${user}    Shiva Pratap
${pass}    ShivaPratap@1 

*** Test Cases ***
POST Register User
     Create Session    registersession    ${base_url}

    # create the json body (dictionary) and headers to pass (dictionary)
    ${requestbody}=    Create Dictionary    userName=${user}    password=${pass}    # &{dict} =	Create Dictionary	key=value	foo=bar			# key=value syntax
    ${header}=    Create Dictionary      Content-Type=application/json;charset=utf-8    Accept=*/*    #  mandatory header for POST request
    # ${proxyDict}=    Create Dictionary    http=URL_proxy_http    https=URL_proxy_https
    
    # Create Session    registersession    ${base_url}    headers=${header}    proxies=${proxyDict}
    # POST On Session    alias=registersession    url=/Account/v1/User    data=&{requestbody}    headers=&{header}    # Syntax
    ${response}=    Post Request      registersession        /Account/v1/User        data=${requestbody}       headers=${header}

    Log To Console    ${response.status_code}    # 201 for success, 406 - for POST On Session keyword
    Log To Console    ${response.content}    # b'{"userID":"7243399e-5057-46ef-9aef-8389b224f8d4","username":"Shiva Pratap","books":[]}'
    ${json}=    Set Variable    ${response.json()}

    # validation on new POST request
    Should Be Equal As Integers    ${response.status_code}    201

    Dictionary Should Contain Key    ${json}    userId    ignore_case=True
    ${userId}=    Get From Dictionary    ${json}    userId    default=None    # 7243399e-5057-46ef-9aef-8389b224f8d4
    Dictionary Should Contain Value    ${json}    ${user}
    Dictionary Should Contain Item    ${json}    username      ${user}  
    Should Be Empty    ${json}[books]
    
    # Validation on existing user
    # Should Be Equal    ${json}[code]    1204
    # Should Contain     ${json}[message]    User exists!

    ${auth_response}=    Post Request    registersession    /Account/v1/Authorized    data=${requestbody}       headers=${header}
    Log To Console    ${auth_response.content}
    Should Be Equal As Integers    ${auth_response.status_code}    200

    ${token_response}=    Post Request    registersession    /Account/v1/GenerateToken    data=${requestbody}       headers=${header}
    Log To Console    ${token_response.content}
    Should Be Equal As Integers    ${token_response.status_code}    200
    # User Should be registered    7243399e-5057-46ef-9aef-8389b224f8d4    #${userId}

*** Keywords ***
User Should be registered
    [Arguments]    ${UUID}
    Create Session    getuser    ${base_url}
    ${response}=    GET On Session    getuser    /Account/v1/User/${UUID}
    Should Be Equal As Integers    ${response.status_code}    200
    Log To Console    ${response.content}