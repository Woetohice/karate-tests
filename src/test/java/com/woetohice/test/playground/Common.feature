@ignore
Feature: Common resources for all endpoint tests

Background:
    * def responseSchema = read('classpath:playground/products/schema/product.json')
    * def defaultHeader =
    """
    {
        'Content-Type': 'application/json',
        'Authorization': #(accessToken)
    }
    """
    * def fakerType = Java.type('com.github.javafaker.Faker')
    * def faker = new fakerType()
Scenario:
