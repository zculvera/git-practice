*** Settings ***
Library    RequestsLibrary
Library    DataDriver    file=C:\Users\Admin\OneDrive\Documents\development\git-practice\data\booking-queries.csv    file_search_strategy=None
# Resource   tests\resources\common\variables\endpoint-variables.robot
# Resource   tests\resources\common\variables\common-variables.robot
Suite Setup    Create Session    booker    ${BASE_URL}

*** Variables ***


*** Test Cases ***
Create Auth Token Should Be 200
    [Tags]    security
    [Documentation]    This test case creates a POST request to obtain an authentication token.
    ${response} =    Create Auth Token
    Should Be Equal As Strings    ${response.status_code}    200
    Log    ${response.json}

Get Booking by Firstname and Lastname
    [Template]    Get Booking
    [Arguments]    ${firstname}    ${lastname}

*** Keywords ***
Get Booking
    [Arguments]    ${firstname}    ${lastname}
    ${QUERY_PARAMS}=    Set Variable    firstname=${firstname}&lastname=${lastname}
    ${response}=    Get Request    booker    ${ENDPOINT}?${QUERY_PARAMS}
    Should Be Equal As Strings    ${response.status_code}    200
    Log    Response: ${response.text}

Create Auth Token
    ${request_body} =    Create Dictionary    username=${USERNAME}    password=${PASSWORD}
    ${headers} =    Create Dictionary    Content-Type=application/json
    Create Session    booker    ${BASE_URL}    headers=${headers}
    ${response} =    Post Request    booker    ${AUTH_ENDPOINT}    json=${request_body}
    [Return]    ${response}