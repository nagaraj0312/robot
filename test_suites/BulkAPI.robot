*** Settings ***
Resource    ../utilities/parser_utilities/test_bed_parser_bulk.robot


*** Test Cases ***                   
Bulk API Request
                    [Setup]    Connect to DB and Update the Table
                    [Tags]    BulkAPI
                    Bulk API Request