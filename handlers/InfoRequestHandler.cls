 
 /*------------------------------------------------------------------------
    File        : InfoRequestHandler
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : bronco
    Created     : Thu Jun 15 16:16:17 CEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

using OpenEdge.Net.HTTP.StatusCodeEnum.
using OpenEdge.Net.HTTP.HttpHeader.
using OpenEdge.Web.IWebRequest.
using OpenEdge.Net.HTTP.IHttpResponse.
using OpenEdge.Core.String.

block-level on error undo, throw.

class handlers.InfoRequestHandler implements IWebRequestHandler: 

  method public IHttpResponse HandleRequest(request as IWebRequest):
    
    define variable body as String no-undo.
    define variable headers as HttpHeader extent no-undo.
    define variable headerString as character no-undo.
    define variable i as integer no-undo.
    define variable contextString as character no-undo.
    define variable cslength as integer no-undo.
    define variable contextName as character no-undo.
    define variable response as OpenEdge.Net.HTTP.IHttpResponse no-undo.
    
    
    response = new OpenEdge.Web.WebResponse().
        
    request:GetHeaders(output headers).
    do i = 1 to extent(headers):       
      headerString = headerString + '~r~n' + HttpHelper:NormalizeHeaderName(headers[i]:Name) + " = " + headers[i]:Value.   
    end.
    
    cslength = num-entries(request:ContextNames).
    do i = 1 to cslength:
      contextName = entry(i, request:ContextNames).
      contextString = contextString + '~r~n' + HttpHelper:NormalizeHeaderName(contextName) + ': ' + request:GetContextValue(contextName). 
    end.
    
    /* This body object can be a string or something else (JsonObject for instance) */               
    assign 
      body = new OpenEdge.Core.String(
                             'Request Accept: ' + request:GetHeader('Accept'):GetBaseValue() + '~r~n' + 
                             '~r~nheaders: ' + headerString + '~r~n' + 
                             '~r~ncontext: ' + contextString
                           + '~r~n~r~n':u   /*CRLF */
                           + 'This message was returned by HandleGet in RestWebHandler.'
                           ).
        
    assign 
      response:Entity        = body
      response:ContentType   = 'text/plain':u    /* HTTP messages require a content type */
      response:ContentLength = body:Size         /* ContentLength is good too */
      .
     
    return response.
    
  end method.

end class.