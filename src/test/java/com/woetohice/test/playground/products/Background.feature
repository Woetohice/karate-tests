@ignore
Feature: Shared Product Resources

Background:
  * def common = callonce read('classpath:com/woetohice/test/playground/Common.feature')
  * def getProductResponseSchema = 
    """
    {
      "id": "#number",
      "name": "#string",
      "type": "#string",
      "price": "#number",
      "upc": "#string",
      "shipping": "#number",
      "description": "#string",
      "manufacturer": "#string",
      "model": "#string",
      "url": "#string",
      "image": "#string",
      "createdAt": "#string",
      "updatedAt": "#string",
      "categories": "#[]"
    }
    """
  * def addProductResponseSchema =
  * def productResponseSchema =
    """
    {
      id: '#number',
      name: '#string',
      type: '#string',
      price: '#number',
      shipping: '#number',
      upc: '#string',
      description: '#string',
      manufacturer: '#string',
      model: '#string',
      url: '#string',
      image: '#string',
      updatedAt: '#string',
      createdAt: '#string'
    }
    """
Scenario: Background