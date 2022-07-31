//
//  ViewController.swift
//  ToDo List
//
//  Created by Максим Половинкин on 29.07.2022.
//

import UIKit



class ViewController: UIViewController, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
   
   
    let a = FileCache(a: 1)
    

    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мои дела"
        view.addSubview(table)
        table.dataSource = self
       // table.backgroundColor = UIColor.lightGray
       
        
         
    }
    
    //BETA VERSION
    @objc func addTapped(sender: UIButton!){
        /*
        let alert = UIAlertController(title: "Новое дело", message: "Добавить новую задачу", preferredStyle: .alert)
        alert.addTextField{ field in
            field.placeholder = "Что надо сделать?"
        }
        alert.addAction(UIAlertAction(title: "Готово", style: .default, handler:{ (_) in
            if let field = alert.textFields?.first{
                if let text = field.text, !text.isEmpty{
                    
                    self.a.addTask(id: "1", task: text, deadLine: nil, isCopmplete: false, createDate: Date.now)
                    self.table.reloadData()
                    
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil ))
        present(alert, animated: true)
        */
        
     /*   let addPage = EmptyViewController() as UIViewController
        addPage.modalPresentationStyle = .popover
      
        let popover = addPage.popoverPresentationController
        popover?.delegate = self
        popover?.permittedArrowDirections = .any
        popover?.sourceView = self.view
        popover?.sourceRect = CGRect(x: 100, y: 100, width: 100, height: 100)
        
        

        present(addPage, animated: true, completion: nil)
      
      */
        let rootVC = EmptyViewController()
        let navigationController = UINavigationController(rootViewController: rootVC)
        
        present(navigationController, animated: true)
    }
    
    @objc func addTask(){
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
        addButton()
        
        
    }
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return a.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.lightGray
        cell.textLabel?.text = a.tasks[indexPath.row].task
        return cell
    }
    


}

