import Kitura
import KituraNet
import KituraSys

let router = Router()

let html = "<!DOCTYPE html><head><script src=\"https://aframe.io/releases/latest/aframe.min.js\"></script></head><body><a-scene><a-cube position=\"-2 1 0\" color=\"#C00\"></a-cube><a-sphere position=\"0 1 0\" color=\"#0C0\"></a-sphere><a-cylinder position=\"2 1 0\" color=\"#00C\"></a-cylinder><a-sky color=\"#EEE\"></a-sky></a-scene></body>"

struct htmlScheme {
  static let doctype = "<!DOCTYPE html>"
  static let htmlStart = "<html>"
  static let htmlEnd = "</html>"
  static let headStart = "<head>"
  static let headEnd = "</head>"
}

struct Aframe {
  static
  
  var sample: String {
    get {
      return ""
    }
  }
  var title: String?
  var body = ""
}

class testClass {
  func getText() -> String {
    return "myString"
  }
}

router.get("/") {
request, response, next in
//    let html = testClass.myString()
    let b = Book()
    let aframe = Aframe()
    let responseData = "response"
    response.status(.OK).send(b.title)
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
