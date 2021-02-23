//
//  FavoriteViewController.swift
//  TaskManagement
//
//  Created by 角谷　悠平 on 2021/01/24.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var FavoriteTableView: UITableView!
    var tasks: [[String: Any]] = []


   override func viewDidLoad() {
        super.viewDidLoad()
        FavoriteTableView.delegate = self
        FavoriteTableView.dataSource = self
   }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        tasks = UserDefaults.standard.array(forKey: "TasksKey") as? [[String: Any]] ?? []
        FavoriteTableView.reloadData()
    }

}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FavoriteTableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteTableViewCell
        cell.favoriteLabel.text = tasks[indexPath.row]["taskTitle"] as? String ?? ""
        cell.deadlineLabel.text = tasks[indexPath.row]["deadLine"] as? String ?? ""
        
        return cell
    }
    

}
