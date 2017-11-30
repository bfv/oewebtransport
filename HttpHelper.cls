 
 /*------------------------------------------------------------------------
    File        : HttpHelper
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : bronco
    Created     : Thu Jun 15 16:21:10 CEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

block-level on error undo, throw.

class HttpHelper: 

  method public static character NormalizeHeaderName (headerName as character):
    
    define variable nextCharUpper as logical no-undo.
    define variable resultString as character no-undo.
    define variable headerNameLength as integer no-undo.
    define variable i as integer no-undo.
    define variable currentChar as character no-undo.
    
    headerNameLength = length(headerName).
    nextCharUpper = true.
    do i = 1 to headerNameLength:
      
      currentChar = substring(headerName, i, 1).

      if (nextCharUpper) then do:
        resultString = resultString + caps(currentChar).
        nextCharUpper = false.
        next.
      end.  
      
      if (currentChar = '_') then do:
        currentChar = '-'.
        nextCharUpper = true.
      end.
      
      resultString = resultString + lc(currentChar).
      
    end.
    
    return resultString.
    
  end method.

end class.