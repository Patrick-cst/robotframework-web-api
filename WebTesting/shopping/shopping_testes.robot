*** Settings ***

Documentation    Esse suite testa o site da amazon
Resource         shopping_resources.robot


*** Test Cases ***

Caso de Teste 01 - Acesso ao menu "Eletrônicos"
    [Documentation]    Esse teste verifica o menu de eletronicos da americanas
    [Tags]    menus
    Entrar no site do shopping
    Realizar login
    adicionar no carrinho todos os produtos Sauce
    