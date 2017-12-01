 
 /*------------------------------------------------------------------------
    File        : WebRequestExt
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : bronco
    Created     : Thu Nov 23 12:14:33 CET 2017
    Notes       : 
  ----------------------------------------------------------------------*/

using OpenEdge.Web.IWebRequest.
using Progress.Json.ObjectModel.JsonObject.
using exceptions.InvalidContentType.

block-level on error undo, throw.

class WebRequestExt: 
  
  define public property Request as IWebRequest no-undo get. set.
  define public property Accept as character no-undo get. set.
  define public property ContentType as character no-undo init ? get. set.
  define public property Method as character no-undo get. set.
  define public property Url as character no-undo get. set.
  
  constructor public WebRequestExt(request as IWebRequest):
    this-object:Request = request.
    this-object:parseRequest().
  end.
  
  
  method private void parseRequest():
    
    this-object:Method = this-object:Request:Method.
    this-object:Accept = this-object:Request:GetHeader('Accept'):Value.
    
    if (this-object:Method = "POST") then
      this-object:ContentType =  this-object:Request:GetHeader('Content-Type'):Value.
    
    this-object:Url = this-object:Request:GetContextValue('URI_FINAL_MATCH_GROUP').
     
  end method.
  
  
  method public JsonObject GetJsonContent():
    
    define variable json as JsonObject no-undo.
    
    
    if (this-object:Request:Entity:GetClass():TypeName <> 'Progress.Json.ObjectModel.JsonObject') then 
      undo, throw new InvalidContentType('Expected JsonObject, found ' + this-object:Request:Entity:GetClass():TypeName).
      
    json = cast(this-object:Request:Entity, 'Progress.Json.ObjectModel.JsonObject').
      
    return json.
    
  end method.
  
  method public override character ToString():
    
    define variable resultString as character no-undo.
    
    resultString = substitute('url: &1~n', this-object:Url).    
    resultString = resultString + substitute('method: &1~n', this-object:Method).
    
    if (this-object:Method = 'POST' /* or ... */) then
      resultString = resultString + substitute('Content-Type: &1~n', this-object:ContentType).
    
    resultString = resultString + substitute('Accept: &1~n', this-object:Accept).
    
    return resultString.
   
  end method.
  
end class.