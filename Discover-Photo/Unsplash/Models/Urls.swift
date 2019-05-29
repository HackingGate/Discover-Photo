// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let urls = try? newJSONDecoder().decode(Urls.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseUrls { response in
//     if let urls = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
}
