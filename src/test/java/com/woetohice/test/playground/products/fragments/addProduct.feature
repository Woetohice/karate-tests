@fragment @ignore
Feature: Create a Product
  Background:
  * def bg = callonce read('classpath:com/woetohice/test/playground/products/Background.feature')
  * def baseUrl = typeof baseUrl === 'undefined' ? bg.common.baseUrl : baseUrl
  * def defaultHeaders = typeof defaultHeaders === 'undefined' ? bg.common.defaultHeaders : defaultHeaders
  * def expectedStatus = typeof expectedStatus === 'undefined' ? 201 : expectedStatus

  # product Payload information
  * def name = typeof name === 'undefined' ? bg.common.faker.commerce().productName() : name
  * def type = typeof type === 'undefined' ? bg.common.faker.lorem().word() : type
  * def price = typeof price === 'undefined' ? (function() { return Number(bg.common.faker.number().digits(3)); })() : price
  * def shipping = typeof shipping === 'undefined' ? bg.common.faker.number().randomDigit() : shipping
  * def upc = typeof upc === 'undefined' ? bg.common.faker.code().ean13() : upc
  * def description = typeof description === 'undefined' ? bg.common.faker.lorem().sentence() : description
  * def manufacturer = typeof manufacturer === 'undefined' ? bg.common.faker.company().name() : manufacturer
  * def model = typeof model === 'undefined' ? bg.common.faker.lorem().word() : model
  * def productUrl = typeof productUrl === 'undefined' ? bg.common.faker.internet().url() : url
  * def image = typeof image === 'undefined' ? bg.common.faker.internet().image() : image

Scenario: 
Given configure headers = defaultHeaders
And def payload = 
"""
{
  "name": #(name),
  "type": #(type),
  "price": #(price),
  "shipping": #(shipping),
  "upc": #(upc),
  "description": #(description),
  "manufacturer": #(manufacturer),
  "model": #(model),
  "url": #(productUrl),
  "image": #(image)
}
"""
And print payload
And url baseUrl
And request payload
And path 'products/'
And method POST
And match responseStatus == expectedStatus