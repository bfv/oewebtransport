 
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
using OpenEdge.Web.WebResponse.
using OpenEdge.Core.String.
using Progress.Lang.Error.

block-level on error undo, throw.

class WebHandlerExt inherits WebHandler: 

  define public property Router as RequestRouter no-undo get. set.
  
  constructor public WebHandlerExt():
    this-object:Router = new RequestRouter().  
  end.
		
  method override protected integer HandleGet(request as IWebRequest):
    
    define variable response as IHttpResponse no-undo.
    define variable requestHandler as IWebRequestHandler no-undo.    
    define variable writer as OpenEdge.Web.WebResponseWriter  no-undo.               
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
    
    do on error undo, throw:
      
      endpoint = getEndpoint(request).
      requestHandler = this-object:getHandler(endpoint).
      response = requestHandler:HandleRequest(request).
    
      catch err1 as Progress.Lang.Error :
        response = new WebResponse().
        response:StatusCode = integer(StatusCodeEnum:InternalServerError).
        response:StatusReason = err1:GetMessage(1).
        response:Entity = generateErrorString(err1, endpoint).
        response:ContentType = 'text/plain'.
      end catch.
      
    end.
    
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
  
  method private String generateErrorString(err1 as Error, endpoint as character):
    
    define variable errorString as String no-undo.
    
    errorString = new String(
      substitute(
        'Internal Server Error (500) for POST to ~'&1~': &2~n~nStacktrace:~n&3', 
        endpoint, 
        err1:GetMessage(1),
        err1:CallStack
      )
    ).
    
    return errorString.
    
  end method.
  
  
  
end class    