*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    json
Library    JSONLibrary

*** Variables ***
${baseUrl}    https://api.restful-api.dev

*** Test Cases ***

Get List of Objects
    Create Session    getlistsession    ${baseUrl}    
    ${response}=    GET On Session    getlistsession    /objects
    Should Be Equal As Integers    ${response.status_code}    200
    Log To Console    ${response.content}
    # ${type}    Evaluate    type(${response.content}).__name__
    # Log To Console    response.content type: ${type}

    ${json}    Set Variable    ${response.json()}
     ${type}    Evaluate    type(${json}).__name__
    Log To Console    json type: ${type}    # list ---list of dictionaries -each dictionary rpresents a json object

    ${name}=    Get Value From Json    ${json}    $..name    # returns a list/array of values for all "name" attributes of all jsob objects-['Google Pixel 6 Pro', 'Apple iPhone 12 Mini, 256GB, Blue', 'Apple iPhone 12 Pro Max', 'Apple iPhone 11, 64GB', 'Samsung Galaxy Z Fold2', 'Apple AirPods', 'Apple MacBook Pro 16', 'Apple Watch Series 8', 'Beats Studio3 Wireless', 'Apple iPad Mini 5th Gen', 'Apple iPad Mini 5th Gen', 'Apple iPad Air', 'Apple iPad Air']
    Log To Console     ${name}
    # check if a device name is persent in the list of objects
    Should Contain    ${name}    Apple MacBook Pro 16

    # extract value from an atrribute depending on another attribute in json-- using json path
    ${jsonpath}    Set Variable    $[?(@.id=='7')].name    # fetch value for name atrribute for id=7 from the list of objects
    ${nameofobject}=    Get Value From Json    ${json}    ${jsonpath}
    Log To Console    Name of device at id 7: ${nameofobject}    # Name of device at id 7: ['Apple MacBook Pro 16']

    ${jsonpath}    Set Variable    $[?(@.id=='3')].data.color
    ${colorofobject}=    Get Value From Json    ${json}    ${jsonpath}
    Log To Console    Color of device at id 3: ${colorofobject}    # Color of device at id 3: ['Cloudy White']

    ${jsonpath}    Set Variable    $[?(@.name=='Apple iPad Mini 5th Gen')].data.Capacity
    ${capacity}=    Get Value From Json    ${json}    ${jsonpath}
    Log To Console    ${capacity}    # ['64 GB', '254 GB'] --2 objects with same name

    ${jsonpath}    Set Variable    $[?(@.name=='Apple iPad Mini 5th Gen' & @.id=='10')].data.Capacity
    ${capacity}=    Get Value From Json    ${json}    ${jsonpath}
    Log To Console    ${capacity}    # ['64 GB']
    Should Be Equal    ${capacity}[0]    64 GB

    # ${jsonpath}    Set Variable    $[?(@.id=='7')].data.CPU model    # Parser failed to understand syntax --due to space
    # get the json value of data for specific id -as list (of dictionary) -list[0] gives the dictionary- retrieve value from data dictionary using key (like python dictionary)
    ${jsonpath}    Set Variable    $[?(@.id=='7')].data
    ${data}=    Get Value From Json    ${json}    ${jsonpath}    # return data attribute value as a list
    Log To Console    CPU model: ${data}[0][CPU model]    # ${data}[0] is the dictionary, CPU model is the key--O/p-- CPU model: Intel Core i9

# {'statusCode': 200, 'Status': 'Success', 'GroupId': None, 'ActivityId': '8234560b-05d8-49a3-92c5-0ae6cea3ff80', 'MessageId': '3c326bb3-9798-4310-b95f-30135441090f', 'MessageType': 2, 'Payload': {'Result': {'Vid': {'Data': [{'label': 'lb1', 'Value': 1, 'Timestamp': '2020-09-01T09:31:30Z'}, {'label': 'lb2', 'Value': 2, 'Timestamp': '2020-09-01T09:31:30Z'}]}}}, 'Priority': 1, 'Time': '2020-09-01T09:37:17.8509538+00:00'}
# extract "Value" from "Data" array where "label" is "lb1"
# json_path-> $.Payload.Result.Vid.Data[?(@.label=='lb1')].Value
Get single object
    Create Session    getlistsession    ${baseUrl}    
    ${response}=    GET On Session    getlistsession    /objects/7
    Should Be Equal As Integers    ${response.status_code}    200
    Log To Console    ${response.content}
    
    ${json}    Set Variable    ${response.json()}    # returns a dictionary

    # ${jsondict}=    Evaluate    json.loads(${json})    # works when json is in form of string, since here it's already a dictionary, it fails.  json.loads(data_JSON) creates a new dictionary with the key-value pairs of the JSON string and it returns this new dictionary.
    
    #extract and validate values- # 1
    Should Be Equal    ${json}[name]    Apple MacBook Pro 16
    Should Be Equal    ${json}[data][CPU model]    Intel Core i9    # data is again a dictionary -- subdictionary inside main response json dictionary
    Log To Console    price of object 7: ${json}[data][price]    # price of object 7: 1849.99
    # 2
    ${year}=    Get Value From Json    ${json}    $..data.year    # year: [2019] --returning as a list, if there were multiple json objects with year attribute, it would return the list of years for all json objects
    Log To Console    year: ${year}
    # ${harddisk}=    Get Value From Json    ${json}    $..data.Hard disk size    # cannot parse spaces in the atrribute (Hard disk size) --use dictionary ways to extract- ${json}[data][Hard disk size]
    # 3
    ${harddisk}=    Get From Dictionary    ${json}[data]    Hard disk size    default=None
    Log To Console    harddisk: ${harddisk}    # harddisk: 1 TB

Get List of Objects using id
    Create Session    getlistsession    ${baseUrl}    
    ${endpoint}=    Set Variable    /objects?id=3&id=5&id=10
    ${response}=    GET On Session    getlistsession    ${endpoint}
    Should Be Equal As Integers    ${response.status_code}    200
    Log To Console    ${response.content}

    ${body}=    Convert To String    ${response.content}
    Should Contain    ${body}    "id":"10"
    Should Contain    ${body}    Samsung Galaxy Z


Add Object POST Request 

    Create Session    postsession    ${baseUrl}   
    ${data}    Create Dictionary    year=2020     price=1749.99     CPU model=Intel Core i9    Hard disk size=1 TB 
    ${newobject}    Create Dictionary    name=Redmi    data=${data} 
    ${header}=    Create Dictionary    content-type=application/json 
    ${response}    Post Request    postsession    /objects     data=${newobject}       headers=${header} 
    Log To Console    ${response.status_code} 
    Log To Console    ${response.content} 
    Should Be Equal    ${response.json()}[name]    Redmi
    ${id}    Get Value From Json    ${response.json()}    $.id
    Log To Console    id of new object is ${id}
    Should Contain    ${response.json()}[data]    "price":1749.99 