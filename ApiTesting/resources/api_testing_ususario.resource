*** Settings ***

Library    RequestsLibrary
Library    String
Library    Collections

*** Keywords ***

Criar um novo usuario
    ${palavra_aleatoria}    Generate Random String    length=4    chars=[LETTERS]
    ${palavra_aleatoria}    Convert To Lower Case    ${palavra_aleatoria}
    Set Test Variable    ${EMAIL_TESTE}    ${palavra_aleatoria}@emailteste.com
    Log    ${EMAIL_TESTE}

cadastrar o usuario criado na serverest
    [Arguments]    ${email}    ${statuscode}
    ${body}     Create Dictionary    
    ...    nome=Fulano da Silva    
    ...    email=${email}   
    ...    password=1234    
    ...    administrador=true
    Criar Sessao na serverest

    ${resposta}    POST On Session
    ...        alias=ServeRest
    ...        url=/usuarios
    ...        json=${body}
    ...        expected_status=${statuscode}

    IF    ${resposta.status_code} == 201
        Set Test Variable    ${ID_USUARIO}    ${resposta.json()["_id"]}
    END
    
    Set Test Variable    ${RESPOSTA}    ${resposta.json()}

    
Criar Sessao na serverest
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json  
    Create Session    alias=ServeRest    url=https://serverest.dev    headers=${headers}
  

Conferir se o usuario foi cadastrado corretamente
    Log    ${RESPOSTA}
    Dictionary Should Contain Item    ${RESPOSTA}    message    Cadastro realizado com sucesso 
    Dictionary Should Contain Key     ${RESPOSTA}    _id   

Vou repetir o cadastro do usuario
    cadastrar o usuario criado na serverest  ${EMAIL_TESTE}    statuscode=400  

Verificar se a API nao permitiu o cadastro repetido
    Dictionary Should Contain Item     ${RESPOSTA}    message    Este email já está sendo usado    

Consultar os dados do novo usuario
    ${respostas_consulta}    GET On Session    alias=ServeRest    url=/usuarios/${ID_USUARIO}
     
    Set Test Variable    ${RESP_CONSULTA}    ${respostas_consulta.json()}

Conferir os dados retornados
    Dictionary Should Contain Item    ${RESP_CONSULTA}    nome            Fulano da Silva
    Dictionary Should Contain Item    ${RESP_CONSULTA}    email           ${EMAIL_TESTE}
    Dictionary Should Contain Item    ${RESP_CONSULTA}    password        1234
    Dictionary Should Contain Item    ${RESP_CONSULTA}    administrador   true
    Dictionary Should Contain Item    ${RESP_CONSULTA}    _id             ${ID_USUARIO}                                    
    
Realizar login   
    ${body}     Create Dictionary    
    ...    email=${EMAIL_TESTE}   
    ...    password=1234 

    ${RESPONSE}    POST On Session    alias=serverest    url=/login    json=${body}   

    Set Test Variable     ${RESPONSE_LOGIN}       ${RESPONSE.json()}

Validar login com sucesso
     Log    ${RESPONSE_LOGIN}

     Dictionary Should Contain Key    ${RESPONSE_LOGIN}    message    Login realizado com sucesso

     Set Test Variable    ${TOKEN}    ${RESPONSE_LOGIN["authorization"]}  

     Log    ${TOKEN} 


Consultar produtos
    Criar Sessao na serverest
    ${RESPONSE}    GET On Session    alias=serverest    url=/produtos

    Log    ${RESPONSE.json()}