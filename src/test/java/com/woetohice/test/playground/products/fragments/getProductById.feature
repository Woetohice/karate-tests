
Feature: Retrieve Product by Id
  Background:
    * def bg = callonce read('classpath:com/woetohice/test/playground/products/Background.feature')
    * def baseUrl = typeof baseUrl === 'undefined' ? bg.common.baseUrl : baseUrl
    * def defaultHeaders = typeof defaultHeaders === 'undefined' ? bg.common.defaultHeaders : defaultHeaders
    * def expectedStatus = typeof expectedStatus === 'undefined' ? 200 : expectedStatus
    * def productId = typeof productId === 'undefined' ? '43900' : productId


Scenario:
    Given configure headers = defaultHeaders
    And url baseUrl
    And path 'products/' + productId
    When method GET
    Then match responseStatus == expectedStatus
    
