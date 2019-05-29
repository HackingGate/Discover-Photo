//
//  UnsplashRequest.swift
//  Discover-Photo
//
//  Created by ERU on 2019/05/28.
//  Copyright © 2019 HackingGate. All rights reserved.
//

import Foundation
import Alamofire

class UnsplashRequest {
    
    // API Parameter Abstraction
    // https://github.com/Alamofire/Alamofire/blob/master/Documentation/AdvancedUsage.md#api-parameter-abstraction
    enum Router: URLRequestConvertible {
        case photos(page: Int, perPage: Int)
        case searchPhotos(query: String, page: Int, perPage: Int)
        
        static let baseURLString = Constants.API.URLBase
        static let perPage = 30 // Number of items per page
        
        // MARK: URLRequestConvertible
        
        func asURLRequest() throws -> URLRequest {
            let result: (path: String, parameters: Parameters) = {
                switch self {
                case .photos(let page, let perPage):
                    // List photos API
                    // https://unsplash.com/documentation#list-photos
                    return ("/photos", ["page": page, "per_page": perPage])
                case .searchPhotos(let query, let page, let perPage):
                    // Search API
                    // https://unsplash.com/documentation#search-photos
                    return ("/search/photos", ["query": query, "page": page, "per_page": perPage])
                }
            }()
            
            let url = try Router.baseURLString.asURL()
            var urlRequest = URLRequest(url: url.appendingPathComponent(result.path))
            
            // Custom Header
            // https://stackoverflow.com/a/26055667/4063462
            urlRequest.setValue(Constants.API.AuthorizationValue,
                                forHTTPHeaderField: Constants.API.AuthorizationHeader)
            // API version
            // https://unsplash.com/documentation#version
            urlRequest.setValue(Constants.API.AcceptVersionValue,
                                forHTTPHeaderField: Constants.API.AcceptVersionHeader)
            
            return try URLEncoding.default.encode(urlRequest, with: result.parameters)
        }
    }
    
}
