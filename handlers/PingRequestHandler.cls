 
 /*------------------------------------------------------------------------
    File        : PingRequestHandler
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : bronco
    Created     : Thu Jun 15 17:15:18 CEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.
using OpenEdge.Net.HTTP.StatusCodeEnum.

block-level on error undo, throw.

class handlers.PingRequestHandler implements IWebRequestHandler: 

  method public OpenEdge.Net.HTTP.IHttpResponse HandleRequest(request as OpenEdge.Web.IWebRequest):
    
    define variable response as OpenEdge.Net.HTTP.IHttpResponse no-undo.
    define variable body     as OpenEdge.Core.String            no-undo.
    
    
    assign 
      response            = new OpenEdge.Web.WebResponse()
      response:StatusCode = integer(StatusCodeEnum:OK)
      .
    
      body = new OpenEdge.Core.String('ping: ' + iso-date(now)).
        
    assign 
      response:Entity        = body
      response:ContentType   = 'text/plain'    /* HTTP messages require a content type */
      response:ContentLength = body:Size         /* ContentLength is good too */
      .
    
    return response.

  end method.

end class.