*** Settings ***
Library    OperatingSystem
Library    String
Library    RequestsLibrary
Library    Collections
Library    REST
Library    DatabaseLibrary
Resource    ../misc_utilities/misc_utilties.robot


*** Variables ***
${api_url}        http://pivault.greythr.gr8hr.biz/pivault/v1/identities/
${staging_url}    http://pivault.greythr.gr8hr.biz/pivault/v1/identities/stage/
${bulkapi_url}    http://pivault.greythr.gr8hr.biz/pivault/v1/identities/bulk


*** Keywords ***
Get Header Details
    Set Headers    headers={"Authorization":"token my-test-token","X-USER":"1","X-TENANT-ID":"masterdemotest.gtmail.gr8hr.biz"}

Single API request without Mask Format
    ${test_bed_file}=   Get Test Bed File Post Request Withoutmask
    Get Header Details    
    REST.Post      ${api_url}    ${test_bed_file}       	
    Output Schema    response body    append=False    sort_keys=False
    Output           $..guid
    Integer    response status               200
    Object     response body    required=["documentNo", "employee","expiryDate","idType","ifscCode","nameAsPerDoc","verified","verifiedDate"]  
    Integer    response status               200
    Integer    response body idType          6
    Integer    response body employee        17   
    String     response body documentNo      KA05 255455
    String     response body nameAsPerDoc    Shruthi Shetty
    String     response body ifscCode        
    String     response body expiryDate      2022-01-01
    Boolean    response body verified        true
    String     response body verifiedDate    2019-02-25 
    ${identity_id}=    Output           $..guid
    ${Req}  Catenate    SEPARATOR=    ${api_url}     ${identity_id}
    REST.Get    ${Req}
    Output Schema   response body
    Object     response body    required=["documentNo", "employee","expiryDate","idType","ifscCode","nameAsPerDoc","verified","verifiedDate"]  
    Integer    response status               200
    Integer    response body idType          6
    Integer    response body employee        17   
    String     response body documentNo      KA05 255455
    String     response body nameAsPerDoc    Shruthi Shetty
    String     response body ifscCode        
    String     response body expiryDate      2022-01-01
    Boolean    response body verified        true
    String     response body verifiedDate    2019-02-25
    ${test_bed_file}=    Get Test Bed File Put Request Withoutmask
    Get Header Details
    REST.Put      ${Req}   	${test_bed_file}
    Output Schema   response body
    Object     response body    required=["documentNo", "employee","expiryDate","idType","ifscCode","nameAsPerDoc","verified","verifiedDate"]  
    Integer    response status               200
    Integer    response body idType          6
    Integer    response body employee        17   
    String     response body documentNo      KA01 7333
    String     response body nameAsPerDoc    Shruthi Shetty
    String     response body ifscCode        
    String     response body expiryDate      2023-01-01
    Boolean    response body verified        true
    String     response body verifiedDate    2019-02-25
                                                                     
