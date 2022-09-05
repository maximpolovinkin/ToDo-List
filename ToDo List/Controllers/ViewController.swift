//
//  ViewController.swift
//  ToDo List
//
//  Created by Максим Половинкин on 29.07.2022.
//

import UIKit


var saveTap = false

class ViewController: UIViewController, UITableViewDataSource,UIPopoverPresentationControllerDelegate, AddPageControllerDelegate,UINavigationControllerDelegate {
    
    func fillTheTableWith(Task: String) {
        a.addTask(id: "0", task: Task, deadLine: .now, isCopmplete: false, createDate: .now)
        table.reloadData()
    }
    
   
    var cellText = ""
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
        return table
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мои дела"
       
        view.backgroundColor = UIColor.systemGray6
        
        view.addSubview(table)
        table.dataSource = self
       
        
    }
    
   
    @objc func addTapped(sender: UIButton!){
        
        let rootVC = AddPageViewController()
        let navigationController = UINavigationController(rootViewController: rootVC)
        rootVC.delegate = self
        
        present(navigationController, animated: true)
    }
     
    func add(text: String){
        self.a.addTask(id: "1", task: text, deadLine: nil, isCopmplete: false, createDate: Date.now)
        self.table.reloadData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
        addButton()
        table.reloadData()
        add(text: cellText)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print( a.tasks.count)
        return a.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.white
        cell.textLabel?.text = a.tasks[indexPath.row].task
        return cell
    }
    
   
    


}

