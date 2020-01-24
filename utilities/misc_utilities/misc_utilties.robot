*** Settings ***
Library    BuiltIn
Library    OperatingSystem    

*** Keywords ***
Get Home Dir
    ${home_dir}=    Set Variable    ${CURDIR}/../..
    [Return]    ${home_dir}