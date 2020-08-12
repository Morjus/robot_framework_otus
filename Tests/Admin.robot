*** Settings ***
Library    SeleniumLibrary

Resource    ../Resources/Common.robot

Documentation    Тесты для страницы администратора opencart

Test Setup    Open Browser    NONE    ${BROWSER}    options=add_argument("--ignore-certificate-errors")
Test Teardown    Close Browser


*** Variables ***
${BROWSER}    chrome


*** Test Cases ***
Check Login
    Admin Page open and login    ${PAGE}    ${LOGIN_SELECTOR}     ${PASSW_SELECTOR}    ${BUTTON_SELECTOR}    Dashboard

Change product
    Admin Page open and login    ${PAGE}    ${LOGIN_SELECTOR}     ${PASSW_SELECTOR}    ${BUTTON_SELECTOR}    Dashboard
    Go to page    Products
    Change product

Delete random product
    Admin Page open and login    ${PAGE}    ${LOGIN_SELECTOR}     ${PASSW_SELECTOR}    ${BUTTON_SELECTOR}    Dashboard
    Go to page    Products
    Delete product

Add recurring profiles
    Admin Page open and login    ${PAGE}    ${LOGIN_SELECTOR}     ${PASSW_SELECTOR}    ${BUTTON_SELECTOR}    Dashboard
    Go to profiles    Recurring Profiles
    Add new profile    ${NAME_SELECTOR}    ${NAME}

Add information
    Admin Page open and login    ${PAGE}    ${LOGIN_SELECTOR}     ${PASSW_SELECTOR}    ${BUTTON_SELECTOR}    Dashboard
    Go to information    Information
    Add new information    ${INFO_TITLE}    ${META}    ${DEFAULT_VAL}