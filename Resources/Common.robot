*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Login page
${PAGE}    localhost
${LOGIN_SELECTOR}    css=#input-username
${PASSW_SELECTOR}    css=#input-password
${BUTTON_SELECTOR}   css=.btn.btn-primary

# Information Page
${INFO_TITLE}    css=#input-title1
${META}    css=#input-meta-title1
${DEFAULT_VAL}    Information for new customers

# Profiles
${NAME_SELECTOR}    css=#form-recurring div.form-group.required div div input
${NAME}    John Doe

*** Keywords ***

Admin Page open and login
    [Arguments]   ${PAGE}    ${LOGIN_SELECTOR}     ${PASSW_SELECTOR}    ${BUTTON_SELECTOR}    ${REQUEST}
    Go To    http://${PAGE}/admin
    Input Text    ${LOGIN_SELECTOR}    user
    Input Text    ${PASSW_SELECTOR}     bitnami1
    Press Keys    ${BUTTON_SELECTOR}    ENTER
    Wait Until Keyword Succeeds    3 sec    1 sec    Verify Page Title Contains    ${REQUEST}

Verify Page Title Contains
    [Arguments]    ${VALUE}
    ${TITLE}    Get Title
    Should Contain      ${TITLE}    ${VALUE}

Go to product page
    [Arguments]    ${REQUEST}
    Click Element    css=#menu-catalog a
    Wait Until Element Is Enabled    //*[@id="collapse1"]/li[2]/a    3 sec
    Click Link    //*[@id="collapse1"]/li[2]/a
    Wait Until Keyword Succeeds    3 sec    1 sec    Verify Page Title Contains    ${REQUEST}

Change product
    Set Browser Implicit Wait    7 sec
    Click Link    //*[@id="form-product"]/div/table/tbody/tr[5]/td[8]/a
    Click Button    css=#content > div.page-header > div > div > button
    Wait Until Element Contains    //*[@id="content"]/div[2]/div[1]    Success: You have modified products!

Delete product
    Set Browser Implicit Wait    7 sec
    Select Checkbox    //*[@id="form-product"]/div/table/tbody/tr[16]/td[1]/input
    Click Button    //*[@id="content"]/div[1]/div/div/button[3]
    Handle Alert    ACCEPT
    Wait Until Element Contains    css=.alert.alert-success.alert-dismissible    Success: You have modified products!


Go to profiles
    [Arguments]    ${REQUEST}
    Click Element    css=#menu-catalog a
    Set Browser Implicit Wait    7 sec
    Click Link    //*[@id="collapse1"]/li[3]/a
    Wait Until Keyword Succeeds    3 sec    1 sec    Verify Page Title Contains    ${REQUEST}

Go to information
    [Arguments]    ${REQUEST}
    Click Element    css=#menu-catalog a
    Set Browser Implicit Wait    7 sec
    Click Link    //*[@id="collapse1"]/li[10]/a
    Wait Until Keyword Succeeds    3 sec    1 sec    Verify Page Title Contains    ${REQUEST}

Add new profile
    [Arguments]    ${NAME_SELECTOR}    ${NAME}
    Set Browser Implicit Wait    7 sec
    Click Link    //*[@id="content"]/div[1]/div/div/a
    Input Text    ${NAME_SELECTOR}     ${NAME}
    Click Button    //*[@id="content"]/div[1]/div/div/button
    Wait Until Element Contains    css=#content div.container-fluid div.alert.alert-success.alert-dismissible    Success: You have modified recurring profiles!

Add new information
    [Arguments]    ${INFO_TITLE}    ${META}    ${DEFAULT_VAL}
    Set Browser Implicit Wait    7 sec
    Click Link    //*[@id="content"]/div[1]/div/div/a
    Input Text    ${INFO_TITLE}     ${DEFAULT_VAL}
    Execute JavaScript    document.querySelector("#input-description1"). innerHTML = "<p>${DEFAULT_VAL}</p>";
    Execute JavaScript    document.querySelector("#language1 div:nth-child(2) div div div.note-editing-area div.note-editable.panel-body p"). innerHTML = "${DEFAULT_VAL} ";
    Input Text    ${META}     ${DEFAULT_VAL}
    Click Button    //*[@id="content"]/div[1]/div/div/button
    Wait Until Element Contains    css=#content div.container-fluid div.alert.alert-success.alert-dismissible    Success: You have modified information!

