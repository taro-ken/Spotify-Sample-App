//
//  SpotifyAccessTokenModel.swift
//  Spotify-Sample-App
//
//  Created by 木元健太郎 on 2021/09/29.
//

import Foundation

struct SpotifyAccessTokenModel: Codable {
    let access_token:String
    let token_type:String
    let scope:String
    let expires_in:Int
    let refresh_token:String
}
