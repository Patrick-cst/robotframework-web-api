*** Settings ***

Resource    ../resources/api_testing_ususario.resource

*** Variables ***


*** Test Cases ***

Cenario 01: Cadasdastra um novo usuario com sucesso na serverest
    Criar um novo usuario
    cadastrar o usuario criado na serverest    email=${EMAIL_TESTE}    statuscode=201
    Conferir se o usuario foi cadastrado corretamente


Cenario 02: Cadastrar usuario ja cadastrado
    Criar um novo usuario
    cadastrar o usuario criado na serverest    email=${EMAIL_TESTE}    statuscode=201
    Vou repetir o cadastro do usuario
    Verificar se a API nao permitiu o cadastro repetido

Cenario 03: Consultar os dados de um novo usuario
    Criar um novo usuario
    cadastrar o usuario criado na serverest    email=${EMAIL_TESTE}    statuscode=201
    Consultar os dados do novo usuario
    Conferir os dados retornados

Cenario 04: Realizar login com sucesso
    Criar um novo usuario
    cadastrar o usuario criado na serverest    email=${EMAIL_TESTE}    statuscode=201
    Realizar login
    Validar login com sucesso


Cenario 05: Consultar produtos
    Consultar produtos