
Feature: Product Lifecycle Tests

Background:
  * def testProductId = 43900
  * def expectedStatus = 200
  * def fakerType = Java.type('com.github.javafaker.Faker')
  * def faker = new fakerType()
  * def maxLengthName = faker.lorem().characters(100)
  * def oversizeName = faker.lorem().characters(101)
  * def maxLengthType = faker.lorem().characters(30)
  * def oversizeType = faker.lorem().characters(31)
  * def maxLengthUpc = faker.lorem().characters(15)
  * def oversizeUpc = faker.lorem().characters(16)
  * def maxLengthDesc = faker.lorem().characters(100)
  * def oversizeDesc = faker.lorem().characters(101)
  * def maxLengthManu = faker.lorem().characters(50)
  * def oversizeManu = faker.lorem().characters(51)
  * def maxLengthModel = faker.lorem().characters(25)
  * def oversizeModel = faker.lorem().characters(26)
  * def maxLengthUrl = faker.lorem().characters(500)
  * def oversizeUrl = faker.lorem().characters(501)

Scenario: Get Product by Id
  * def productId = testProductId
  Given def getProduct = call read('classpath:com/woetohice/test/playground/products/fragments/getProductById.feature') {productId: '#(testProductId)', expectedStatus: #(expectedStatus)}
  Then match getProduct.response contains getProduct.bg.getProductResponseSchema
  And match getProduct.response.id == testProductId

Scenario: Create a product and verify the creation via get
  # Create a product with random data.  the POST request should return a 201 Created status
  * def expectedStatus = 201
  Given def addProductRequest = call read('classpath:com/woetohice/test/playground/products/fragments/addProduct.feature') {expectedStatus: #(expectedStatus)}
  # Capture the product ID and created time for later comparison
  And def productId = addProductRequest.response.id
  And def createdTimeDate = addProductRequest.response.createdAt
  # check Add response against the excpected response schema
  And match addProductRequest.response contains addProductRequest.bg.addProductResponseSchema
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
  Then match getProductRequest.response contains getProductRequest.bg.getProductResponseSchema
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
  And match deleteProductRequest.response contains deleteProductRequest.bg.deleteProductResponseSchema
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
  And match afterDeleteGetProductRequest.response contains afterDeleteGetProductRequest.bg.notFoundResponseSchema
  Then match afterDeleteGetProductRequest.response.message contains 'No record found for id \'' + productId + '\''

Scenario Outline: Verify <fieldName> string values that <scenarioDescription> for POST return <expectedStatus>
  * def expectedStatus = <expectedStatus>
  Given def addProductRequest = call read('classpath:com/woetohice/test/playground/products/fragments/addProduct.feature') {expectedStatus: #(expectedStatus), <fieldName>: <fieldValue>}
  Then match addProductRequest.response contains addProductRequest.bg.<expectedResponseSchema>
Examples:
  | fieldName   | fieldValue       | expectedStatus | scenarioDescription            | expectedResponseSchema   |
  | name        | 'TestProduct'    | 201            | "contain a single word"        | addProductResponseSchema |
  | name        | 'Test Type'      | 201            | "contain a space"              | addProductResponseSchema |
  | name        | ' Test Product'  | 201            | "contain a leading space"      | addProductResponseSchema |
  | name        | 'Test Product '  | 201            | "contain trailing space"       | addProductResponseSchema |
  | name        | 'Test Product!'  | 201            | "contain special characters"   | addProductResponseSchema |
  | name        | 'T'              | 201            | "are minimum length"           | addProductResponseSchema |
  | name        | #(maxLengthName) | 201            | "are maximum length"           | addProductResponseSchema |
  | name        | 'Test Product'   | 201            | "contain special characters"   | addProductResponseSchema |
  | name        | 'バリュー・バ'    | 201            | "contain unicode characters "  | addProductResponseSchema |
  | name        | 'Test 🙂'        | 201            | "contain emoji characters"     | addProductResponseSchema |
  | type        | #(maxLengthType) | 201            | "are maximum length"           | addProductResponseSchema |
  | type        | 'Test Type'      | 201            | "contain a space"              | addProductResponseSchema |
  | type        | 'Test Type!'     | 201            | "contain special characters"   | addProductResponseSchema |
  | type        | 'TestType'       | 201            | "contain a single word"        | addProductResponseSchema |
  | type        | ' TestType'      | 201            | "contain a leading space"      | addProductResponseSchema |
  | type        | 'TestType '      | 201            | "contain trailing space"       | addProductResponseSchema |
  | type        | 'バリュー・バ'    | 201            | "contain unicode characters"   | addProductResponseSchema |
  | type        | 'Test🙂'         | 201            | "contain emoji characters"     | addProductResponseSchema |
  | upc         | #(maxLengthUpc)  | 201            | "are maximum length"           | addProductResponseSchema |
  | upc         | '1'              | 201            | "are minimum length"           | addProductResponseSchema |
  | description | #(maxLengthDesc) | 201            | "are maximum length"           | addProductResponseSchema |
  | description | 'T'              | 201            | "are minimum length"           | addProductResponseSchema |
  | description | 'TestProduct'    | 201            | "contain a single word"        | addProductResponseSchema |
  | description | 'Test Type'      | 201            | "contain a space"              | addProductResponseSchema |
  | description | ' Test Product'  | 201            | "contain a leading space"      | addProductResponseSchema |
  | description | 'Test Product '  | 201            | "contain trailing space"       | addProductResponseSchema |
  | description | 'Test Product!'  | 201            | "contain special characters"   | addProductResponseSchema |
  | description | 'バリュー・バ'    | 201            | "contain unicode characters"   | addProductResponseSchema |
  | name        | #(oversizeName)  | 400            | "are over maximum length"      | badRequestResponseSchema |
  | type        | null             | 400            | "are null"                     | badRequestResponseSchema |
  | name        | ''               | 400            | "are empty"                    | badRequestResponseSchema |
  | name        | null             | 400            | "are null"                     | badRequestResponseSchema |
  | name        | ''               | 400            | "are less than minimum length" | badRequestResponseSchema |
  | type        | ''               | 400            | "are empty"                    | badRequestResponseSchema |
  | type        | null             | 400            | "are null"                     | badRequestResponseSchema |
  | type        | #(oversizeType)  | 400            | "are over maximum length"      | badRequestResponseSchema |
  | upc         | #(oversizeUpc)   | 400            | "are over maximum length"      | badRequestResponseSchema |
  | upc         | null             | 400            | "are null"                     | badRequestResponseSchema |
  | upc         | ''               | 400            | "are empty"                    | badRequestResponseSchema |
  
  
  