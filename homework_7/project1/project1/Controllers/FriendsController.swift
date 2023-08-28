//
//  FriendsController.swift
//  project1
//
//  Created by Алекс Фитнес on 09.08.2023.
//

import UIKit

final class FriendsController : UITableViewController{
    
    private let networkService: NetworkServiceProtocol
    private var models: [Friend]
    private var fileCache: FileCacheProtocol
    
    
    init(networkService: NetworkServiceProtocol, models: [Friend], fileCache: FileCacheProtocol) {
        self.networkService = networkService
        self.models = models
        self.fileCache = fileCache
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        models = fileCache.fetchFriends()
        tableView.reloadData()
        title = "Friends"
        view.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.backgroundColor = Theme.currentTheme.backgroundColor
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(tap))
        tableView.register(FriendCell.self, forCellReuseIdentifier: "FriendCell")
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(update), for: .valueChanged)
        getFriends()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendCell else {
            return UITableViewCell()
        }
        let model = models[indexPath.row]
        cell.updateCell(model: model)
        cell.tap = { [weak self]  text, photo in self?.navigationController?.pushViewController(ProfileController(name: text, photo: photo, isUserProfile: false), animated: true)}
        return cell
    }

    func getFriends() {
        networkService.getFriends { [weak self] result
            in
            switch result {
            case .success(let friends):
                self?.models = friends
                self?.fileCache.addFriends(friends: friends)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                self?.models = self?.fileCache.fetchFriends() ?? []
                DispatchQueue.main.async {
                    self?.showAlert()
                }
            }
        }
    }
}

private extension FriendsController {

    private func showAlert(){
        let date = DateHelper.getDate(date: fileCache.fetchFriendDate())
        let alert = UIAlertController(title: "Проблема с получением данных", message: "Данные актуальны на \(date)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    @objc func tap() {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.type = .moveIn
        animation.duration = 3
        navigationController?.view.layer.add(animation, forKey: nil)
        navigationController?.pushViewController(ProfileController(isUserProfile: true), animated: false)
    }
    

    @objc func update() {
        networkService.getFriends{ [weak self] result in switch result {
        case .success(let friends):
            self?.models = friends
            self?.fileCache.addFriends(friends: friends)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        case .failure(_):
            self?.models = self?.fileCache.fetchFriends() ?? []
            DispatchQueue.main.async {
                self?.showAlert()
            }
        }
            DispatchQueue.main.async {
                self?.refreshControl?.endRefreshing()
            }
        }
    }
}
