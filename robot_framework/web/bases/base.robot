*** Settings ***

Library        SeleniumLibrary
Library        OperatingSystem
Library        Dialogs
Library        FakerLibrary
         

*** Variables ***

${url_linkedin}       https://www.linkedin.com/home  
${url_indeed}         https://br.indeed.com/


*** Keywords ***
Acessa linkedin
    
    Open Browser        ${url_linkedin}          browser=chrome    
    Maximize Browser Window

Acessa Indeed

    Open Browser           ${url_indeed}          browser=chrome
    Maximize Browser Window 
    

Wait and Click on Element
    [Arguments]        ${locator}
    
    Wait Until Element Is Enabled        ${locator}            5
    FOR    ${CURRENT_VALUE_COUNT}        IN RANGE              50

        ${status}=        Run Keyword And Return Status            Click Element            ${locator}
        Exit For Loop If    '${status}' == 'True'
        
    END

Close Verification
    
    Execute Manual Step        Realize uma ação!           default_error=${False}

Close Tela Cookies

    TRY
        Mouse Over              css:div[id="onetrust-button-group"] button[id="onetrust-accept-btn-handler"] 
        Click Element           css:div[id="onetrust-button-group"] button[id="onetrust-accept-btn-handler"]
    EXCEPT    

        Log                     Não exibiu Tela!       
    END
  
Fechar navegador
    
    Close All Browsers