//
//  AddPageViewController.swift
//  ToDo List
//
//  Created by Максим Половинкин on 31.07.2022.
//

import UIKit

protocol AddPageControllerDelegate {
    func fillTheTableWith(Task: String)
}

class AddPageViewController : UIViewController, UITableViewDataSource, UIPopoverPresentationControllerDelegate, UITableViewDelegate {
    
    let t = ViewController()
    var delegate: AddPageControllerDelegate?
    var taskText = ""
    var mainTextField = UITextField()
    
    func deleteButton() {
        let deleteButton = UIButton(frame: CGRect(x: (view.bounds.width / 2) - 189, y: 450 , width: 379, height: 50))
        deleteButton.addTarget(self, action: #selector(bla), for: UIControl.Event.touchUpInside)
        
        deleteButton.setTitle("Удалить", for: .normal)
        deleteButton.backgroundColor = UIColor.white
        deleteButton.setTitleColor(UIColor.red, for: .normal)
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        deleteButton.contentHorizontalAlignment = .center
        deleteButton.layer.cornerRadius = deleteButton.layer.bounds.height / 2
        view.addSubview(deleteButton)
    }
    
   
    func enterTextField(){
         mainTextField = UITextField(frame: CGRect(x: (Int(view.bounds.width) / 2) - ((Int(view.bounds.width) - 35) / 2),
                                                     y: 80, width: Int(view.bounds.width) - 35, height: 150))
        
        mainTextField.placeholder = "Что нужно сделать?"
        mainTextField.textAlignment = .left
        mainTextField.contentVerticalAlignment = .top
        mainTextField.layer.cornerRadius = 10
        mainTextField.font =  UIFont.systemFont(ofSize: 18)
        mainTextField.backgroundColor = UIColor.white
       print( (Int(view.bounds.width) / 2) - ((Int(view.bounds.width) - 35) / 2))
        view.addSubview(mainTextField)
    }
    
    let table1: UITableView = {
        
        let table = UITableView(frame: CGRect(x: 0, y: 280, width: 390, height: 200), style: .insetGrouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveTapped))
        let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelTapped))
        
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = cancelButton
        
        title = "Новое дело"
        enterTextField()
        view.backgroundColor = UIColor.systemGray6
        
        view.addSubview(table1)
        table1.dataSource = self
       
        deleteButton()
    }
    
    @objc func cancelTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveTapped(){
        taskText = mainTextField.text ?? "нет задачи"
        print(taskText)
        
        delegate?.fillTheTableWith(Task: taskText)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    var rowNum = 0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
      
        if rowNum == 0 {
            
            cell.backgroundColor = UIColor.white
            cell.textLabel?.text = "Важность"

            let prioiryButtons = UIStackView()
            prioiryButtons.frame.size = CGSize(width: 100, height: 30)
          

            let lowButton =  UIButton()
            lowButton.bounds.size = CGSize(width: 40, height: 30)
          
            
            let usuallyButton =  UIButton()
            lowButton.bounds.size = CGSize(width: 40, height: 30)
            
            let highButton =  UIButton()
            lowButton.bounds.size = CGSize(width: 40, height: 30)

            lowButton.setTitle("\u{024}", for: .normal)
            lowButton.backgroundColor = UIColor.systemGray5
            lowButton.setTitleColor(UIColor.black, for: .normal)
            
            usuallyButton.setTitle("нет", for: .normal)
            usuallyButton.backgroundColor = UIColor.systemGray5
            usuallyButton.setTitleColor(UIColor.black, for: .normal)
            
            highButton.setTitle("!!", for: .normal)
            highButton.backgroundColor = UIColor.systemGray5
            highButton.setTitleColor(UIColor.red, for: .normal)

          
            
         
            
            prioiryButtons.addArrangedSubview(usuallyButton)
            prioiryButtons.addArrangedSubview(lowButton)
            prioiryButtons.addArrangedSubview(highButton)
            prioiryButtons.setCustomSpacing(1, after: lowButton)
            prioiryButtons.setCustomSpacing(2, after: usuallyButton)
            prioiryButtons.setCustomSpacing(0, after: highButton)

            prioiryButtons.backgroundColor = UIColor.systemGray5
            
            cell.accessoryView = prioiryButtons
            
            rowNum += 1
        } else {
            
            cell.backgroundColor = UIColor.white
            cell.textLabel?.text = "Сделать до"
            
            let switchView = UISwitch(frame: .zero)
            switchView.setOn(false, animated: true)
            switchView.tag = indexPath.row // for detect which row switch Changed
            switchView.addTarget(self, action: #selector(bla), for: .valueChanged)
            cell.accessoryView = switchView
            
            rowNum = 0
        }
        
        return cell
    }
    
    @objc func bla(){
        
    }
    
    
}



