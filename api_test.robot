*** Settings ***
Library    RequestsLibrary

*** Variables ***
${BASE_URL}           https://reqres.in
${USER_ID}            10
${EXPECTED_EMAIL}     byron.fields@reqres.in

*** Test Cases ***
Assignment 1
    ${url}=           Set Variable        ${BASE_URL}/api/users
    ${response}=      GET                 ${url}    params=page=2

    # Assert response "total_pages" equal to 2
    Should Be Equal As Integers    2      ${response.json()}[total_pages]

    # Assert if the status code is equal to 200
    Status Should Be               200    ${response}

    # Assert if the user with id=10 has an email equal to byron.fields@reqres.in
    ${email}=    Evaluate    [user['email'] for user in ${response.json()}[data] if user['id'] == ${USER_ID}][0]
    Should Be Equal      ${email}         ${EXPECTED_EMAIL}