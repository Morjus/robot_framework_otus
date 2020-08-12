*** Settings ***
Library    SeleniumLibrary

Resource    ../Resources/AdminPage.robot
Resource    ../Resources/CustomerPage.robot

Suite Setup    Open Browser    browser=chrome    options=add_argument("--ignore-certificate-errors")
Suite Teardown    Close Browser


*** Variables ***
@{OPENCART_ADMIN} =  user  bitnami1
@{OPENCART_USER} =  bitnami@bitnami.com  bitnami
${BASE_URL}  localhost


*** Test Cases ***
Login to admin page
    [Documentation]  Check for admin can login
    [Tags]  Login

    Go To  http://${BASE_URL}/admin/
    Login With    ${OPENCART_ADMIN}

Customer can login to account
    [Documentation]  Check for user can login
    [Tags]  Login

    Go To  http://${BASE_URL}/
    Open Login Page
    Login User With    ${OPENCART_USER}
