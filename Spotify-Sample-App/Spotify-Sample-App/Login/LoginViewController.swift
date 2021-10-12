//
//  ViewController.swift
//  Spotify-Sample-App
//
//  Created by 木元健太郎 on 2021/09/28.
//

import UIKit

final class LoginViewController: UIViewController {

    @IBOutlet private weak var authButton: UIButton! {
        didSet {
            authButton.addTarget(self, action: #selector(tapAuthButton), for: .touchUpInside)
        }
    }
    
    @objc private func tapAuthButton(){
        UIApplication.shared.open(API.shared.oAuthURL,options: [:])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    func openURL(url: URL) {
        guard let queryItems = URLComponents(string: url.absoluteString)?.queryItems,
              let code = queryItems.first(where: {$0.name == "code"})?.value,
              let getState = queryItems.first(where: {$0.name == "state"})?.value,
              getState == API.shared.stateStr
        else {
            return
        }

    // `code`を引数として渡して、トークンリクエストをする
        API.shared.postAuthorizationCode(code: code) { accessToken, error in
            if let _error = error {
                print(_error.localizedDescription)
                return
            }
            guard let _accessToken = accessToken,
                  let vc = UIStoryboard.init(name: "List", bundle: nil).instantiateInitialViewController()
                  else {
                return
            }
        // キーを保持
            UserDefaults.standard.spotifyAccessToken = _accessToken.access_token
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

