//
//  FavoriteViewController.swift
//  TaskManagement
//
//  Created by 角谷　悠平 on 2021/01/24.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var FavoriteTableView: UITableView!
    var favoriteTasks: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FavoriteTableView.delegate = self
        FavoriteTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        let tasks = UserDefaults.standard.array(forKey: "TasksKey") as? [[String: Any]] ?? []
        favoriteTasks = favoriteFilter(FilterList: tasks)
        FavoriteTableView.reloadData()
    }
    
    func favoriteFilter(FilterList: [[String: Any]]) -> [[String: Any]] {
        var favoriteTasks :[[String: Any]] = []
        for favorite in FilterList {
            let favoriteStatus = favorite["isFavorite"] as! Bool
            if favoriteStatus == true {
                favoriteTasks.append(favorite)
            }
        }
        return favoriteTasks
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FavoriteTableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteTableViewCell
        cell.favoriteLabel.text = favoriteTasks[indexPath.row]["taskTitle"] as? String ?? ""
        cell.deadlineLabel.text = favoriteTasks[indexPath.row]["deadLine"] as? String ?? ""
        
        return cell
    }
}
