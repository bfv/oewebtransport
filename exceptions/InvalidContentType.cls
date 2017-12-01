 
 /*------------------------------------------------------------------------
    File        : InvalidContentType
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : bronco
    Created     : Fri Dec 01 09:14:43 CET 2017
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.
using Progress.Lang.AppError.

block-level on error undo, throw.

class exceptions.InvalidContentType inherits AppError: 

    
  constructor public InvalidContentType(errorMessage as character):
    super (errorMessage, -1).    
  end constructor.

end class.