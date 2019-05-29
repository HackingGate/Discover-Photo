// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let sponsorship = try? newJSONDecoder().decode(Sponsorship.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseSponsorship { response in
//     if let sponsorship = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - Sponsorship
struct Sponsorship: Codable {
    let impressionsID, tagline: String
    let sponsor: SponsoredBy

    enum CodingKeys: String, CodingKey {
        case impressionsID = "impressions_id"
        case tagline, sponsor
    }
}
