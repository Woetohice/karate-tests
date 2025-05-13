
Feature: Product Lifecycle Tests

Background:
  * def bg = callonce read('classpath:com/woetohice/test/playground/products/Background.feature')
Scenario: Get Product by Id
    * def expectedStatus = 200
    * def testProductId = 43900
    Given def product = call read('classpath:com/woetohice/test/playground/products/fragments/getProductById.feature') {productId: '#(testProductId)', expectedStatus: #(expectedStatus)}
    Then match product.response contains bg.getProductResponseSchema
    Then match product.response.id == testProductId

Scenario: Create a product and verify the creation via get
  # Create a product with random data.  the POST request should return a 201 Created status
  * def expectedStatus = 201
  Given def addProductRequest = call read('classpath:com/woetohice/test/playground/products/fragments/addProduct.feature') {expectedStatus: #(expectedStatus)}
  # Capture the product ID and created time for later comparison
  And def productId = addProductRequest.response.id
  And def createdTimeDate = addProductRequest.response.createdAt
  # check Add response against the excpected response schema
  And match addProductRequest.response contains bg.addProductResponseSchema
  # check Add response against request payload to make sure the response matches the requested data fields
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

  # fetch the created product by the ID captured and verify the GET response is 200 OK
  And def expectedStatus = 200
  When def getProductRequest = call read('classpath:com/woetohice/test/playground/products/fragments/getProductById.feature') {productId: '#(productId)', expectedStatus: #(expectedStatus)}
  Then match getProductRequest.response contains bg.getProductResponseSchema
  And match getProductRequest.response.id != null
  And match getProductRequest.response.createdAt != null
  And match getProductRequest.response.createdAt == createdTimeDate
  And match getProductRequest.response.updatedAt == createdTimeDate
  
  # Verify the GET response against the POST request payload
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

  # Delete the product by ID and verify the DELETE response schema is correct and the status is 200 OK
  * def expectedStatus = 200
  When def deleteProductRequest = call read('classpath:com/woetohice/test/playground/products/fragments/deleteProductById.feature') {productId: '#(productId)', expectedStatus: #(expectedStatus)}
  And match deleteProductRequest.response contains bg.deleteProductResponseSchema
  And match deleteProductRequest.response.id == productId
  And match addProductRequest.payload.name == deleteProductRequest.response.name
  And match addProductRequest.payload.type == deleteProductRequest.response.type
  And match addProductRequest.payload.price == deleteProductRequest.response.price
  And match addProductRequest.payload.upc == deleteProductRequest.response.upc
  And match addProductRequest.payload.shipping == deleteProductRequest.response.shipping
  And match addProductRequest.payload.description == deleteProductRequest.response.description
  And match addProductRequest.payload.manufacturer == deleteProductRequest.response.manufacturer
  And match addProductRequest.payload.model == deleteProductRequest.response.model
  And match addProductRequest.payload.url == deleteProductRequest.response.url
  And match addProductRequest.payload.image == deleteProductRequest.response.image

  # Verify the product is deleted by trying to fetch it by ID and expecting a 404 Not Found status
  And def expectedStatus = 404
  When def afterDeleteGetProductRequest = call read('classpath:com/woetohice/test/playground/products/fragments/getProductById.feature') {productId: '#(productId)', expectedStatus: #(expectedStatus)}
  And match afterDeleteGetProductRequest.response contains bg.notFoundResponseSchema
  Then match afterDeleteGetProductRequest.response.message contains 'No record found for id \'' + productId + '\''
