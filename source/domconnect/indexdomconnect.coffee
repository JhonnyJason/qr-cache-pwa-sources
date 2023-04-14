indexdomconnect = {name: "indexdomconnect"}

############################################################
indexdomconnect.initialize = () ->
    global.content = document.getElementById("content")
    global.overlayFrame = document.getElementById("overlay-frame")
    global.scrollFrame = document.getElementById("scroll-frame")
    global.addByScan = document.getElementById("add-by-scan")
    global.addByInput = document.getElementById("add-by-input")
    global.contentTextarea = document.getElementById("content-textarea")
    global.labelInput = document.getElementById("label-input")
    global.cancelButton = document.getElementById("cancel-button")
    global.acceptButton = document.getElementById("accept-button")
    global.usermodal = document.getElementById("usermodal")
    global.useractionFrame = document.getElementById("useraction-frame")
    global.useractionCloseButton = document.getElementById("useraction-close-button")
    global.useractionRejectButton = document.getElementById("useraction-reject-button")
    global.useractionAcceptButton = document.getElementById("useraction-accept-button")
    global.codeselectionElementTemplate = document.getElementById("codeselection-element-template")
    global.qrreaderBackground = document.getElementById("qrreader-background")
    global.qrreaderVideoElement = document.getElementById("qrreader-video-element")
    global.messagebox = document.getElementById("messagebox")
    global.qrdisplayBackground = document.getElementById("qrdisplay-background")
    global.qrdisplayContent = document.getElementById("qrdisplay-content")
    global.qrdisplayQr = document.getElementById("qrdisplay-qr")
    return
    
module.exports = indexdomconnect