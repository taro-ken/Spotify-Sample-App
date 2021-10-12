//
//  UserProfile.swift
//  Spotify-Sample-App
//
//  Created by 木元健太郎 on 2021/10/03.
//

import Foundation

struct UserModel: Decodable {
    var display_name: String
    var href:String
    
    
    enum CodingKeys: String, CodingKey {
        case display_name = "display_name"
        case href = "href"
        
    }
    var url: URL? { URL.init(string: href) }
}




