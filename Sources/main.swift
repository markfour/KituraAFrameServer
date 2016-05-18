import Kitura
import KituraNet
import KituraSys

let router = Router()

let html = "<!DOCTYPE html><head><script src=\"https://aframe.io/releases/latest/aframe.min.js\"></script></head><body><a-scene><a-cube position=\"-2 1 0\" color=\"#C00\"></a-cube><a-sphere position=\"0 1 0\" color=\"#0C0\"></a-sphere><a-cylinder position=\"2 1 0\" color=\"#00C\"></a-cylinder><a-sky color=\"#EEE\"></a-sky></a-scene></body>"

router.get("/") {
request, response, next in
    let responseData = "response"
    response.status(.OK).send(html)
    next()
}

router.get("other") {
request, response, next in
    let responseData = "other"
    response.status(.OK).send(responseData)
    next()
}

let server = HTTPServer.listen(port: 8090, delegate: router)
Server.run()
