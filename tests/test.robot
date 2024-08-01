*** Settings ***
Library    RequestsLibrary

*** Variables ***
${BASE_URL}   https://restful-booker.herokuapp.com
${AUTH_ENDPOINT}    /auth
${USERNAME}    zerah622
${PASSWORD}    tooteaonly

*** Test Cases ***
Create Auth Token Should Be 200
    [Documentation]    This test case creates a POST request to obtain an authentication token.
    ${response} =    Create Auth Token
    Should Be Equal As Strings    ${response.status_code}    200
    Log    ${response.json}


*** Keywords ***
Create Auth Token
    ${request_body} =    Create Dictionary    username=${USERNAME}    password=${PASSWORD}
    ${headers} =    Create Dictionary    Content-Type=application/json
    Create Session    booker    ${BASE_URL}    headers=${headers}
    ${response} =    Post Request    booker    ${AUTH_ENDPOINT}    json=${request_body}
    [Return]    ${response}