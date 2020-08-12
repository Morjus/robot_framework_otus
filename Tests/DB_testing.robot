*** Settings ***
Library    SeleniumLibrary
Library    DatabaseLibrary
Library    String

Resource    ../Resources/AdminPage.robot

Suite Setup    Connect To Database    pymysql    ${DBName}  ${DBUser}  ${DBPass}  ${DBHost}  ${DBPort}
Suite Teardown    Disconnect From Database

Test Setup    Open Browser    browser=chrome    options=add_argument("--ignore-certificate-errors")
Test Teardown    Close Browser


*** Variables ***
# Database vars
${DBName}  bitnami_opencart
${DBUser}  bn_opencart
${DBPass}
${DBHost}  127.0.0.1
${DBPort}  3306
@{OPENCART_ADMIN} =  user  bitnami1
${BASE_URL}  localhost
${TEST_PRODUCT_NAME}  TestProduct
${PRODUCT_FOR_TEST}    Canon EOS 5D


*** Test Cases ***

Change Random Product from Catalog With Db Validation
    [Documentation]  Change product name in catalog with ui and validate changes in database. Also change name back.
    [Tags]  DB  ChangeProduct

    Go To  http://${BASE_URL}/admin/
    Maximize Browser Window
    Login With    ${OPENCART_ADMIN}
    Open Catalog Products
    ${NEW_NAME_FOR_TEST} =    String.Generate Random String  10  [LETTERS]
    Check Product Not In Database    ${NEW_NAME_FOR_TEST}
    Check Product In Database    ${PRODUCT_FOR_TEST}
    Change Name Of This Product    ${PRODUCT_FOR_TEST}    ${NEW_NAME_FOR_TEST}
    Wait Until Keyword Succeeds    3 sec    1 sec    Check Product In Database    ${NEW_NAME_FOR_TEST}
    # Rename product back
    Change Name Of This Product    ${NEW_NAME_FOR_TEST}    ${PRODUCT_FOR_TEST}
    Wait Until Keyword Succeeds    3 sec    1 sec    Check Product In Database    ${PRODUCT_FOR_TEST}
