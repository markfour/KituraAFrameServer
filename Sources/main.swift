import Foundation
import Kitura
import KituraNet
import KituraSys

let router = Router()

let html = "<!DOCTYPE html><head><script src=\"https://aframe.io/releases/latest/aframe.min.js\"></script></head><body><a-scene><a-cube position=\"-2 1 0\" color=\"#C00\"></a-cube><a-sphere position=\"0 1 0\" color=\"#0C0\"></a-sphere><a-cylinder position=\"2 1 0\" color=\"#00C\"></a-cylinder><a-sky color=\"#EEE\"></a-sky></a-scene></body>"



func constructResourcePathFromSourceLocation(resource: String) -> String {
  let fileName = NSString(string: #file)
  let resourceFilePrefixRange: NSRange
  let lastSlash = fileName.range(of: "/", options: NSStringCompareOptions.backwardsSearch)
  if  lastSlash.location != NSNotFound  {
    resourceFilePrefixRange = NSMakeRange(0, lastSlash.location+1)
  } else {
    resourceFilePrefixRange = NSMakeRange(0, fileName.length)
  }
  return fileName.substring(with: resourceFilePrefixRange) + "resources/" + resource
}

class test {
  func test(t: String) -> String {
    return "tester" + t
  }
  
  func nopram() {
    
  }
}

func noParam() {
  
}

func paramater(_ i :Int) {
  
}

noParam()
paramater(1)

let t = test()

//t.test("s")

router.get("/") {
  request, response, next in
  let aframe = Aframe()
  let responseData = "response"
  response.status(.OK).send(html)
  next()
}

router.get("other") {
  request, response, next in
  let responseData = "other"
  //    response.status(.OK).send(responseData)
  response.status(.OK).send(html)
  next()
}

let htmlFilePath = "index.path"
#if os(Linux)
let fileManager = NSFileManager.defaultManager()
#else
let fileManager = NSFileManager.default()
#endif
//let potentialResource = constructResourcePathFromSourceLocation("abs")
//let fileExists = fileManager.fileExists(atPath: potentialResource)
//if fileExists {
//  print("get file")
//} else {
//  print("no file path")
//}
//print(resourceFileName)

let server = HTTPServer.listen(port: 8090, delegate: router)
Server.run()
