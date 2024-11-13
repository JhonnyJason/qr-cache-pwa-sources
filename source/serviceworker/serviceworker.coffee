import { appVersion } from "./configmodule.js"

############################################################
log = (arg) -> console.log("[serviceworker] #{arg}")

############################################################
appCacheName = "QRcch_app"

############################################################
# This is for the case we need to delete - usually we reuse QRcch_app and update "/" on a new install without deleting everything
# We need to delete the cache if there is an outdated and unused file which would stay in the cache otherwise
cachesToDelete = [
]

############################################################
fixedAppFiles = [
    "/"
    "/manifest.json"
    "/img/fullhd-66-andrew-kliatskyi-tsmO0npD4pY-unsplash.webp"
    "/img/qrcodecache.png"
]

optionalAppFiles = [
    "/android-chrome-192x192.png"
    "/android-chrome-512x512.png"
    "/apple-touch-icon.png"
    "/browserconfig.xml"
    "/favicon.ico"
    "/favicon-16x16.png"
    "/favicon-32x32.png"
    "/mstile-150x150.png"
    "/safari-pinned-tab.svg"
]

############################################################
imageEndings = /.png$|.jpg$|.jpeg$|.webp$|.gif$/

############################################################
urlMatchOptions = {
    ignoreSearch: true
}

############################################################
onRegister = ->
    # ## prod-c log "onRegister"
    # #uncomment for production - comment for testing
    # self.addEventListener('activate', activateEventHandler)
    # self.addEventListener('fetch', fetchEventHandler)
    # self.addEventListener('install', installEventHandler)
    # # #end uncomment for production
    self.addEventListener('message', messageEventHandler)

    # clients = await self.clients.matchAll({ includeUncontrolled: true })
    # message = "postRegister"
    # client.postMessage(message) for client in clients  

    # ## prod-c log "postRegister: found #{clients.length} clients!"
    return

############################################################
#region Event Handlers
activateEventHandler = (evnt) ->
    # ## prod-c log "activateEventHandler"
    evnt.waitUntil(self.clients.claim())
    # ## prod-c log "clients have been claimed!"
    return

 
fetchEventHandler = (evnt) -> 
    # ## prod-c log "fetchEventHandler"
    # log evnt.request.url
    evnt.respondWith(cacheThenNetwork(evnt.request))
    return

installEventHandler = (evnt) -> 
    # ## prod-c log "installEventHandler"
    self.skipWaiting()
    # ## prod-c log "skipped waiting :-)"
    evnt.waitUntil(installAppCache())
    return

messageEventHandler = (evnt) ->
    ## prod-c log "messageEventHandler"
    ## prod-c log "typeof data is #{typeof evnt.data}"
    # log JSON.stringify(evnt.data, null, 4)
    ## prod-c log "I am version #{appVersion}!"

    # Commands to be executed
    if evnt.data == "tellMeVersion"
        # get all available Windoes and tell them the new Version is here :-)
        clients = await self.clients.matchAll({includeUncontrolled: true})
        message = {version: appVersion}
        client.postMessage(message) for client in clients
    
    return

#endregion

############################################################
#region helper functions
installAppCache = ->
    # ## prod-c log "installAppCache"
    try
        await deleteCaches(cachesToDelete)
        cache = await caches.open(appCacheName)
        return cache.addAll(fixedAppFiles)
    catch err then ## prod-c log "Error on installAppCache: #{err.message}"
    return

cacheThenNetwork = (request) ->
    # ## prod-c log "cacheThenNetwork"
    try cacheResponse = await caches.match(request, urlMatchOptions)
    catch err then log err
    if cacheResponse? then return cacheResponse
    else return handleCacheMiss(request)
    return

############################################################
deleteCaches = (cacheNames) ->
    # ## prod-c log "deleteCaches"
    promise = caches.delete(name) for name in cacheNames
    try return await Promise.all(promises)
    catch err then ## prod-c log "Error in deleteCaches: #{err.message}"
    return  
    

############################################################
handleCacheMiss = (request) ->
    # ## prod-c log "handleCacheMiss"
    url = new URL(request.url)
    if isOptionalAppFile(url.pathname) then return handleAppFileMiss(request)
    return fetch(request)
    
############################################################
handleAppFileMiss = (request) ->
    # ## prod-c log "handleAppFileMiss"
    # log request.url
    try return await fetchAndCache(request, appCacheName)
    catch err then ## prod-c log "Error on handleAppFileMiss: #{err.message}"
    return

############################################################
fetchAndCache = (request, cacheName) ->
    cache = await caches.open(cacheName)
    response = await fetch(request) 
    cache.put(request, response.clone())
    return response

############################################################
isOptionalAppFile = (pathname) ->
    # ## prod-c log "isOptionalAppFile"
    # log pathname
    if optionalAppFiles.includes(pathname) then return true
    else return false
    return
    
#endregion


############################################################
onRegister()
