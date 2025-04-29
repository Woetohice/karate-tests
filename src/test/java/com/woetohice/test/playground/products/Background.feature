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
Scenario: Background