//
//  ViewController.swift
//  ToDo List
//
//  Created by Максим Половинкин on 29.07.2022.
//

import UIKit
import CoreData

var isEditPressed = false
protocol ViewControllerDelegate {
    func putEfitTapped(editTapped: Bool)
}

class ViewController: UIViewController, UITableViewDataSource,UIPopoverPresentationControllerDelegate, AddPageControllerDelegate,UINavigationControllerDelegate, UITableViewDelegate, NSFetchedResultsControllerDelegate {
  
    var importance = ""
    var editTapped: Bool?
    var deleg: ViewControllerDelegate?
    var numberOfTask = 0
    
    private var dataManager = DataMManager()
    private var fetchResultController: NSFetchedResultsController<Task>!
    
     //MARK:  - Data Work
    func dataWork() {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "task", ascending: true)
       
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataManager.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        try! fetchResultController.performFetch()
    }
    
    func fillTheTableWith(Text: String,  DeadLine Deadline: Date?, Importance: String, isEdit: Bool) {
       
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
        
        let finalTask = importanceSymbol + Text
        
        if isEdit {
            
            if let Deadline = Deadline {
                a.editTask(numberOfTask: numberOfTask, id: "0", task: finalTask, deadLine: Deadline, isCopmplete: false, createDate: .now)
            } else {
                a.editTask(numberOfTask: numberOfTask, id: "0", task: finalTask, deadLine: nil, isCopmplete: false, createDate: .now)
            }
        } else {
            
            if let Deadline = Deadline {
//                a.addTask(id: "0", task: finalTask, deadLine: Deadline, isCopmplete: false, createDate: .now)
                let task = Task(context: dataManager.persistentContainer.viewContext)
                task.task = Text
                task.id = "0"
                task.deadLine = Deadline
                task.isCopmplete = false
                task.createDate = .now
                dataManager.saveContext()
                
            } else {
//                a.addTask(id: "0", task: finalTask, deadLine: nil, isCopmplete: false, createDate: .now)
                let task = Task(context: dataManager.persistentContainer.viewContext)
                task.task = Text
                task.id = "0"
                task.deadLine = nil
                task.isCopmplete = false
                task.createDate = .now
                print(task)
                dataManager.saveContext()
            }
        }
        table.reloadData()
    }
    
    //MARK: fetchResultController Delegate
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if indexPath != nil {
                table.insertRows(at: [indexPath!], with: .automatic)
            }
        case .delete:
            table.deleteRows(at: [indexPath!], with: .fade)
        default:
            break
        }
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
        dataWork()
        fetchResultController.delegate = self
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
        view.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionsInfo = fetchResultController.sections?[section]
        return sectionsInfo?.objects?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let fetchResult = fetchResultController.object(at: indexPath)
        
        cell.backgroundColor = UIColor.white
        cell.textLabel?.text = fetchResult.task
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "⏰ dd MMM yyг."

        if let deadLine = fetchResult.deadLine {
            let dateOfTask = Array(dateFormatter.string(from: deadLine))
            
            if  Int(String(dateOfTask[dateOfTask.count - 3]))! > 2{
                dateFormatter.dateFormat = "⏰ dd MMM yyг."
            } else {
                dateFormatter.dateFormat = "⏰ dd MMM"
            }
            
            cell.textLabel?.text = fetchResult.task
            cell.detailTextLabel?.text = dateFormatter.string(from: deadLine)
            
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor(named: "otherColor")
            cell.detailTextLabel?.textColor = UIColor.red
        } else {
            cell.textLabel?.text = fetchResult.task
        }
        return cell
    }
    var doneCheck = false
    // Right Swipe
        func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let action = UIContextualAction(style: .normal, title: "✅") { [weak self] (action, view, completionHandler) in
                
                if !self!.doneCheck {
                    self?.table.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.systemGray3
                    self?.table.cellForRow(at: indexPath)?.textLabel?.attributedText = NSAttributedString(string: (self?.table.cellForRow(at: indexPath)?.textLabel?.text)!, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
                    self?.doneCheck = true
                    completionHandler(true)
                } else {
                    
                    self?.table.cellForRow(at: indexPath)?.textLabel?.attributedText = NSAttributedString(string: (self?.table.cellForRow(at: indexPath)?.textLabel?.text)!, attributes: [NSAttributedString.Key.strikethroughStyle: nil])
                    
                    self?.table.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor(named: "textColor")
                   
                    self?.doneCheck = false
                    completionHandler(true)
                }
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
            
            self?.dataManager.persistentContainer.viewContext.delete(self!.fetchResultController.object(at: indexPath))
            self?.dataManager.saveContext()
            
        })
        deleteAction.backgroundColor = UIColor.systemRed
        
        return [deleteAction, editAction]
    }
}
