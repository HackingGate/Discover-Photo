// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let sponsoredByLinks = try? newJSONDecoder().decode(SponsoredByLinks.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseSponsoredByLinks { response in
//     if let sponsoredByLinks = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - SponsoredByLinks
struct SponsoredByLinks: Codable {
    let linksSelf, html, photos, likes: String?
    let portfolio, following, followers: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, likes, portfolio, following, followers
    }
}
