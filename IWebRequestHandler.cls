
/*------------------------------------------------------------------------
    File        : IWebRequestHandler
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : bronco
    Created     : Thu Jun 15 16:13:35 CEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

using OpenEdge.Net.HTTP.IHttpResponse.
using OpenEdge.Web.IWebRequest.

interface IWebRequestHandler:  
  
  method public IHttpResponse HandleRequest(request as IWebRequest).
  
end interface.