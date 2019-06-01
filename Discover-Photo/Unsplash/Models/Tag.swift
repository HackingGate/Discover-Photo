// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let tag = try? newJSONDecoder().decode(Tag.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseTag { response in
//     if let tag = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - Tag
struct Tag: Codable {
    let title: String
}
