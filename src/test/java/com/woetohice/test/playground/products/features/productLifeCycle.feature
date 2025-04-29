Feature: Product Life Cycle
  Background:
  * def bg = call read('classpath:com/woetohice/test/playground/products/Background.feature')

Scenario: Get Product by Id
    * def expectedStatus = 200
    * def testProductId = '43900'
    Given def product = call read('classpath:playground/products/fragments/getProductById.feature') {productId: '#(testProductId)', expectedStatus: '#(expectedStatus)'}
    When def productId = product.response.id
    Then match product.response contains only getProductResponseSchema
    Then match product.response.id == testProductId
    

