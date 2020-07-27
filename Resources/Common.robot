*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${PAGE}    localhost
${LOGIN_SELECTOR}    css=#input-username
${PASSW_SELECTOR}    css=#input-password

*** Keywords ***

Admin Page open and login
    [Arguments]   ${PAGE}    ${LOGIN_SELECTOR}     ${PASSW_SELECTOR}
    Go To    http://${PAGE}/admin
    Input Text    ${LOGIN_SELECTOR}    user
    Input Text    ${PASSW_SELECTOR}     bitnami1
    Press Keys    .btn.btn-primary    ENTER
    Wait Until Keyword Succeeds    3 sec    1 sec    Verify Page Title Contains     Dashboard
