*** Settings ***
Documentation        Suite de testes para cadastro de usuário
Library              Browser


*** Test Cases ***
Cadastro de novo usuário com sucesso
    ${name}             Set Variable    Ana Paula
    ${email}            Set Variable    anahoog@gmail.com
    ${cpf}              Set Variable    00000014141
    ${cep}              Set Variable    04534011
    ${addressStreet}    Set Variable    Rua Joaquim Floriano
    ${addressNumber}    Set Variable    1000
    ${addressDetails}   Set Variable    apto 28
    ${addressDistrict}  Set Variable    Itaim Bibi
    ${addressCityUf}    Set Variable    São Paulo/SP
    ${cnh}              Set Variable    ${CURDIR}/toretto.jpg

    Go to Signup Page
    Fill signup form
    ...    ${name}
    ...    ${email}
    ...    ${cpf}
    ...    ${cep}
    ...    ${addressStreet}
    ...    ${addressNumber}
    ...    ${addressDetails}
    ...    ${addressDistrict}
    ...    ${addressCityUf}
    ...    ${cnh}
    Submit signup form
    Popup should be    Recebemos o seu cadastro e em breve retornaremos o contato.


*** Keywords ***
Go to Signup Page
    New Browser    chromium    headless=False
    New Page       https://walkdog.vercel.app/signup

    Wait For Elements State    form h1    visible    5
    Get Text                   form h1    equal    Faça seu cadastro


Fill signup form
    [Arguments]
    ...    ${name}
    ...    ${email}
    ...    ${cpf}
    ...    ${cep}
    ...    ${addressStreet}
    ...    ${addressNumber}
    ...    ${addressDetails}
    ...    ${addressDistrict}
    ...    ${addressCityUf}
    ...    ${cnh}

    Fill Text    css=input[name=name]     ${name}
    Fill Text    css=input[name=email]    ${email}
    Fill Text    css=input[name=cpf]      ${cpf}
    Fill Text    css=input[name=cep]      ${cep}

    Click    css=input[type="button"][value$=CEP]

    Wait For Elements State    css=input[name=addressStreet]    visible    10
    Sleep     10

    Get Property    css=input[name=addressStreet]    value    equal    ${addressStreet}
    Get Property    css=input[name=addressDistrict]  value    equal    ${addressDistrict}
    Get Property    css=input[name=addressCityUf]    value    equal    ${addressCityUf}

    Fill Text    css=input[name=addressNumber]     ${addressNumber}
    Fill Text    css=input[name=addressDetails]    ${addressDetails}

    Upload File By Selector    css=input[type=file]    ${cnh}


Submit signup form
    Click    css=.button-register


Popup should be
    [Arguments]    ${message}
    Wait For Elements State    css=.swal2-html-container    visible    5
    Get Text    css=.swal2-html-container    equal    ${message}
