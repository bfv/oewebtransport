# oewebtransport

This is a minimalistic sample implementation for the PASOE web transport.

## handlers
The `openedge.properties` file in `<pasoe-instance-dir>/conf` looks like:

```
# Transport properties for the WEB protocol
[as-oewebrest.oeweb.WEB]
    adapterEnabled=1
    defaultCookieDomain=
    defaultCookiePath=
    defaultHandler=OpenEdge.Web.CompatibilityHandler
    handler1=WebHandlerExt:/api
    srvrAppMode=development
    srvrDebug=1
    wsRoot=/oeweb/static/webspeed
```

The important part here is: `handler1=WebHandlerExt:/api`. This maps whatever is the WebHandlerExt class to the `/api` url (extension).
The complete call would look something like: `http://localohost:5000/oeweb/web/api/info` where info is something which is implemented by `WebHandlerExt`.

