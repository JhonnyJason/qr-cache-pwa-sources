############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("versiondisplaymodule")
#endregion

############################################################
import { appVersion } from "./configmodule.js"
import * as menu from "./menumodule.js"

############################################################
serviceWorker = null
if navigator? and navigator.serviceWorker?
    serviceWorker = navigator.serviceWorker

## TODO 
##... overthink interplay of versionmodule and menumodule
############################################################
currentVersion = document.getElementById("current-version")
newVersion = document.getElementById("new-version")
menuVersion.classList.add("to-update")
    
############################################################
export initialize = ->
    log "initialize"
    if currentVersion? then currentVersion.textContent = appVersion
    
    if serviceWorker?
        serviceWorker.register("serviceworker.js", {scope: "/"})
        if serviceWorker.controller?
            serviceWorker.controller.postMessage("App is version: #{appVersion}!")
        serviceWorker.addEventListener("message", onServiceWorkerMessage)
        serviceWorker.addEventListener("controllerchange", onServiceWorkerSwitch)

    return

############################################################
onServiceWorkerMessage = (evnt) ->
    log("  !  onServiceWorkerMessage")
    if typeof evnt.data == "object" and evnt.data.version?
        serviceworkerVersion = evnt.data.version
        # olog { appVersion, serviceworkerVersion }
        if serviceworkerVersion == appVersion then return
        else if newVersion? and menuVersion?
            newVersion.textContent = serviceworkerVersion
            menuVersion.classList.add("to-update")
    return

onServiceWorkerSwitch = ->
    # console.log("  !  onServiceWorkerSwitch")
    serviceWorker.controller.postMessage("Hello I am version: #{appVersion}!")
    serviceWorker.controller.postMessage("tellMeVersion")
    return
