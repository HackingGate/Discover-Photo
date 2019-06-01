// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let unsplashPhoto = try? newJSONDecoder().decode(UnsplashPhoto.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseUnsplashPhoto { response in
//     if let unsplashPhoto = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - UnsplashPhoto
struct UnsplashPhoto: Codable {
    let id: String
    let createdAt, updatedAt: Date
    let width, height: Int
    let color, unsplashPhotoDescription, altDescription: String?
    let urls: Urls
    let links: UnsplashPhotoLinks
    let sponsored: Bool
    let sponsoredBy: SponsoredBy?
    let sponsoredImpressionsID: String?
    let likes: Int
    let likedByUser: Bool
    let user: SponsoredBy
    let sponsorship: Sponsorship?
    let tags: [Tag]?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width, height, color
        case unsplashPhotoDescription = "description"
        case altDescription = "alt_description"
        case urls, links, sponsored
        case sponsoredBy = "sponsored_by"
        case sponsoredImpressionsID = "sponsored_impressions_id"
        case likes
        case likedByUser = "liked_by_user"
        case user, sponsorship, tags
    }
}
