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
    var indexPath = IndexPath()
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBAction func favoriteSeclectDidTap(_ sender: UIButton) {
        var favoriteStatus = tasks[indexPath.row]["isFavorite"] as! Bool
        favoriteStatus.toggle()
        UserDefaults.standard.set(favoriteStatus, forKey:"isFavorite")

        if favoriteStatus == false {
            let displayStatus = UIImage(systemName: "suit.heart")
            favoriteButton.setImage(displayStatus, for: .normal)
        } else {
            let displayStatus = UIImage(systemName: "suit.heart.fill")
            favoriteButton.setImage(displayStatus, for: .normal)
        }
    }
}
