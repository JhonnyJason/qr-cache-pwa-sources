############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("navtriggers")
#endregion

############################################################
import * as nav from "navhandler"

############################################################
## Navigation Action Triggers

############################################################
export home = ->
    return nav.toRoot(true)

############################################################
export menu = (menuOn) ->
    if menuOn then return nav.toMod("menu")
    else return nav.toMod("none")

############################################################
export addManually = ->
    return nav.toMod("add-manually")

############################################################
export reload = ->
    window.location.reload()
    return
