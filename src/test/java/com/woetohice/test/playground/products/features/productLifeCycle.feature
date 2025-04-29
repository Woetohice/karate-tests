Feature: Product Lifecycle Tests

Background:
  * def bg = callonce read('classpath:com/woetohice/test/playground/products/Background.feature')

Scenario: Get Product by Id
    * def expectedStatus = 200
    * def testProductId = 43900
    Given def product = call read('classpath:com/woetohice/test/playground/products/fragments/getProductById.feature') {productId: '#(testProductId)', expectedStatus: '#(expectedStatus)'}
    Then match product.response contains bg.getProductResponseSchema
    Then match product.response.id == testProductId

