############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("acceptcodeframemodule")
#endregion

############################################################
export initialize = ->
    log "initialize"
    #Implement or Remove :-)
    return

export launch = (code) ->
    log "launch"
    log code
    overlayFrame.className = "accepting"
    return