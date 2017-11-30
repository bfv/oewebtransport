 
 /*------------------------------------------------------------------------
    File        : RequestRouter
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : bronco
    Created     : Thu Jun 15 17:33:15 CEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

block-level on error undo, throw.

class RequestRouter: 
  
  define private temp-table ttroute no-undo
    field order as integer
    field path as character
    field handlerClassName as character
    index pk as primary unique order
    .
    
  define private variable routeCount as integer no-undo.
  
  constructor public RequestRouter():
    fillRoutes().  
  end.
   
  method public IWebRequestHandler GetHandler(path as character):
    
    define variable handlerObject as IWebRequestHandler no-undo.
    define variable handlerClassName as character no-undo.
    
    if (substring(path, length(path), 1) <> '/') then
      path = path + '/'.

    handlerClassName = 'handlers.NotFoundHandler'.
    for each ttroute:
      if (path matches ttroute.path) then do:
        handlerClassName = ttroute.handlerClassName.
        leave.
      end.          
    end.

    handlerObject = dynamic-new (handlerClassName)().
      
    return handlerObject.
       
  end method.  
  
  
  method private void addRoute(path as character, className as character, order as integer):
  
    if (substring(path, length(path), 1) <> '/') then
      path = path + '/*'.
      
    create ttroute.
    assign 
      ttroute.order = order
      ttroute.path = path
      ttroute.handlerClassName = className
      .
    
  end method.
  
  
  method public void AddRoute(path as character, className as character):
    routeCount = routeCount + 1.
    this-object:addRoute(path, className, routeCount).
  end method.
  
  
  method private void fillRoutes():
    this-object:AddRoute('/dataviz', 'handlers.DatavizHandler').
    this-object:AddRoute('/info', 'handlers.InfoRequestHandler', 65534).
    this-object:AddRoute('/ping', 'handlers.PingRequestHandler', 65535).
  end method.
  
end class.