//
//  ListViewController.swift
//  Spotify-Sample-App
//
//  Created by 木元健太郎 on 2021/10/04.
//

import UIKit

final class ListViewController: UIViewController {
    
    private let cellID = "UITableViewCell"
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private var playListModel:[item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API.shared.getPlayList { [weak self] result in
            switch result {
            case .success(let model):
                self?.playListModel = model
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = playListModel[indexPath.row].external_urls.url,
              UIApplication.shared.canOpenURL(url) else {
                  return
              }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playListModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) else {
            fatalError()
        }
        
        let item = playListModel[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
}
