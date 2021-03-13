//
//  TaskTableViewCell.swift
//  TaskManagement
//
//  Created by 角谷　悠平 on 2021/01/24.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    var tasks = UserDefaults.standard.array(forKey: "TasksKey") as? [[String: Any]] ?? []
    @IBOutlet weak var taskLabel: UILabel!
    
    @IBOutlet weak var deadlineLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    var indexPath = IndexPath()
    
    func setup(task: [String: Any], indexPath: IndexPath) {
        taskLabel.text = tasks[indexPath.row]["taskTitle"] as? String ?? ""
        deadlineLabel.text = tasks[indexPath.row]["deadLine"] as? String ?? ""
        
        let favoriteStatus = tasks[indexPath.row]["isFavorite"] as! Bool
        if favoriteStatus == false {
            let displayStatus = UIImage(systemName: "suit.heart")
            favoriteButton.setImage(displayStatus, for: .normal)
        } else {
            let displayStatus = UIImage(systemName: "suit.heart.fill")
            favoriteButton.setImage(displayStatus, for: .normal)
        }
    }
    
    @IBAction func favoriteSelectDidTap(_ sender: UIButton) {
        var task = tasks[indexPath.row]
        var favoriteStatus = task["isFavorite"] as! Bool
        favoriteStatus.toggle()
        task["isFavorite"] = favoriteStatus
        tasks[indexPath.row] = task
        UserDefaults.standard.set(tasks, forKey: "TasksKey")
        if favoriteStatus == false {
            let displayStatus = UIImage(systemName: "suit.heart")
            favoriteButton.setImage(displayStatus, for: .normal)
        } else {
            let displayStatus = UIImage(systemName: "suit.heart.fill")
            favoriteButton.setImage(displayStatus, for: .normal)
        }
    }
}
