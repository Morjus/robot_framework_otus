*** Settings ***
Library    SeleniumLibrary

Resource    ../Resources/Common.robot

Documentation    Это пример теста написанного с помощью Robot Framework

Test Setup    Open Browser    NONE    ${BROWSER}
Test Teardown    Close Browser


*** Variables ***
# C переменными уже можно работать через опцию -v
${BROWSER}    chrome


*** Test Cases ***
Check Login
    Admin Page open and login    ${PAGE}    ${LOGIN_SELECTOR}     ${PASSW_SELECTOR}
    ${TITLE}    Get Title
    Should Contain      ${TITLE}    Dashboard
    END