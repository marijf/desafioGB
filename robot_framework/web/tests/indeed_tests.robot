*** Settings ***

Resource    ../bases/base.robot        
Resource    ../page/indeed_page.robot

Test Setup       Acessa Indeed
Test Teardown    Fechar navegador

*** Test Cases ***

Cadastrar Novo Usuario

    Preenche Dados do Login
    Fechar navegador

Cadastrar Novo Usuario com Email Invalido

    Preenche Login com Email Inválido

Realizar Login com Senha Incorreta

    Preenche Login com Senha Incorreta

Acessar Conta Cadastrada

    Loga com Usuario Valido
    Valida Email Usuario
