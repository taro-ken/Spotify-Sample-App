//
//  ListViewController.swift
//  Spotify-Sample-App
//
//  Created by 木元健太郎 on 2021/10/04.
//

import UIKit

final class ListViewController: UIViewController {


    @IBOutlet private weak var userName: UILabel!
    @IBOutlet private weak var userUrl: UILabel!

    
      override func viewDidLoad() {
    super.viewDidLoad()
     fetchUserProfile()
}
    
private func fetchUserProfile() {
        API.shared.getCurrentUserProfile { [weak self] result in
            switch result {
            case .success(let model):
                self?.userName.text = model.display_name
                self?.userUrl.text = model.href
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    
}
}

