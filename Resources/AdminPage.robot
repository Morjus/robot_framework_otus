*** Settings ***
Library    SeleniumLibrary
Library    DatabaseLibrary

*** Variables ***
${LOGIN_FORM}  css=form
${USERNAME_INPUT}  css=#input-username
${PASSWORD_INPUT}  css=#input-password
${SUBMIT_BUTTON}  css=button[type='submit']
${MENU_CATALOG}  css=#menu-catalog
${CATALOG_ITEMS}  css=#collapse1 > li > a
${FILTER_BUTTON}    css=button#button-filter
${CHANGE_PRODUCT_BUTTON}    xpath=//a[@data-original-title='Edit']
${PRODUCT_NAME_FIELD}    css=#input-name
${PRODUCT_NAME_INPUT}    css=#input-name1
${SAVE_PRODUCT}  xpath=//button[@data-original-title='Save']
${ADD_NEW_PRODUCT}  xpath=//a[@data-original-title='Add New']
${DELETE_PRODUCT}  xpath=//button[@data-original-title='Delete']
${PRODUCT_DESCRIPTION_DB}  oc_product_description


*** Keywords ***
Login With
    [Arguments]    ${user_data}
    Wait Until Element Is Visible  ${LOGIN_FORM}
    Input Text  ${USERNAME_INPUT}  ${user_data}[0]
    Input Text  ${PASSWORD_INPUT}  ${user_data}[1]
    Submit Form  ${LOGIN_FORM}
    Wait Until Page Contains Element    xpath=//h1[contains(text(), 'Dashboard')]

Open Catalog Products
    Click Element  ${MENU_CATALOG}
    ${catalog_items} =  Get Webelements  ${CATALOG_ITEMS}
    BuiltIn.Wait Until Keyword Succeeds  3 sec  1 sec  Click Element  ${catalog_items}[1]
    Wait Until Page Contains Element  xpath=//h1[text()='Products']

Search This Product
    [Arguments]    ${product_name}
    Input Text    ${PRODUCT_NAME_FIELD}    ${product_name}
    Click Element    ${FILTER_BUTTON}
    Wait Until Page Contains Element    xpath=//td[contains(text(), '${product_name}')]


Edit First Product
    [Arguments]    ${product_name}
    Click Link    ${CHANGE_PRODUCT_BUTTON}
    Wait Until Page Contains Element    xpath=//label[contains(text(), 'Product Name')]

Replace Name To This
    [Arguments]    ${new_name}
    Clear Element Text    ${PRODUCT_NAME_INPUT}
    Input Text    ${PRODUCT_NAME_INPUT}   ${new_name}


Change Name Of This Product
    [Arguments]    ${old_name}    ${new_name}
    Search This Product    ${old_name}
    Edit First Product    ${old_name}
    Replace Name To This    ${new_name}
    Click Button    ${SAVE_PRODUCT}


Check Product In Database
    [Arguments]    ${value}
    Check If Exists In Database  select name from bitnami_opencart.${PRODUCT_DESCRIPTION_DB} where name = '${value}'


Check Product Not In Database
    [Arguments]  ${product_name}
    Check If Not Exists In Database  select name from bitnami_opencart.${PRODUCT_DESCRIPTION_DB} where name = '${product_name}'
