*** Settings ***
Library    RequestsLibrary
Library    Collections        # to work with dictionaries--which are Collections
Library    JSONLibrary

*** Variables ***
${base_url}    https://demoqa.com
${city}    Delhi

*** Test Cases ***
Get WeatherInfo for City
    Create Session    mysession    ${base_url}
    ${response}=    GET On Session    mysession    /utilities/weather/city/${city}    expected_status=any
    Log To Console    Status code: ${response.status_code}    # Status code: 200 --type integer
    Log To Console    response body: ${response.content}    # response body (type dictionary): {"City":"Delhi","Temperature":"186 Degree celsius","Humidity":"81 Percent","Weather Description":"scattered clouds","Wind Speed":"123 Km per hour","Wind Direction degree":"89 Degree"}
    Log To Console    headers: ${response.headers}    # headers (type dictionary): {'Server': 'nginx/1.17.10 (Ubuntu)', 'Date': 'Mon, 06 May 2024 16:17:55 GMT', 'Content-Type': 'application/json; charset=utf-8', 'Content-Length': '183', 'Connection': 'keep-alive', 'X-Powered-By': 'Express', 'ETag': 'W/"b7-jD+yJ5EQXnGGY93GOB3WxqIH090"'}
Validate Status Code
    Create Session    mysession    ${base_url}
    ${response}=    GET On Session    mysession    /utilities/weather/city/${city}
    # Validations
    # ${status}=    Convert To String    ${response.status_code}
    Should Be Equal As Integers    ${response.status_code}    200

Validate Response Body
# response body (type dictionary): {"City":"Delhi","Temperature":"186 Degree celsius","Humidity":"81 Percent","Weather Description":"scattered clouds","Wind Speed":"123 Km per hour","Wind Direction degree":"89 Degree"}
    Create Session    mysession    ${base_url}
    ${response}=    GET On Session    mysession    /utilities/weather/city/${city}

    # check type of ${response.content}
    ${type string}=    Evaluate     type(${response.content}).__name__
    Log To Console     ${type string}    # dict

    # check if a particular text is present in the response content
    ${body}=    Convert To String    ${response.content}
    Should Contain    ${body}    Humidity    # check if Humidity key is present in json body (converted to string)
    Should Contain    ${body}    "City":"${city}"   # check if "City":"Delhi" pair is present in json body (converted to string)
    
    # extract the value for a particular key in the json body

    # ${json}=    Evaluate    json.loads(${response.json()})      modules=json  # json.loads(${response.json()}) or json.loads(${response.content}) --TypeError: the JSON object must be str, bytes or bytearray, not dict  
    # check Evaluate     [json.loads(item) for item in ('1', '"b"')]	for other API
    
    ${json}  Set Variable    ${response.json()}    # returns dictionary
    Log To Console    json-> ${json}    # json-> {'City': 'Delhi', 'Temperature': '46 Degree celsius', 'Humidity': '86 Percent', 'Weather Description': 'scattered clouds', 'Wind Speed': '65 Km per hour', 'Wind Direction degree': '97 Degree'}
    
    # check type of ${response.json()}
    ${type string}=    Evaluate     type(${json}).__name__
    Log To Console     Type of json-> ${type string}    # dict


    # since ${json} or response.json() is a dictionary, can do all dictionary operations
    Log To Console    Value of key Humidity is ${json}[Humidity]    # extract dictionary value using key Humidity

    # Get value using Json Keyword- Get Value From Json
    ${values}=    Get Value From Json    ${json}    $..Temperature    # values -> ['174 Degree celsius'] --return array of values
    Log To Console    value -> ${values}[0]    # value -> 174 Degree celsius

    # Get value using Collection keyword for dictionary - Get from Dictionary # no need to convert json to dictionay because here json's type is dict
    ${temperatureValue}=    Get From Dictionary    ${json}    Temperature    default=no value   # default argument is mandatory
    Log To Console    Temperature of ${city} is ${temperatureValue}
    
    # validation on body
    Should Contain    ${temperatureValue}    Degree celsius    ignore_case=True
    Dictionary Should Contain Item    ${json}    City     ${city}    # key City should be present and corresponding value should be variable ie Delhi
    Dictionary Should Contain Key    ${json}    Weather Description
    Should Contain    ${response.json()}[Wind Speed]    Km per hour    # ${response.json()}is equal to ${json}, Wind Speed is the key
    Dictionary Should Not Contain Value    ${response.json()}    Climate

Validate Response Header
# headers (type dictionary): {'Server': 'nginx/1.17.10 (Ubuntu)', 'Date': 'Mon, 06 May 2024 16:17:55 GMT', 'Content-Type': 'application/json; charset=utf-8', 'Content-Length': '183', 'Connection': 'keep-alive', 'X-Powered-By': 'Express', 'ETag': 'W/"b7-jD+yJ5EQXnGGY93GOB3WxqIH090"'}
    Create Session    mysession    ${base_url}
    ${response}=    GET On Session    mysession    /utilities/weather/city/${city}

    # ${response.header} already returns a dictionary
    ${headerValue}=    Get From Dictionary    ${response.headers}    Content-Type    default=None
    Log To Console    Content-Type of header is ${headerValue}    # Content-Type of header is application/json; charset=utf-8
    # get value of dictionary using key
    Log To Console    Content-Length of header is ${response.headers}[Content-Length]    # Content-Length of header is 182

    # validation for header
    Should Contain    ${response.headers}[Content-Type]    application/json
    Dictionary Should Contain Key    ${response.headers}    Server    ignore_case=True