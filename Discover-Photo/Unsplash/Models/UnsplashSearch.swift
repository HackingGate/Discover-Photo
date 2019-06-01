// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let unsplashSearch = try? newJSONDecoder().decode(UnsplashSearch.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseUnsplashSearch { response in
//     if let unsplashSearch = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - UnsplashSearch
struct UnsplashSearch: Codable {
    let total, totalPages: Int
    let results: [UnsplashPhoto]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}
