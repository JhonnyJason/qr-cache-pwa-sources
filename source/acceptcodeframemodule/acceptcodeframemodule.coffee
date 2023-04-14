############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("acceptcodeframemodule")
#endregion

############################################################
import * as selection from "./codeselectionmodule.js"

############################################################
export initialize = ->
    log "initialize"
    cancelButton.addEventListener("click", cancelButtonClicked)
    acceptButton.addEventListener("click", acceptButtonClicked)
    return

acceptButtonClicked = ->
    log "acceptButtonClicked"
    content = contentTextarea.value
    label = labelInput.value

    if !content and !label then return cancelButtonClicked()

    if content and !label
        overlayFrame.className = "accepting input-error"
        labelInput.placeholder = "Label is required!"
        return
    
    selection.addCode(label, content)

    contentTextarea.value = ""
    labelInput.value = ""
    labelInput.placeholder = ""
    overlayFrame.className = ""
    return

cancelButtonClicked = ->
    log "cancelButtonClicked"
    contentTextarea.value = ""
    labelInput.value = ""
    labelInput.placeholder = ""
    overlayFrame.className = ""
    return
    
export launch = (code) ->
    log "launch"
    log code
    contentTextarea.value = code
    overlayFrame.className = "accepting"
    return