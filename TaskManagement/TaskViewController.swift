//
//  ViewController.swift
//  TaskManagement
//
//  Created by 角谷　悠平 on 2021/01/24.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet weak var taskTableView: UITableView!
    var tasks: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTableView.delegate = self
        taskTableView.dataSource = self
    }
    
    //画面表示時直前にテーブルビューの更新とセーブ
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        tasks = UserDefaults.standard.array(forKey: "TasksKey") as? [[String: Any]] ?? []
        taskTableView.reloadData()
    }
    
    //タスク追加画面に移動
    @IBAction func taskAddDidTap(_ sender: UIButton) {
        let taskAddViewController = storyboard?.instantiateViewController(withIdentifier: "TaskAddViewController")
        present(taskAddViewController!, animated: true, completion: nil)
    }
}

extension TaskViewController: UITableViewDelegate, UITableViewDataSource {
    //行数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    //セルを作成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        cell.taskLabel.text = tasks[indexPath.row]["taskTitle"] as? String ?? ""
        cell.deadlineLabel.text = tasks[indexPath.row]["deadLine"] as? String ?? ""
        cell.indexPath = indexPath
        cell.setup(task: tasks[indexPath.row], indexPath: cell.indexPath)
        
        return cell
    }
    
    //セルを削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            tasks.remove(at: indexPath.row)
            UserDefaults.standard.set(tasks,forKey: "TasksKey")
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    //セルを削除するボタンの表記
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "削除"
    }
}


