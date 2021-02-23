//
//  TaskAddViewController.swift
//  TaskManagement
//
//  Created by 角谷　悠平 on 2021/01/30.
//

import UIKit


class TaskAddViewController: UIViewController {

    var datePicker: UIDatePicker = UIDatePicker()
    
    @IBOutlet weak var taskAddText: UITextField!
    
    @IBOutlet weak var deadlineAddText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicekr()
    
    }
    
    func createDatePicekr() {
        //ピッカーの設定
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        deadlineAddText.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        
        
        //完了バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(title: "完了", style: .plain, target: self, action: #selector(doneDidTap))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        // インプットビュー設定
        deadlineAddText.inputView = datePicker
        deadlineAddText.inputAccessoryView = toolbar
    }
    
    //完了ボタンの動作
    @objc func doneDidTap() {
        deadlineAddText.resignFirstResponder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        deadlineAddText.text = dateFormatter.string(from: Date())
    }
    
    func alert(alertTitle:String, alertMessage:String) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    //戻るボタンの動作
    @IBAction func goBack(_ sender: UIButton) {
        guard let title = taskAddText.text,
              let deadline = deadlineAddText.text,
              !title.isEmpty,
              !deadline.isEmpty
        else {
            alert(alertTitle: "エラー", alertMessage: "適切な値を入力してください。")
            return
        }
        
        let task: [String: Any] = ["taskTitle": title, "deadLine": deadline, "isFavorite": false]
        var sevedTasks = UserDefaults.standard.array(forKey: "TasksKey") as? [[String: Any]] ?? []
        sevedTasks.append(task)
        UserDefaults.standard.set(sevedTasks, forKey: "TasksKey")
        dismiss(animated: true, completion: nil)
    }
    
}