Single API request with Mask Format
    ${test_bed_file}=   Get Test Bed File Post Request Withmask
    Get Header Details    
    REST.Post      ${api_url}    ${test_bed_file}       	
    Output Schema    response body    append=False    sort_keys=False
    Output           $..guid
    Integer    response status               200
    Object     response body    required=["documentNo", "employee","expiryDate","idType","ifscCode","nameAsPerDoc","verified","verifiedDate"]  
    Integer    response status               200
    Integer    response body idType          5
    Integer    response body employee        17   
    String     response body documentNo      N******
    String     response body nameAsPerDoc    Shruthi Shetty
    String     response body ifscCode        
    String     response body expiryDate      2022-01-01
    Boolean    response body verified        true
    String     response body verifiedDate    2019-02-25
    ${identity_id}=    Output           $..guid
    ${Req}  Catenate    SEPARATOR=    ${api_url}     ${identity_id}
    REST.Get    ${Req}
    Output Schema   response body
    Integer    response status               200
    Integer    response body idType          5
    Integer    response body employee        17   
    String     response body documentNo      N******
    String     response body nameAsPerDoc    Shruthi Shetty
    String     response body ifscCode        
    String     response body expiryDate      2022-01-01
    Boolean    response body verified        true
    String     response body verifiedDate    2019-02-25
    ${test_bed_file}=    Get Test Bed File Put Request Withmask
    Get Header Details
    REST.Put      ${Req}   	${test_bed_file}
    REST.Put      ${Req}   	${test_bed_file}
    Output Schema   response body
    Object     response body    required=["documentNo", "employee","expiryDate","idType","ifscCode","nameAsPerDoc","verified","verifiedDate"]  
    Integer    response status               200
    Integer    response body idType          5
    Integer    response body employee        17   
    String     response body documentNo      J******
    String     response body nameAsPerDoc    Shruthi Shetty Passport
    String     response body ifscCode        
    String     response body expiryDate      2030-01-01
    Boolean    response body verified        true
    String     response body verifiedDate    2019-02-25
    
Single API Request without Mask Format Staging Approve
    ${test_bed_file}=   Get Test Bed File Post Request Withoutmask Staging Approve
    Get Header Details    
    REST.Post      ${staging_url}    ${test_bed_file}       	
    Output Schema    response body
    Output    $..stageRef
    ${reveal_id}=    Output    $..stageRef
    ${Req_accept}  Catenate    SEPARATOR=    ${staging_url}     ${reveal_id}    /accept
    REST.Post    ${Req_accept}
    Output Schema    response body
    Integer    response status               200
    Integer    response body idType          7
    Integer    response body employee        16   
    String     response body documentNo      REJ557847
    String     response body nameAsPerDoc    Rami Reddy
    String     response body ifscCode        
    String     response body expiryDate      2024-01-01
    Boolean    response body verified        true
    String     response body verifiedDate    2019-01-25
    String     response body status          accepted     
    
Single API Request without Mask Format Staging Reject
    ${test_bed_file}=   Get Test Bed File Post Request Withoutmask Staging Reject
    Get Header Details    
    REST.Post      ${staging_url}    ${test_bed_file}       	
    Output Schema    response body    append=False    sort_keys=False
    Output    $..stageRef
    ${reveal_id}=    Output    $..stageRef
    ${Req_reject}  Catenate    SEPARATOR=    ${staging_url}     ${reveal_id}
    REST.Post    ${Req_reject}/reject
    Output Schema    response body
    Output Schema    response body
    Integer    response status               200
    Integer    response body idType          1
    Integer    response body employee        16   
    String     response body documentNo      NPR44578
    String     response body nameAsPerDoc    Rami Reddy
    String     response body ifscCode        
    String     response body expiryDate      2022-01-01
    Boolean    response body verified        true
    String     response body verifiedDate    2019-01-25
    String     response body status          rejected
    
Single API Request with Mask Format Staging Approve
     ${test_bed_file}=   Get Test Bed File Post Request Withmask Staging Approve
    Get Header Details    
    REST.Post      ${staging_url}    ${test_bed_file}       	
    Output Schema    response body
    Output    $..stageRef
    ${reveal_id}=    Output    $..stageRef
    ${Req_accept}  Catenate    SEPARATOR=    ${staging_url}     ${reveal_id}    /accept
    REST.Post    ${Req_accept}
    Output Schema    response body
    Integer    response status               200
    Integer    response body idType          3
    Integer    response body employee        71   
    String     response body documentNo      ACTPH****M
    String     response body nameAsPerDoc    Nagaraj
    String     response body ifscCode        
    String     response body expiryDate      2025-01-01
    Boolean    response body verified        true
    String     response body verifiedDate    2019-03-07
    String     response body status          accepted
    
