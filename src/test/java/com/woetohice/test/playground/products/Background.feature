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
    * def deleteProductResponseSchema =
    """
    {
      "id": '#number',
      "name": '#string',
      "type": '#string',
      "price": '#number',
      "upc": '#string',
      "shipping": '#number',
      "description": '#string',
      "manufacturer": '#string',
      "model": '#string',
      "url": '#string',
      "image": '#string',
      "createdAt": '#string',
      "updatedAt": '#string',
    }
    """
    * def notFoundResponseSchema =
    """
    {
      "name":'#string',
      "message":'#string',
      "code":'#number',
      "className":'#string',
      "errors":{}
    }
    """
    * def badRequestResponseSchema =
    """
    {
      "name":'#string',
      "message":'#string',
      "code":'#number',
      "className":'#string',
      "data":{},
      "errors":#[]
    }
    """
Scenario: Background