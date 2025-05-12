Feature: Common resources for all endpoint tests

Background:
    * def fakerType = Java.type('com.github.javafaker.Faker')
    * def faker = new fakerType()
    * def baseUrl = 'http://localhost:3030'
    * def accessToken = 'your-access-token-here'
    * def xApiKey = 'your-api-key-here'
    * def defaultHeaders = 
    """
    {
      Content-Type: "application/json",
      Accept: "application/json",
      x-api-key: '#(xApiKey)',
      Authorization: '#(accessToken)'
    }
    """
Scenario: 