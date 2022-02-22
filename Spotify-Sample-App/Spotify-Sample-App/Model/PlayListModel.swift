//
//  PlayListModel.swift
//  Spotify-Sample-App
//
//  Created by 木元健太郎 on 2022/02/20.
//

import Foundation


struct PlayListModel: Decodable {
    let items:[item]
}

struct item:Codable {
    var href:String
    var id:String
    var name:String
    var external_urls:ExternalUrl
}

struct ExternalUrl:Codable {
    
    var spotify:String
    
    
    enum CodingKeys: String, CodingKey {
        case spotify = "spotify"
    }
    var url: URL? { URL.init(string: spotify) }
    
}







//{
//  "href": String,
//  "items": [
//    {
//      "collaborative": false,
//      "description": "Best gym workout Mix with EDM and Bass Boosted songs.",
//      "external_urls": {
//        "spotify": "https://open.spotify.com/playlist/5XoGCyXu8TWiHZ701KkhZa"
//      },
//      "href": "https://api.spotify.com/v1/playlists/5XoGCyXu8TWiHZ701KkhZa",
//      "id": "5XoGCyXu8TWiHZ701KkhZa",
//      "images": [
//        {
//          "height": null,
//          "url": "https://i.scdn.co/image/ab67706c0000bebbf6af0551255ce0ab04715c4b",
//          "width": null
//        }
//      ],
//      "name": "Workout EDM 2022 | Motivation",
//      "owner": {
//        "display_name": "Naeleck",
//        "external_urls": {
//          "spotify": "https://open.spotify.com/user/11124443444"
//        },
//        "href": "https://api.spotify.com/v1/users/11124443444",
//        "id": "11124443444",
//        "type": "user",
//        "uri": "spotify:user:11124443444"
//      },
//      "primary_color": null,
//      "public": false,
//      "snapshot_id": "MzM5LDkxNjM5NGM0ZWJjODQ0NTY2ODgxM2MzN2ZlM2Q4ZGRmNWZiYzIxYjU=",
//      "tracks": {
//        "href": "https://api.spotify.com/v1/playlists/5XoGCyXu8TWiHZ701KkhZa/tracks",
//        "total": 74
//      },
//      "type": "playlist",
//      "uri": "spotify:playlist:5XoGCyXu8TWiHZ701KkhZa"
//    }
//  ],
//  "limit": 1,
//  "next": "https://api.spotify.com/v1/users/rsy9hc1r163cx66tu1gilas81/playlists?offset=2&limit=1",
//  "offset": 1,
//  "previous": "https://api.spotify.com/v1/users/rsy9hc1r163cx66tu1gilas81/playlists?offset=0&limit=1",
//  "total": 42
//}
