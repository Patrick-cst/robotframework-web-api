*** Settings ***

Library    SeleniumLibrary


*** Variables ***

${URL}                   https://www.amazon.com.br
${MENU_ELETRONICOS}      //a[@data-csa-c-content-id='nav_cs_electronics']
${HEADER_ELETRONICOS}    //h1[text()='Eletrônicos e Tecnologia']
${CAMPO_PESQUISA}        twotabsearchtextbox
${BOTAO_PESQUISAR}       nav-search-submit-button

*** Keywords ***

Abrir o navegador
    Open Browser    browser=chrome 
    Maximize Browser Window


Fechar o navegador
    Capture Page Screenshot
    Close Browser

Acessar a home page do site Amazon.com.br
    Go To    url=${URL}
    Wait Until Element Is Visible    locator=${MENU_ELETRONICOS}
    
Entrar no menu "Eletrônicos"
    Click Element    locator=${MENU_ELETRONICOS}   

Verificar se aparece a frase "${TEXTO_HEADER_ELETRONICOS}"
    Wait Until Page Contains    text=${TEXTO_HEADER_ELETRONICOS}
    Wait Until Element Is Visible    locator=${HEADER_ELETRONICOS}

Verificar se o título da página fica "${TITULO}"
    Title Should Be    title=${TITULO}

Verificar se aparece a categoria "${NOME_CATEGORIA}"
    Element Should Be Visible    locator=//a[@aria-label="${NOME_CATEGORIA}"]

Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
    Input Text    locator=${CAMPO_PESQUISA}    text=${PRODUTO}
    

Clicar no botão de pesquisa
    Click Element    locator=${BOTAO_PESQUISAR}


Verificar o resultado da pesquisa, listando o produto "${PRODUTO_PESQUISADO}"
    Wait Until Element Is Visible    locator=//span[text()='${PRODUTO_PESQUISADO}']
    

# BDD
Dado que estou na home page da Amazon.com.br
    Acessar a home page do site Amazon.com.br
Quando acessar o menu "Eletrônicos"
    Entrar no menu "Eletrônicos"
Então o título da página deve ficar "Eletrônicos e Tecnologia | Amazon.com.br"
    Verificar se o título da página fica "Eletrônicos e Tecnologia | Amazon.com.br"
E o texto "Eletrônicos e Tecnologia" deve ser exibido na página
E a categoria "Computadores e Informática" deve ser exibida na página
    Verificar se aparece a categoria "Computadores e Informática"