*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${ACCOUNT_LINK}    xpath=//a[@title="My Account"]
${LOGIN_LINK}    xpath=//a[contains(text(), 'Login')]
${EMAIL_INPUT}    css=#input-email
${PASSWORD_INPUT}    css=#input-password
${LOGIN_BUTTON}    css=input[type='submit']


*** Keywords ***
Open Login Page
    Click Link    ${ACCOUNT_LINK}
    Click Link    ${LOGIN_LINK}
    Wait Until Page Contains Element    xpath=//h2[contains(text(), 'Returning Customer')]

Login User With
    [Arguments]    ${user_data}
    Input Text  ${EMAIL_INPUT}  ${user_data}[0]
    Input Text  ${PASSWORD_INPUT}  ${user_data}[1]
    Click Element  ${LOGIN_BUTTON}
    Wait Until Page Contains Element    xpath=//h2[contains(text(), 'My Orders')]


