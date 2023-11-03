*** Settings ***

Library        SeleniumLibrary
Library        OperatingSystem
Library        FakerLibrary  

Resource        ../bases/base.robot

*** Variables ***

${candidato}=                Get WebElement                     xpath://span[contains(.,'Candidato')]


*** Keywords ***

Clica em Acessar

    Close Tela Cookies
    Wait Until Element Is Visible             xpath://a[contains(@class,'css-ng3gx5 e19afand0')]      
    Click Element                             xpath://a[contains(@class,'css-ng3gx5 e19afand0')]
    Wait Until Element Is Visible             xpath://h1[@data-tn-section='auth-page-header--enter-email'][contains(.,'Tudo pronto para dar o próximo passo?')]
    ${subtitulo}=            Get Text         xpath://h1[@data-tn-section='auth-page-header--enter-email'][contains(.,'Tudo pronto para dar o próximo passo?')]
    Should Be Equal          ${subtitulo}     Tudo pronto para dar o próximo passo?
    
Preenche Dados do Login
    
    Clica em Acessar

    Click Element                               xpath://input[contains(@name,'__email')]
    ${Email}          FakerLibrary.Email
    Input Text                                  xpath://input[contains(@name,'__email')]               ${Email} 
            
    Click Element                               xpath://button[@type='submit']
   
    Sleep    5

    IF  $candidato == $True
        Mouse Over                                  xpath://span[contains(.,'Candidato')]
        Click Element                               xpath://span[contains(.,'Candidato')]
        
    ELSE   
        Wait Until Element Is Visible               xpath://input[contains(@name,'__password')]
        Click Element                               xpath://input[contains(@name,'__password')]
        ${Senha}          FakerLibrary.Password
        Input Text                                  xpath://input[contains(@name,'__password')]          ${Senha}  
        Close Verification
        Click Element                               xpath://button[@type='submit'] 
                                           
    END 
         

    Wait Until Element Is Visible                                        xpath://a[@href='/promo/resume?from=hpResumePromo'][contains(.,'Cadastre seu currículo - grátis!')]    
    ${mensagem}=                        Get Text                         xpath://a[@href='/promo/resume?from=hpResumePromo'][contains(.,'Cadastre seu currículo - grátis!')]
    Should Be Equal                     ${mensagem.text}                 Cadastre seu currículo - grátis!


Preenche Login com Email Inválido

    Clica em Acessar

    Click Element                             xpath://input[@id='ifl-InputFormField-3']
    Input Text                                xpath://input[@id='ifl-InputFormField-3']                 teste
    Click Element                             xpath://button[@type='submit']
    
    Wait Until Element Is Visible                                                   xpath://div[@class='css-mllman e1wnkr790'][contains(.,'Erro: endereço de e-mail inválido')]
    ${email_invalido}=                        Get WebElement                        xpath://div[@class='css-mllman e1wnkr790'][contains(.,'Erro: endereço de e-mail inválido')]
    Should Be Equal                           ${email_invalido.text}                Erro: endereço de e-mail inválido                     
    
Preenche Login com Senha Incorreta

    Clica em Acessar
    
    Click Element                             xpath://input[@id='ifl-InputFormField-3']
    Input Text                                xpath://input[@id='ifl-InputFormField-3']                  rubel373@uorak.com         
    Click Element                             xpath://button[@type='submit']
    Close Verification
    Sleep    2
    Click Element                             xpath://button[@type='submit']
    Wait and Click on Element                 xpath://input[contains(@name,'__password')]           
    Input Text                                xpath://input[contains(@name,'__password')]                Teste123- 
    Click Element                             xpath://button[@type='submit'][contains(.,'Acessar')]

    ${senha_incorreta}=                   Get WebElement                         xpath://div[@class='css-mllman e1wnkr790'][contains(.,'Erro: senha incorreta')]
    Should Be Equal                       ${senha_incorreta.text}                Erro: senha incorreta

Loga com Usuario Valido

    Clica em Acessar

    Click Element                             xpath://input[@id='ifl-InputFormField-3']
    Input Text                                xpath://input[@id='ifl-InputFormField-3']                  rubel373@uorak.com 
    Click Element                             xpath://button[@type='submit']                                

    TRY        
        Close Verification
        Click Element                         xpath://button[@type='submit'] 
        Wait and Click on Element             xpath://input[contains(@name,'__password')]           
        Input Text                            xpath://input[contains(@name,'__password')]                 Teste123+        
        Click Element                         xpath://button[@type='submit']   
    EXCEPT
       Wait and Click on Element             xpath://input[contains(@name,'__password')]           
       Input Text                            xpath://input[contains(@name,'__password')]                  Teste123+        
       Click Element                         xpath://button[@type='submit'] nao foi exibido
        
    END

Valida Email Usuario

    Sleep            2
    Mouse Up                                xpath://button[@id='AccountMenu']//*[name()='svg']
    Click Element                           xpath://button[@id='AccountMenu']//*[name()='svg']
    Click Element                           xpath://span[contains(.,'Verifique sua conta')]

    Click Element                           xpath://span[@class='css-smaipe e1wnkr790'][contains(.,'rubel373@uorak.com.br')]
    ${email_do_usuario}=                    Get WebElement                            xpath://span[@class='css-smaipe e1wnkr790'][contains(.,'rubel373@uorak.com.br')]
    Should Be Equal                         ${email_do_usuario.text}                  rubel373@uorak.com 

