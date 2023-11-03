*** Settings ***

Resource    ../bases/base.robot      
Resource    ../page/linkedin_page.robot

Test Setup        Acessa linkedin
Test Teardown     Fechar navegador

*** Test Cases ***

Cadastrar Nova Conta

    Clica em Cadastre-se agora
    Preenche Dados do Login

Cadastrar Nova Conta com Dados Incorretos

    Preenche Login com Email Incorreto
    Preenche Login com Senha Incorreta

Acessar Conta Cadastrada

    Loga Conta Usuario Valido
    Valida Nome Usuario
    
    