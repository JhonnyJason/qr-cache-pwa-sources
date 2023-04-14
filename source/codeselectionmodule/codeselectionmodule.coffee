############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("codeselectionmodule")
#endregion

############################################################
import *  as S from "./statemodule.js"
import M from "mustache"

############################################################
import * as addButton from "./addcodebuttonmodule.js"
import * as userModal from "./usermodalmodule.js"
import { displayCode } from "./qrdisplaymodule.js"

############################################################
elementTemplate = ""
addButtonHTML = ""

############################################################
codeObjects = []

############################################################
export initialize = ->
    log "initialize"
    elementTemplate = codeselectionElementTemplate.innerHTML


    numberOfCodes = S.load("numberOfCodes")
    if typeof numberOfCodes != "number"
        numberOfCodes = 0
        S.save("numberOfCodes", numberOfCodes)
    
    codeObjects.length = numberOfCodes
    count = numberOfCodes
    while(count--)
        codeObject = S.load("#{count}")
        codeObjects[count] = codeObject

    addButtonHTML = scrollFrame.innerHTML
    setCurrentElements()
    return

############################################################
createCodeElementHTML = (codeObject) ->
    return M.render(elementTemplate, codeObject)

setCurrentElements = ->
    log "setCurrentElements"
    html = ""
    count = codeObjects.length

    while(count--)
        codeObject = codeObjects[count]
        html += createCodeElementHTML(codeObject)

    html += addButtonHTML
    scrollFrame.innerHTML = html
    attachEventListeners()
    addButton.initialize()
    return

############################################################
attachEventListeners = ->
    log "attachEventListeners"
    buttons = document.getElementsByClassName("show-code-button")
    btn.addEventListener("click", showClicked) for btn in buttons
    buttons = document.getElementsByClassName("delete-code-button")
    btn.addEventListener("click", deleteClicked) for btn in buttons
    return

############################################################
showClicked = (evnt) ->
    log "showClicked"
    element = evnt.target.closest(".element")
    index = element.getAttribute("element-index")
    codeObject = codeObjects[index]
    displayCode(codeObject.content)
    return

deleteClicked = (evnt) ->
    log "deleteClicked"
    element = evnt.target.closest(".element")
    index = element.getAttribute("element-index")
    codeObject = codeObjects[index]
    olog codeObject
    try
        await userModal.userDeleteConfirm()
        deleteCode(index)
    catch err then log err
    return

############################################################
deleteCode = (index) ->
    log "deleteCode"

    codeObjects.splice(index, 1)

    S.remove("#{index}")
    S.save("numberOfCodes", codeObjects.length)

    setCurrentElements()
    return

############################################################
export addCode = (label, content) ->
    log "addCode"
    index = codeObjects.length
    codeObject = {index,label, content}
    codeObjects.push(codeObject)

    S.save("#{index}", codeObject, true)
    S.save("numberOfCodes", codeObjects.length)

    setCurrentElements()    
    return
