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
addByScan = null
addByInput = null

############################################################
export initialize = ->
    log "initialize"
    addByScan = document.getElementById("add-by-scan")
    addByScan.addEventListener("click", addByScanClicked)
    addByInput = document.getElementById("add-by-input")
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
