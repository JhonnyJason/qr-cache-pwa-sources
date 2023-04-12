############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("addcodebuttonmodule")
#endregion

############################################################
import { read as scanQR } from "./qrreadermodule.js"

############################################################
import * as acceptCode from "./acceptcodeframemodule.js"

############################################################
export initialize = ->
    log "initialize"
    addByScan.addEventListener("click", addByScanClicked)
    addByInput.addEventListener("click", addByInputClicked)
    return


############################################################
addByScanClicked = ->
    log "addByScanClicked"
    try 
        qrData = await scanQR()
        if !qrData? then throw new Error("Aborted by user!")
        log qrData
        acceptCode.launch(qrData)
    catch err then log err
    return

addByInputClicked = ->
    log "addByInputClicked"
    acceptCode.launch("")
    return
