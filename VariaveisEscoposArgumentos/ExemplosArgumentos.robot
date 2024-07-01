*** Settings ***
Documentation   Exemplo de uso de variáveis como argumentos em Keywords
Library    String

*** Variable ***
&{PESSOA}       nome=May Fernandes   email=mayfernandes@exemplo.com.br   idade=20   sexo=feminino

*** Test Cases ***
Caso de teste de exemplo 01
    Uma keyword qualquer 01

Listar frutas da lista
    Criar lista

Listar dados da pessoa
    Criar um dicionario

*** Keywords ***
Uma keyword qualquer 01
    Uma subkeyword com argumentos   Bruno Silva   bruno_silva@teste.com.br
    Uma subkeyword com argumentos   ${PESSOA.nome}   ${PESSOA.email}
    ${MENSAGEM_ALERTA}   Uma subkeyword com retorno   ${PESSOA.nome}   ${PESSOA.idade}
    Log     ${MENSAGEM_ALERTA}

Uma subkeyword com argumentos
    [Arguments]     ${NOME_USUARIO}   ${EMAIL_USUARIO}
    Log             Nome Usuário: ${NOME_USUARIO}
    Log             Email: ${EMAIL_USUARIO}

Uma subkeyword com retorno
    [Arguments]     ${NOME_USUARIO}   ${IDADE_USUARIO}
    ${MENSAGEM}     Set Variable If    ${IDADE_USUARIO}<18    Não autorizado! O usuário ${NOME_USUARIO} é menor de idade!   OK!Usuário é maior de idade!
    [Return]        ${MENSAGEM}


Criar lista
    Set Test Variable    @{LISTA}    morango    banana    maça    uva

    Log    Listar todas as frutas por vetor: ${LISTA[0]}, ${LISTA[1]},${LISTA[2]}e${LISTA[3]}

    FOR    ${fruta}    IN    @{LISTA}
        Log    ${fruta}
    END

    

Criar um dicionario
    Set Test Variable    &{PESSOA}    nome=Patrick    idade=28    genero=masculino

    Log    nome:${PESSOA.nome}, idade:${PESSOA.idade}, genero:${PESSOA.genero}

    IF    '${PESSOA.nome}' == 'Patrick'     
        Log    deu bom
    ELSE
        Log    Deu ruim    
    END