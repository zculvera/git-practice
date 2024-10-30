*** Settings ***
Library    OperatingSystem
Library    RobotEyes

*** Variables ***
${GREETING}    Hello, world!
# ${STATUS}   PASS
@{FRUITS}   apples    bananas    oranges
&{USER}    name=Zerah    age=30    city=Manila


*** Test Cases ***
Basic Test Case
    Log Custom Argument    Custom Argument

Check If Pass
    Run Keyword If    '${STATUS}'=='PASS'    Log    This test is passed
    ...    ELSE    Log    This test is failed

Have Setup And Cleanup
    [Setup]    log    Setting Up Test
    [Teardown]    log    Cleaning Up Test
    log    This ran during the test

Loop
    FOR    ${i}    IN RANGE    0   5
        log to console    this is iteration ${i}
    END

Test Lists
    FOR    ${fruit}    IN    @{FRUITS}
        log to console    fruit: ${fruit}
    END

Test with Dictionary
    Log    Name: ${USER['name']}
    Log    Age: ${USER['age']}    # Log age as a number
    Log    City: ${USER['city']}

Log User Info
    Log User Info With Arguments    Zerah    38    Laguna

Test Case File Operation
    create file    test_file.txt    ${GREETING}
    ${content}=    get file    test_file.txt
    remove file    test_file.txt

Test Assertions
    ${expected}=    set variable    Hello, Robot Framework!
    ${actual}=    set variable    Hello, Robot Frameworks!
    should be equal    ${actual}    ${expected}    The words are not the same

Check Error Handling
    ${result1}    ${status1}=    Run Keyword And Ignore Error    Log    This will log
    Log    ${result1}
    Log    ${status1}

    ${result2}    ${status2}=    Run Keyword And Ignore Error    Should Be Equal    1    2    Value should be equal
    Log    ${result2}
    Log    ${status2}

Test Collection
    ${length}=    Get length    ${FRUITS}
    log    ${length}

Test Condition With Loop
    [Tags]    run-this
    FOR     ${fruit}    IN    @{FRUITS}
        Run Keyword If    '${fruit}'=='bananas'    Log to console    Fruit is bananas!
        Run Keyword If    '${fruit}'!='bananas'    Log to console    Fruit is NOT bananas!
    END
    

*** Keywords ***
My Custom Keywords
    Log    ${GREETING}

Log Custom Argument
    [Arguments]    ${message}
    Log    ${message}

Log User Info With Arguments
    [Arguments]    ${name}    ${age}    ${city}
    Log    ${name}
    Log    ${age}
    Log    ${city}