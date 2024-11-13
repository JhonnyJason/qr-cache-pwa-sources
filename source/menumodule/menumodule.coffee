############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("menumodule")
#endregion

############################################################
import * as pwaInstall from "./pwainstallmodule.js"
import * as triggers from "./navtriggers.js"

############################################################
#region DOM Cache
menuFrame = document.getElementById("menu-frame")
addManuallyButton = document.getElementById("add-manually-button")
menuVersion = document.getElementById("menu-version")
pwaInstallButton = document.getElementById("pwa-install-button")

# menuEntryTemplate = document.getElementById("menu-entry-template")
#endregion

############################################################
# entryTemplate = menuEntryTemplate.innerHTML

############################################################
export initialize = ->
    log "initialize"
    # menuFrame.addEventListener("click", menuFrameClicked)
    # addManuallyButton.addEventListener("click", addManuallyClicked)
    # menuVersion.addEventListener("click", menuVersionClicked)
    # pwaInstallButton.addEventListener("click", pwaInstallClicked)
    return

############################################################
#region event Listeners
menuFrameClicked = (evnt) ->
    log "menuFrameClicked"
    triggers.menu(off)
    return

addManuallyClicked = (evnt) ->
    log "addManuallyClicked"
    evnt.stopPropagation()
    triggers.addManually()
    return

menuVersionClicked = (evnt) ->
    log "menuVersionClicked"
    evnt.stopPropagation()
    triggers.reload()
    return

pwaInstallClicked = (evnt) ->
    log "pwaInstallClicked"
    pwaInstall.promptForInstallation()
    return

#endregion


############################################################
#region UI State functions

############################################################
export setMenuOff = ->
    document.body.classList.remove("menu-on")
    return

############################################################
export setMenuOn = ->
    document.body.classList.add("menu-on")
    return

############################################################
export setInstallableOn =  ->
    document.body.classList.add("installable")

############################################################
export setInstallableOff = ->
    document.body.classList.remove("installable")

#endregion