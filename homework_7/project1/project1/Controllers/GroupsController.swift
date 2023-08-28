//
//  GroupsController.swift
//  project1
//
//  Created by Алекс Фитнес on 09.08.2023.
//

import UIKit

final class GroupsController : UITableViewController{
    private let networkService = NetworkService()
    private var models: [Group] = []
    private var fileCache = FileCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        models = fileCache.fetchGroups()
        title = "Groups"
        view.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.backgroundColor = Theme.currentTheme.backgroundColor
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
        tableView.register(GroupCell.self, forCellReuseIdentifier: "GroupCell")
        getGroups()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell else {
            return UITableViewCell()
        }
        let model = models[indexPath.row]
        cell.updateCell(model: model)
        return cell
    }
    

    func getGroups() {
        networkService.getGroups{ [weak self] result in switch result {
        case .success(let groups):
            self?.models = groups
            self?.fileCache.addGroups(groups: groups)
            DispatchQueue.main.async {
                self?.tableView.reloadData()}
            
        case .failure(_):
            self?.models = self?.fileCache.fetchGroups() ?? []
            DispatchQueue.main.async {
                self?.showAlert()
            }
        }
            
        }
    }
}
private extension GroupsController {

    func showAlert(){
        let date = DateHelper.getDate(date: fileCache.fetchGroupdDate())
        let alert = UIAlertController(title: "Проблема с получением данных", message: "Данные актуальны на \(date)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

