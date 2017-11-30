 
 /*------------------------------------------------------------------------
    File        : NotFoundHandler
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : bronco
    Created     : Thu Jun 15 17:15:51 CEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

using OpenEdge.Net.HTTP.StatusCodeEnum from propath.

block-level on error undo, throw.

class handlers.NotFoundHandler implements IWebRequestHandler: 

  method public OpenEdge.Net.HTTP.IHttpResponse HandleRequest(request as OpenEdge.Web.IWebRequest):
    
    define variable response as OpenEdge.Net.HTTP.IHttpResponse no-undo.
    define variable body     as OpenEdge.Core.String            no-undo.
    
    
    assign 
      response            = new OpenEdge.Web.WebResponse()
      response:StatusCode = integer(StatusCodeEnum:NotFound)
      .
    
    body = new OpenEdge.Core.String('404, not found: ' + request:GetContextValue('URI_FINAL_MATCH_GROUP')).
        
    assign 
      response:Entity        = body
      response:ContentType   = 'text/plain'    /* HTTP messages require a content type */
      response:ContentLength = body:Size         /* ContentLength is good too */
      .
    
    return response.

  end method.

end class.