//
//  SpotifyAPI.swift
//  Spotify-Sample-App
//
//  Created by 木元健太郎 on 2021/09/28.
//

import Foundation
import Alamofire



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


final class API {
    // シングルトン
    static let shared = API()
    private init() {}
    
    let clientID = "f7515669c76b4ba39f69d0acb585949c" // 自分のclientIDを入れる
    let clientSecret = "c47349123ad447639b6d9ff4f9218e37" // 自分のclientSecretを入れる
    let baseOAuthURL = "https://accounts.spotify.com/authorize"
    let baseAPIURL = "https://api.spotify.com/v1"
    let getTokenEndPoint = "https://accounts.spotify.com/api/token"
    
    let scopes = "user-read-private%20playlist-read-private%20playlist-read-collaborative"
    let redirectURI = "spotifysampleapp://callback" // 設定済みのredirectURIを入れる
    let stateStr = "bb17785d811bb1913ef54b0a7657de780defaa2d"
    let grantType = "authorization_code"
    
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    
    enum  URLParameterName: String {
        case clientID = "client_id"
        case clientSecret = "client_secret"
        case redirectURI = "redirect_uri"
        case grantType = "grant_type"
    }
    
    var oAuthURL: URL {
        return URL(string: "\(baseOAuthURL)?response_type=code&client_id=\(clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)&state=\(stateStr)&show_dialog=TRUE")!
    }
    
    
    
    func postAuthorizationCode(code: String, completion: ((SpotifyAccessTokenModel?, Error?) -> Void)? = nil) {
        
        guard let url = URL(string: getTokenEndPoint) else {
            completion?(nil, APIError.authorizationCodeError)
            return
        }
        
        let basicAuthCode = clientID+":"+clientSecret
        let data = basicAuthCode.data(using: .utf8)
        guard let base64AuthCode = data?.base64EncodedString() else {
            completion?(nil, APIError.authorizationCodeError)
            return
        }
        
        let parameters = [
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": redirectURI
        ]
        
        let getTokenHeaders: HTTPHeaders = [
            "Authorization": "Basic \(base64AuthCode)"
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: getTokenHeaders).responseJSON { (response) in
            
            do {
                guard let _data = response.data else {
                    completion?(nil, APIError.taskError)
                    return
                }
                let accessToken = try JSONDecoder().decode(SpotifyAccessTokenModel.self, from: _data)
                completion?(accessToken, nil)
            } catch let error {
                completion?(nil, error)
            }
        }
    }
    
    func getCurrentUserProfile(completion: @escaping (Result<UserModel, Error>) -> Void) {
        
        guard UserDefaults.standard.spotifyAccessToken != "" else { return }
        
        guard let url = URL(string: baseAPIURL + "/me") else {
            completion(.failure(APIError.urlError))
            return
        }
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDefaults.standard.spotifyAccessToken)"
        ]
        
        AF.request(url, method: .get, headers: headers).responseJSON { (response) in
            do {
                guard let _data = response.data else { return }
                let result = try JSONDecoder().decode(UserModel.self, from: _data)
                print(result)
                completion(.success(result))
            } catch let error {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    
    func getPlayList(completion: @escaping (Result<[item], Error>) -> Void) {
        
        guard UserDefaults.standard.spotifyAccessToken != "" else { return }
        
        guard let url = URL(string: baseAPIURL + "/me/playlists") else {
            completion(.failure(APIError.urlError))
            return
        }
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDefaults.standard.spotifyAccessToken)"
        ]
        
        AF.request(url, method: .get, headers: headers).responseJSON { (response) in
            do {
                guard let _data = response.data else { return }
                let item = try JSONDecoder().decode(PlayListModel.self, from: _data)
                let result = item.items
                completion(.success(result))
            } catch let error {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
