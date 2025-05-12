
Feature: Product Lifecycle Tests

Background:
  * def bg = callonce read('classpath:com/woetohice/test/playground/products/Background.feature')
Scenario: Get Product by Id
    * def expectedStatus = 200
    * def testProductId = 43900
    Given def product = call read('classpath:com/woetohice/test/playground/products/fragments/getProductById.feature') {productId: '#(testProductId)', expectedStatus: #(expectedStatus)}
    Then match product.response contains bg.getProductResponseSchema
    Then match product.response.id == testProductId
    And print product.response
Scenario: Create a product and verify the creation via get
  * def expectedStatus = 201
  Given def addProductRequest = call read('classpath:com/woetohice/test/playground/products/fragments/addProduct.feature') {expectedStatus: #(expectedStatus)}
  And def productId = addProductRequest.response.id
  And def createdTimeDate = addProductRequest.response.createdAt
  # check Add response against request payload
  And match addProductRequest.payload.name == addProductRequest.response.name
  And match addProductRequest.payload.type == addProductRequest.response.type
  And match addProductRequest.payload.price == addProductRequest.response.price
  And match addProductRequest.payload.upc == addProductRequest.response.upc
  And match addProductRequest.payload.shipping == addProductRequest.response.shipping
  And match addProductRequest.payload.description == addProductRequest.response.description
  And match addProductRequest.payload.manufacturer == addProductRequest.response.manufacturer
  And match addProductRequest.payload.model == addProductRequest.response.model
  And match addProductRequest.payload.url == addProductRequest.response.url
  And match addProductRequest.payload.image == addProductRequest.response.image
  And def expectedStatus = 200
  When def getProductRequest = call read('classpath:com/woetohice/test/playground/products/fragments/getProductById.feature') {productId: '#(productId)', expectedStatus: #(expectedStatus)}
  Then match getProductRequest.response contains bg.getProductResponseSchema
  And match getProductRequest.response.id != null
  And match getProductRequest.response.createdAt != null
  And match getProductRequest.response.updatedAt == createdTimeDate
  # check Get response against request payload
  And match addProductRequest.payload.name == getProductRequest.response.name
  And match addProductRequest.payload.type == getProductRequest.response.type
  And match addProductRequest.payload.price == getProductRequest.response.price
  And match addProductRequest.payload.upc == getProductRequest.response.upc
  And match addProductRequest.payload.shipping == getProductRequest.response.shipping
  And match addProductRequest.payload.description == getProductRequest.response.description
  And match addProductRequest.payload.manufacturer == getProductRequest.response.manufacturer
  And match addProductRequest.payload.model == getProductRequest.response.model
  And match addProductRequest.payload.url == getProductRequest.response.url
  And match addProductRequest.payload.image == getProductRequest.response.image
