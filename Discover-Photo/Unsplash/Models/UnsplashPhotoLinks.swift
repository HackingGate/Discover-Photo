// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let unsplashPhotoLinks = try? newJSONDecoder().decode(UnsplashPhotoLinks.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseUnsplashPhotoLinks { response in
//     if let unsplashPhotoLinks = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - UnsplashPhotoLinks
struct UnsplashPhotoLinks: Codable {
    let linksSelf, html, download, downloadLocation: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}
