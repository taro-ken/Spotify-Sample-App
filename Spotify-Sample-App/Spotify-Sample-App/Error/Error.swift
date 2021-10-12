//
//  Error.swift
//  Spotify-Sample-App
//
//  Created by 木元健太郎 on 2021/09/28.
//

import Foundation

enum APIError: Error, LocalizedError {

    case authorizationCodeError, urlError, taskError

    var errorDescription: String? {
        switch self {
        case .authorizationCodeError:
            return "認証エラーが発生しています"
        case .urlError:
            return "URLが取得出来ませんでした"
        case .taskError:
            return "データの取得が出来ませんでした"
        }
    }
}


