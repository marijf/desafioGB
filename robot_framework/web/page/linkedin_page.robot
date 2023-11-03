*** Settings ***

Library        SeleniumLibrary
Library        OperatingSystem
Library        FakerLibrary  
Library        String

Resource       ../bases/base.robot

*** Variables ***


${nome_pais}=            Get WebElement                 css:select[name="countryCode"] option[value="br"]


*** Keywords ***

Clica em Cadastre-se agora

    Wait Until Element Is Enabled             xpath://a[@href='https://www.linkedin.com/signup?_l=pt&trk=guest_homepage-basic_nav-header-join']        2
    Click Element                             xpath://a[@href='https://www.linkedin.com/signup?_l=pt&trk=guest_homepage-basic_nav-header-join']
    Wait Until Element Is Visible             xpath://h1[@class='main__subtitle '][contains(.,'Aproveite sua vida profissional ao máximo')]
    ${subtitulo}=        Get Text             xpath://h1[contains(.,'Aproveite sua vida profissional ao máximo')]
    Should Be Equal      ${subtitulo}         Aproveite sua vida profissional ao máximo

Clica em Entrar

    Wait Until Element Is Enabled             xpath://a[contains(@href,'nav-header-signin')]
    Click Element                             xpath://a[contains(@href,'nav-header-signin')]
    ${sub_heading}=       Get Text            xpath://p[@class='header__content__subheading '][contains(.,'Acompanhe as novidades do seu mundo profissional')]
    Should Be Equal       ${sub_heading}      Acompanhe as novidades do seu mundo profissional      
   
Preenche Dados do Login

    Wait Until Element Is Enabled        xpath://input[contains(@id,'email-or-phone')]
    Click Element                        xpath://input[contains(@id,'email-or-phone')]
    ${Email}  FakerLibrary.Email
    Input Text                           xpath://input[contains(@id,'email-or-phone')]        ${Email} 
         
    Click Element                        xpath://input[contains(@id,'password')]
    ${Senha}  FakerLibrary.Password
    Input Text                           xpath://input[contains(@id,'password')]              ${Senha}    

    Wait and Click on Element            xpath://button[contains(@id,'join-form-submit')]       

    Wait and Click on Element            xpath://input[@id='first-name']
    ${Nome}  FakerLibrary.Name
    Input Text                           xpath://input[@id='first-name']                       ${Nome}

    Wait and Click on Element            xpath://input[@id='last-name']
    ${Sobrenome}  FakerLibrary.Last Name    
    Input Text                           xpath://input[@id='last-name']                        ${Sobrenome}
    
    Click Element                        xpath://button[contains(@id,'join-form-submit')]
    Sleep            6
    
    IF  $nome_pais == $True

        Wait and Click on Element                    css:div[class="input-group input-group__prepend"] input[name="phoneNumber"]                   
        ${Telefone}  FakerLibrary.Phone Number
        Input Text                                   css:div[class="input-group input-group__prepend"] input[name="phoneNumber"]                  ${Telefone}
        Click Element                                xpath://button[@class='form__submit form__submit--stretch'][contains(.,'Enviar')]
    ELSE     

        Close Verification
        Sleep    2
        Mouse Over                         css:button[data-id="toast__dismiss-btn"]
        Click Element                      css:button[data-id="toast__dismiss-btn"]
        Click Element                      xpath://button[contains(@id,'join-form-submit')]
    END 
   
Preenche Login com Email Incorreto

    Clica em Cadastre-se agora

    Wait Until Element Is Visible        xpath://input[contains(@id,'email-or-phone')]
    Click Element                        xpath://input[contains(@id,'email-or-phone')]
    Input Text                           xpath://input[contains(@id,'email-or-phone')]            ss.com   
    Click Element                        xpath://input[contains(@id,'password')]
    Input Text                           xpath://input[contains(@id,'password')]                  Teste123+  
    Wait and Click on Element            xpath://button[contains(@id,'join-form-submit')]

    ${email_incorreto}=                   Get WebElement                         xpath://p[contains(.,'Insira um e-mail ou número de celular válido.')]
    Should Be Equal                       ${email_incorreto.text}                Insira um e-mail ou número de celular válido.                     

Preenche Login com Senha Incorreta

    Wait Until Element Is Visible        xpath://input[contains(@id,'email-or-phone')]
    Click Element                        xpath://input[contains(@id,'email-or-phone')]
    Input Text                           xpath://input[contains(@id,'email-or-phone')]            xxx@xxxx.com   
    Click Element                        xpath://input[contains(@id,'password')]
    Input Text                           xpath://input[contains(@id,'password')]                  ss    
    Wait and Click on Element            xpath://button[contains(@id,'join-form-submit')]

    ${senha_incorreta}=                   Get WebElement                         xpath://p[contains(.,'A senha deve conter 6 ou mais caracteres.')]
    Should Be Equal                       ${senha_incorreta.text}                A senha deve conter 6 ou mais caracteres.

Loga Conta Usuario Valido

    Clica em Entrar

    Wait and Click on Element                 xpath://input[contains(@id,'username')]
    Input Text                                xpath://input[contains(@id,'username')]            helone5967@soebing.com

    Wait and Click on Element                 xpath://input[contains(@id,'password')]            
    Input Text                                xpath://input[contains(@id,'password')]            Helena2345+ 
 
    Click Element                             xpath://button[contains(@class,'button--floating')]
    Close Verification
    Capture Page Screenshot

Valida Nome Usuario

    Wait Until Element Is Visible                    xpath://div[@class='t-16 t-black t-bold'][contains(.,'helena dias')]
    ${nome_do_usuario}=            Get WebElement    xpath://div[@class='t-16 t-black t-bold'][contains(.,'helena dias')]
    Should Be Equal                ${nome_do_usuario.text}              helena dias 