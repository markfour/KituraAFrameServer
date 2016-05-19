import SwiftyJSON

struct htmlScheme {
  static let doctype = "<!DOCTYPE html>"
  static let htmlStart = "<html>"
  static let htmlEnd = "</html>"
  static let headStart = "<head>"
  static let head = "<script src=\"https://aframe.io/releases/latest/aframe.min.js\">"
  static let headEnd = "</head>"
  static let aSenceStart = "<a-scene>"
//  static let a
}

struct Aframe {
  var sample: String {
    get {
      return ""
    }
  }
  var title: String?
  var body = ""
}


