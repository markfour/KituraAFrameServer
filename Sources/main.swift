import Foundation
import Kitura
import KituraNet
import KituraSys

let router = Router()

let html = "<!DOCTYPE html><head><script src=\"https://aframe.io/releases/latest/aframe.min.js\"></script></head><body><a-scene><a-cube position=\"-2 1 0\" color=\"#C00\"></a-cube><a-sphere position=\"0 1 0\" color=\"#0C0\"></a-sphere><a-cylinder position=\"2 1 0\" color=\"#00C\"></a-cylinder><a-sky color=\"#EEE\"></a-sky></a-scene></body>"

private func test() {

}


// researchDirs("/")

// let potentialResource = constructResourcePathFromSourceLocation(htmlFilePath)
// print("potentialResource \(potentialResource)")
// let fileExists = fileManager.fileExists(atPath: potentialResource)
// print("fileExists \(fileExists)")
// do {
//     try routeResp.send(fileName: resourceFileName)
//     routeResp.status(.OK)
//     try routeResp.end()
// } catch {
//     // Fail silently
// }

private func sendResourceIfExisting(_ routeResp: RouterResponse, resource: String)  {
    guard let resourceFileName = getResourceFilePath(resource) else {
        return
    }

    print("resourceFileName \(resourceFileName)")
    do {
        try routeResp.send(fileName: resourceFileName)
        routeResp.status(.OK)
        try routeResp.end()
    } catch {
        // Fail silently
    }
}

func getResourceFilePath(_ resource: String) -> String? {
#if os(Linux)
    let fileManager = NSFileManager.defaultManager()
#else
    let fileManager = NSFileManager.default()
#endif
    let potentialResource = constructResourcePathFromSourceLocation(resource)

    let fileExists = fileManager.fileExists(atPath: potentialResource)
    if fileExists {
        return potentialResource
    } else {
        return ""
    }
}

public func constructResourcePathFromSourceLocation(_ resource: String) -> String {
  let fileName = NSString(string: #file)
  let resourceFilePrefixRange: NSRange
  let lastSlash = fileName.range(of: "/", options: NSStringCompareOptions.backwardsSearch)
  if  lastSlash.location != NSNotFound  {
    resourceFilePrefixRange = NSMakeRange(0, lastSlash.location+1)
  } else {
    resourceFilePrefixRange = NSMakeRange(0, fileName.length)
  }
//  return fileName.substring(with: resourceFilePrefixRange) + "resources/" + resource
  return fileName.substring(with: resourceFilePrefixRange) + resource
}

router.get("/") {
  request, response, next in
  let aframe = Aframe()
  let responseData = "response"
  // response.status(.OK).send(html)
  // sendResourceIfExisting(response, resource: "sample.html")
  print("get")
  sendResourceIfExisting(response, resource: "sample.html")
  next()
}



router.get("other") {
  request, response, next in
  let responseData = "other"
  response.status(.OK).send(responseData)
  next()
}

let htmlFilePath = "sample.html"
#if os(Linux)
  let fileManager = NSFileManager.defaultManager()
  print("Linux OS")
#else
  let fileManager = NSFileManager.default()
  print("OS X")
#endif


let server = HTTPServer.listen(port: 8090, delegate: router)
Server.run()
