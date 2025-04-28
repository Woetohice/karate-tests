Feature: Users API Tests

  Background:
    * url baseUrl
    * headers headers

  Scenario: Get App Version
    Given path 'version'
    When method get
    Then status 200