Single API Request with Mask Format Staging Reject
    ${test_bed_file}=   Get Test Bed File Post Request Withmask Staging Reject
    Get Header Details    
    REST.Post      ${staging_url}    ${test_bed_file}       	
    Output Schema    response body    append=False    sort_keys=False
    Output    $..stageRef
    ${reveal_id}=    Output    $..stageRef
    ${Req_reject}  Catenate    SEPARATOR=    ${staging_url}     ${reveal_id}
    REST.Post    ${Req_reject}/reject
    Output Schema    response body
    Output Schema    response body
    Integer    response status               200
    Integer    response body idType          3
    Integer    response body employee        99   
    String     response body documentNo      ACTPH****M
    String     response body nameAsPerDoc    Nagaraj
    String     response body ifscCode        
    String     response body expiryDate      2025-01-01
    Boolean    response body verified        true
    String     response body verifiedDate    2019-03-07
    String     response body status          rejected
    
Single API Reveal Staging
    ${test_bed_file}=   Get Test Bed File Staging Reveal Request
    Get Header Details    
    REST.Post      ${staging_url}    ${test_bed_file}
    Output    $..stageRef
    ${reveal_id}=    Output    $..stageRef
    ${Req}  Catenate    SEPARATOR=    ${staging_url}     ${reveal_id}    /reveal
    REST.Get    ${Req}
    Output
    Integer     response status               200
    
Bulk API Request
    ${test_bed_file}=   Get Test Bed File Bulk Request
    Get Header Details    
    REST.Post      ${bulkapi_url}    ${test_bed_file}
    Output               	                                   
   
Get Test Bed File Post Request Withoutmask
    ${home_dir}=    Get Home Dir
    ${test_bed_file}=    Get File    ${home_dir}//config//api_post_withoutmask.json
    [Return]    ${test_bed_file}
   
Get Test Bed File Put Request Withoutmask
    ${home_dir}=    Get Home Dir
    ${test_bed_file}=    Get File    ${home_dir}//config//api_put_withoutmask.json
    [Return]    ${test_bed_file}
    
    
Get Test Bed File Post Request Withmask
    ${home_dir}=    Get Home Dir
    ${test_bed_file}=    Get File    ${home_dir}//config//api_post_withmask.json
    [Return]    ${test_bed_file}
   
Get Test Bed File Put Request Withmask
    ${home_dir}=    Get Home Dir
    ${test_bed_file}=    Get File    ${home_dir}//config//api_put_withmask.json
    [Return]    ${test_bed_file}
    
Get Test Bed File Post Request Withoutmask Staging Approve
    ${home_dir}=    Get Home Dir
    ${test_bed_file}=    Get File    ${home_dir}//config//api_post_withoutmask_staging_approve.json
    [Return]    ${test_bed_file}
    
Get Test Bed File Post Request Withoutmask Staging Reject
    ${home_dir}=    Get Home Dir
    ${test_bed_file}=    Get File    ${home_dir}//config//api_post_withoutmask_staging_reject.json
    [Return]    ${test_bed_file}
    
Get Test Bed File Post Request Withmask Staging Approve
    ${home_dir}=    Get Home Dir
    ${test_bed_file}=    Get File    ${home_dir}//config//api_post_withmask_staging_approve.json
    [Return]    ${test_bed_file}
    
Get Test Bed File Post Request Withmask Staging Reject
    ${home_dir}=    Get Home Dir
    ${test_bed_file}=    Get File    ${home_dir}//config//api_post_withmask_staging_reject.json
    [Return]    ${test_bed_file}
    
Get Test Bed File Staging Reveal Request
    ${home_dir}=    Get Home Dir
    ${test_bed_file}=    Get File    ${home_dir}//config//api_post_staging_reveal.json
    [Return]    ${test_bed_file}
    
Get Test Bed File Bulk Request
    ${home_dir}=    Get Home Dir
    ${test_bed_file}=    Get File    ${home_dir}//config//api_post_bulk.json
    [Return]    ${test_bed_file}