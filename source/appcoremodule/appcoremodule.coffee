############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("appcoremodule")
#endregion

import * as nav from "navhandler"

############################################################
import * as uiState from "./uistatemodule.js"
import * as triggers from "./navtriggers.js"


############################################################
appBaseState = "no-code"
appUIMod = "none"

############################################################
export initialize = ->
    log "initialize"
    nav.initialize(setNavState, setNavState)
    return


############################################################
setNavState = (navState) ->
    log "setNavState"
    baseState = navState.base
    modifier = navState.modifier
    context = navState.context
    # S.save("navState", navState)
    
    setUIState(baseState, modifier, context)
    return

############################################################
setUIState = (base, mod, ctx) ->
    log "setUIState"

    switch base
        when "RootState" then return

    ########################################
    setAppState(base, mod)

    switch mod
        when "logoutconfirmation" then confirmLogoutProcess()
    

    ########################################
    # setAppState(base, mod)
    return


############################################################
setAppState = (base, mod) ->
    log "setAppState"
    if base then appBaseState = base
    if mod then appUIMod = mod
    log "#{appBaseState}:#{appUIMod}"

    uiState.applyUIState(appBaseState, appUIMod)
    return
