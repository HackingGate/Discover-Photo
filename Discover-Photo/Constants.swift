//
//  Constants.swift
//  Discover-Photo
//
//  Created by ERU on 2019/05/28.
//  Copyright © 2019 HackingGate. All rights reserved.
//

import Foundation

struct Constants {
    
    struct API {
        // https://unsplash.com/documentation#schema
        
        static let AuthorizationHeader = "Authorization"
        static let AcceptVersionHeader = "Accept-Version"
        static let AuthorizationValue = "Client-ID" + " " + API.accessKey
        static let AcceptVersionValue = "v1"

        static let URLBase = "https://api.unsplash.com"
        static let accessKey = "2b3e40a2d929f902ba6b7e0e4956e83036edfe570c17a6647ca3a0cdc313c689"
        static let secretKey = "ade7b367a97d55c9e5db7594a21733e429fefdcaf791889725df47dedf46b517"
        
//        static let photos = API.URLBase + "photos"
//        static let search = API.URLBase + "search"
    }
    
}
