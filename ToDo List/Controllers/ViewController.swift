//
//  ViewController.swift
//  ToDo List
//
//  Created by Максим Половинкин on 29.07.2022.
//

import UIKit

var isEditPressed = false
protocol ViewControllerDelegate {
    func putEfitTapped(editTapped: Bool)
}

class ViewController: UIViewController, UITableViewDataSource,UIPopoverPresentationControllerDelegate, AddPageControllerDelegate,UINavigationControllerDelegate, UITableViewDelegate {
  
    var importance = ""
    var editTapped: Bool?
    var deleg: ViewControllerDelegate?
    var numberOfTask = 0
    
    func fillTheTableWith(Task: String,  DeadLine Deadline: Date?, Importance: String, isEdit: Bool) {
       
        importance = Importance
        var importanceSymbol = ""
        switch importance {
        case "low": importanceSymbol = "↓"
            break
        case "high": importanceSymbol = "‼️"
            break
        default:
            importanceSymbol = ""
        }
        
        let finalTask = importanceSymbol + Task
        
        if isEdit {
            
            if let Deadline = Deadline {
                a.editTask(numberOfTask: numberOfTask, id: "0", task: finalTask, deadLine: Deadline, isCopmplete: false, createDate: .now)
                
            } else {
                a.editTask(numberOfTask: numberOfTask, id: "0", task: finalTask, deadLine: nil, isCopmplete: false, createDate: .now)
            }
        } else {
            
            if let Deadline = Deadline {
                a.addTask(id: "0", task: finalTask, deadLine: Deadline, isCopmplete: false, createDate: .now)
                
            } else {
                a.addTask(id: "0", task: finalTask, deadLine: nil, isCopmplete: false, createDate: .now)
            }
        }
        table.reloadData()
    }
    
    var delegate = UITableViewDelegate.self
    let a = FileCache(a: 1)
   
    func addButton() {
        let addButton = UIButton(frame: CGRect(x: (view.bounds.width / 2) - 24, y: view.bounds.height - 96 , width: 48, height: 48))
        addButton.addTarget(self, action: #selector(addTapped), for: UIControl.Event.touchUpInside)
        
        addButton.setTitle("+", for: .normal)
        addButton.backgroundColor = UIColor.systemBlue
        addButton.titleLabel?.textColor = UIColor.white
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 38)
        addButton.contentVerticalAlignment = .top
        addButton.contentHorizontalAlignment = .center
        addButton.layer.cornerRadius = addButton.layer.bounds.height / 2
        view.addSubview(addButton)
    }

     let table: UITableView = {
         let table = UITableView(frame: CGRect(), style: .insetGrouped)
         table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
         table.rowHeight = 60
         
         return table
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мои дела"
       
        view.backgroundColor = UIColor.systemGray6
        
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
    }
    
    @objc func addTapped(sender: UIButton!){
        
        let rootVC = AddPageViewController()
        let navigationController = UINavigationController(rootViewController: rootVC)
        rootVC.delegate = self
        
        present(navigationController, animated: true)
    }
     
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
        addButton()
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return a.tasks.count
    }
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.backgroundColor = UIColor.white
        cell.textLabel?.text = a.tasks[indexPath.row].task
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "⏰ dd MMM yyг."
       
        
        if let deadLine = a.tasks[indexPath.row].deadLine {
            let dateOfTask = Array(dateFormatter.string(from: deadLine))
            
            if  Int(String(dateOfTask[dateOfTask.count - 3]))! > 2{
                dateFormatter.dateFormat = "⏰ dd MMM yyг."
            } else {
                dateFormatter.dateFormat = "⏰ dd MMM"
            }
            
            cell.textLabel?.text! = a.tasks[indexPath.row].task
            cell.detailTextLabel?.text = dateFormatter.string(from: deadLine)
            cell.detailTextLabel?.textColor = UIColor.red
        } else {
          
            cell.textLabel?.text! = a.tasks[indexPath.row].task
        }
        cell.selectionStyle = .none
        return cell
    }
    
    // Right Swipe
        func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
            let action = UIContextualAction(style: .normal, title: "✅") { [weak self] (action, view, completionHandler) in
                
                self?.table.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.systemGray3
                self?.table.cellForRow(at: indexPath)?.textLabel?.attributedText = NSAttributedString(string: (self?.table.cellForRow(at: indexPath)?.textLabel?.text)!, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
                completionHandler(true)
            }
            action.backgroundColor = .systemGreen
            
            return UISwipeActionsConfiguration(actions: [action])
        }
        
      
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        // action one
        let editAction = UITableViewRowAction(style: .default, title: "ⓘ", handler: {[weak self] (action, indexPath) in
            let rootVC = AddPageViewController()
            let navigationController = UINavigationController(rootViewController: rootVC)
            rootVC.delegate = self.self
            
            DispatchQueue.global().async {
                self?.numberOfTask = indexPath.row
            }
            
            isEditPressed = true
          
            self?.present(navigationController, animated: true)
            print("Edit tapped")
        })
        editAction.backgroundColor = UIColor.systemGray4
        

        // action two
        let deleteAction = UITableViewRowAction(style: .default, title: "🗑", handler: {[weak self] (action, indexPath) in
           
            self?.a.tasks.remove(at: indexPath.row)
            // delete the table view row
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        })
        deleteAction.backgroundColor = UIColor.systemRed
        
        return [deleteAction, editAction]
    }
    
   
}
