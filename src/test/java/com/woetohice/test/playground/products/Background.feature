Feature:
Background:
  * def getProductResponseSchema = call read('classpath:com/woetohice/test/playground/products/schema/getProductsResponseSchema.json')
  * def postProductResponseSchema = call read('classpath:com/woetohice/test/playground/products/schema/postProductResponseSchema.json')
  * def postProductRequestSchema = call read('classpath:com/woetohice/test/playground/products/schema/postProductRequestSchema.json')
  
