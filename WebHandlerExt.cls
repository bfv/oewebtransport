 
/*------------------------------------------------------------------------
   File        : WebHandlerExt
   Purpose     : 
   Syntax      : 
   Description : 
   Author(s)   : bronco
   Created     : Wed May 17 15:32:46 CEST 2017
   Notes       : 
 ----------------------------------------------------------------------*/

using OpenEdge.Web.WebResponseWriter.
using OpenEdge.Net.HTTP.StatusCodeEnum.
using OpenEdge.Web.WebHandler.
using OpenEdge.Net.HTTP.HttpHeader.
using OpenEdge.Web.WebRequest.
using Progress.Json.ObjectModel.JsonObject.
using OpenEdge.Net.HTTP.IHttpResponse.
using OpenEdge.Web.IWebRequest.

block-level on error undo, throw.

class WebHandlerExt inherits WebHandler: 

  define public property Router as RequestRouter no-undo get. set.
  
  constructor public WebHandlerExt():
    this-object:Router = new RequestRouter().  
  end.
		
  method override protected integer HandleGet(request as IWebRequest):
    
    define variable response as IHttpResponse no-undo.
    define variable requestHandler as IWebRequestHandler no-undo.    
    define variable writer   as OpenEdge.Web.WebResponseWriter  no-undo.               
    define variable endpoint as character no-undo.
    
    
    endpoint = getEndpoint(request).
    requestHandler = this-object:getHandler(endpoint).
    response = requestHandler:HandleRequest(request).
    
    writer = new WebResponseWriter(response).
    writer:Open().
    writer:Close().
        
    return 0.
    
  end method. 
  
  
  method override protected integer HandlePost(request as OpenEdge.Web.IWebRequest):
    
    define variable response as OpenEdge.Net.HTTP.IHttpResponse no-undo.
    define variable requestHandler as IWebRequestHandler no-undo. 
    define variable writer as OpenEdge.Web.WebResponseWriter no-undo.
    define variable endpoint as character no-undo.
    
    
    endpoint = getEndpoint(request).
    requestHandler = this-object:getHandler(endpoint).
    response = requestHandler:HandleRequest(request).

    writer = new WebResponseWriter(response).
    writer:Open().
    writer:Close().
        
    return 0.
    
  end method. 

  
  method private character getEndpoint(request as OpenEdge.Web.IWebRequest):
    return string(request:GetContextValue('URI_FINAL_MATCH_GROUP')).
  end method.
  
  
  method private IWebRequestHandler getHandler(path as character):    
    return this-object:Router:GetHandler(path).
  end method.
      
  method override protected integer HandleNotAllowedMethod( webRequest as OpenEdge.Web.IWebRequest ):
    undo, throw new Progress.Lang.AppError("METHOD NOT IMPLEMENTED").
  end method.


  method override protected integer HandleNotImplemented(webRequest as OpenEdge.Web.IWebRequest ):
    undo, throw new Progress.Lang.AppError("METHOD NOT IMPLEMENTED").
  end method.
  
end class    