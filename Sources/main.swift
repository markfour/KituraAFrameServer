import Foundation
import Kitura
import KituraNet
import KituraSys

let router = Router()

func sendResourceIfExisting(_ routeResp: RouterResponse, resource: String)  {
    guard let resourceFileName = getResourceFilePath(resource) else {
        return
    }

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

func constructResourcePathFromSourceLocation(_ resource: String) -> String {
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
  sendResourceIfExisting(response, resource: "sample.html")
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
