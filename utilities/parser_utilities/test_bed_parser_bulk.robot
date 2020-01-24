*** Settings ***
Library    OperatingSystem
Library    String
Library    RequestsLibrary
Library    Collections
Library    REST
Library    DatabaseLibrary
Resource    ../misc_utilities/misc_utilties.robot

*** Variables ***
${bulkapi_url}    http://pivault.greythr.gr8hr.biz/pivault/v1/identities/bulk

*** Keywords ***
Get Header Details
    #Set Headers    headers={"Authorization":"token my-test-token","X-USER":"1","X-TENANT-ID":"demo1.esstest.gr8hr.biz"}
    Set Headers    headers={"Authorization":"token my-test-token","X-USER":"1","X-TENANT-ID":"masterdemotest.gtmail.gr8hr.biz"}

    
Bulk API Request
    ${test_bed_file}=   Get Test Bed File Bulk Request
    Get Header Details    
    REST.Post    ${bulkapi_url}    ${test_bed_file}
    Integer    response status               200
    Output     response body
    Output    $..documentNo
    ${documentNo}=    Output    $..documentNo
    Should Contain   ${documentNo}    NPR45787
    Should Contain   ${documentNo}    ********5413
    Should Contain   ${documentNo}    ACTPH****G 
    Should Contain   ${documentNo}    ********2263 
    Should Contain   ${documentNo}    J****** 
    Should Contain   ${documentNo}    KA05 201300006934 
    Should Contain   ${documentNo}    REJ0478976 
    Should Contain   ${documentNo}    RANCARD44787 
    Should Contain   ${documentNo}    PRAN5478747
    #${result}=     Set Variable   ${EMPTY}
    #FOR    ${code}    IN    @{documentNo}           
    #Log To Console    ${code}  
        # Should Match        ${rec[u'identity']['documentNo']}    NPR45787    
        # #Dictionary Should Contain Value    dictionary    value           
        # #Should Match   ${rec[u'identity'][u'documentNo']}    ********5413             
        # #Object     ${rec}    required=["documentNo", "employee","expiryDate","idType","ifscCode","nameAsPerDoc","verified","verifiedDate"]      
    #END
    # ${result}=     Set Variable   ${EMPTY}
    # FOR    ${code}   IN    @{identity_id}
        # ${result}=    Catenate    SEPARATOR=    ${result}    &id=${code}
    # END
    # ${result}=    Get Substring    ${result}    1    
    # ${Req}  Catenate    SEPARATOR=    ${bulkapi_url_get}    ${result}
    # REST.Get    ${Req}
    # Output   response body     	${CURDIR}/response_body.json 
    
Get Test Bed File Bulk Request
    ${home_dir}=    Get Home Dir
    ${test_bed_file}=    Get File    ${home_dir}//config//api_post_bulk.json
    [Return]    ${test_bed_file}
    
Connect to DB and Update the Table
     Connect To Database Using Custom Params    psycopg2    database='gtmail', user='majordomo', password='sa', host='10.200.0.74', port=10005
     Execute Sql String    set session AUTHORIZATION gt_masterdemorahul;
     Execute Sql String    update tblempidentitytype set mask_format='-####' where code='BANKACCNO'
     Execute Sql String    update tblempidentitytype set mask_format='$********####' where code='AADHAR'
     Execute Sql String    update tblempidentitytype set mask_format='#-' where code='PASSPORT'
     Execute Sql String    update tblempidentitytype set mask_format='$#####****#' where code='PAN'
     Execute Sql String    truncate table tblempidentities cascade;
     Disconnect From Database           