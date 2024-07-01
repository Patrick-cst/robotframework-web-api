*** Settings ***

Library    SeleniumLibrary


*** Variables ***

${URL}                   https://www.saucedemo.com/inventory.html
${CMP_USERNAME}          user-name
${CMP_PASSWORD}          password
${BTN_LOGIN}             login-button
${CONTADOR}              1





*** Keywords ***

Entrar no site do shopping
    Open Browser    browser=chrome 
    Maximize Browser Window
    Go To    url=${URL}
    
Realizar login
    Input Text        locator=${CMP_USERNAME}    text=standard_user
    Input Text        locator=${CMP_PASSWORD}    text=secret_sauce
    Click Element     locator=${BTN_LOGIN}

adicionar no carrinho todos os produtos Sauce
    ${CONTADOR}    Set Variable    1
    ${NOME_PRODUTO}    Get Text    locator=//div[@data-test='inventory-item'][${CONTADOR}]//div[@data-test='inventory-item-name']
    Log    ${NOME_PRODUTO}
    
    WHILE    '${NOME_PRODUTO}' Contains 'Sauce'
        Click Element    locator=(//button[text()='Add to cart'])[${CONTADOR}]
        
        ${CONTADOR}    Set Variable    ${CONTADOR + 1}
        
    END
    
