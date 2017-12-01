 
 /*------------------------------------------------------------------------
    File        : JsonSampleHandler
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : bronco
    Created     : Thu Nov 30 20:17:12 CET 2017
    Notes       : 
  ----------------------------------------------------------------------*/


block-level on error undo, throw.

using OpenEdge.Net.HTTP.IHttpResponse.
using OpenEdge.Web.WebResponse.
using Progress.Json.ObjectModel.JsonObject.
using OpenEdge.Net.HTTP.StatusCodeEnum.

class handlers.JsonSampleHandler implements IWebRequestHandler: 

  method public IHttpResponse HandleRequest(request as OpenEdge.Web.IWebRequest):
    
    define variable req as WebRequestExt no-undo.
    
  
    req = new WebRequestExt(request).
    
    case req:Method: 
      
      when "GET" then 
        return this-object:HandleGetRequest(request).
        
      when "POST" then 
        return this-object:HandlePostRequest(req).
          
    end.
    
  end method.


  method public IHttpResponse HandleGetRequest(request as OpenEdge.Web.IWebRequest):
    
    define variable response as IHttpResponse no-undo.
    define variable body as OpenEdge.Core.String no-undo.
    define variable json as JsonObject no-undo.
    
    
    response = new WebResponse().
    json = new JsonObject().
    
    json:Add('hello', 'world').
    
    response:Entity = json.
    response:ContentType = 'application/json'.
    response:StatusCode = integer(StatusCodeEnum:OK).
    
    return response.
    
  end method.


  method public IHttpResponse HandlePostRequest(request as WebRequestExt):
    
    define variable response as IHttpResponse no-undo.
    define variable body as OpenEdge.Core.String no-undo.
    define variable json as JsonObject no-undo.
    
    
    response = new WebResponse().
    
    json = new JsonObject().   
    json:Add('received', request:GetJsonContent()).
    
    response:Entity = json.
    response:ContentType = 'application/json'.
    response:StatusCode = integer(StatusCodeEnum:OK).
    
    return response.

  end method.
  
end class.
