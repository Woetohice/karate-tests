@ignore
Feature: Retrieve Product by Id
    * def bg = callonce read('classpath:playground/products/Background.feature')
    * def baseUrl = typeof baseUrl = 'undefined' ? bg.common.baseUrl : baseUrl
    * def accessToken = typeof accessToken = 'undefined' ? bg.common.accessToken : accessToken
    * def xApiKey = typeof xApiKey = 'undefined' ? bg.common.xApiKey : xApiKey
    * def productId = typeof productId = 'undefined' ? '43900' : productId
    * def expectedStatus = typeof expectedStatus = 'undefined' ? 200 : expectedStatus

@ignore
Scenario:
    Given configure headers =
    """
    {
      Content-Type: "application/json",
      Accept: "application/json",
      x-api-key: '#(xApiKey)',
      Authorization: '#(accessToken)'
    }
    """
    And url baseUrl
    And path 'products/' + productId
    And method GET
    Then match responseStatus == expectedStatus
    
