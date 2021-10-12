//
//  UserDefaults+.swift
//  Spotify-Sample-App
//
//  Created by 木元健太郎 on 2021/10/03.
//

import Foundation


extension UserDefaults {
  private var spotifyAccessTokenKey: String { "spotifyAccessTokenKey" }
  var spotifyAccessToken: String {
    get {
      self.string(forKey: spotifyAccessTokenKey) ?? ""
    }
    set {
      self.setValue(newValue, forKey: spotifyAccessTokenKey)
    }
  }
}
