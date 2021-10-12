//
//  RefreshTokenModel.swift
//  Spotify-Sample-App
//
//  Created by 木元健太郎 on 2021/10/10.
//

import Foundation

struct RefreshTokenModel:Codable{
    let access_token:String
    let token_type: String
    let scope:String
    let expires_in:Int
}
