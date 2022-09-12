//
//  AddPageViewController.swift
//  ToDo List
//
//  Created by Максим Половинкин on 31.07.2022.
//

import UIKit

protocol AddPageControllerDelegate {
    func fillTheTableWith(Task: String, DeadLine: Date?)
}

class AddPageViewController : UIViewController, UITableViewDataSource, UIPopoverPresentationControllerDelegate, UITableViewDelegate {
    
    let t = ViewController()
    var delegate: AddPageControllerDelegate?
    var taskText = ""
    var mainTextField = UITextField()
    var lowButton = UIButton()
    var usuallyButton = UIButton()
    var highButton = UIButton()
    var date = UITextField()
    let calendar = UIDatePicker()
    let switchView = UISwitch(frame: .zero)
    var selectedIndex = NSIndexPath()
    var deadline: Date?
    
    
    func deleteButton() {
        let deleteButton = UIButton(frame: CGRect(x: (view.bounds.width / 2) - 189, y: 450 , width: 379, height: 50))
        deleteButton.addTarget(self, action: #selector(lowTapped), for: UIControl.Event.touchUpInside)
        
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
        
        delegate?.fillTheTableWith(Task: taskText, DeadLine: deadline)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    var rowNum = 0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
      
        if rowNum == 0 {
            
            cell.backgroundColor = UIColor.white
            cell.textLabel?.text = "Важность"

            let prioiryButtons = UIStackView()
            prioiryButtons.frame.size = CGSize(width: 100, height: 30)
          

            lowButton =  UIButton()
            lowButton.bounds.size = CGSize(width: 40, height: 30)
            lowButton.addTarget(self, action: #selector(lowTapped), for: UIControl.Event.touchUpInside)
            
            usuallyButton =  UIButton()
            usuallyButton.bounds.size = CGSize(width: 40, height: 30)
            usuallyButton.addTarget(self, action: #selector(usuallyTapped), for: UIControl.Event.touchUpInside)
            
            highButton =  UIButton()
            highButton.bounds.size = CGSize(width: 40, height: 30)
            highButton.addTarget(self, action: #selector(highTapped), for: UIControl.Event.touchUpInside)

            lowButton.setTitle("↓", for: .normal)
            lowButton.backgroundColor = UIColor.systemGray5
            lowButton.setTitleColor(UIColor.black, for: .normal)
            //lowButton.layer.borderWidth = 1
            lowButton.layer.cornerRadius = 5
            
            usuallyButton.setTitle("нет", for: .normal)
            usuallyButton.backgroundColor = UIColor.systemGray5
            usuallyButton.setTitleColor(UIColor.black, for: .normal)
           // usuallyButton.layer.borderWidth = 1
            usuallyButton.layer.cornerRadius = 5
            
            highButton.setTitle("‼️", for: .normal)
            highButton.backgroundColor = UIColor.systemGray5
            highButton.setTitleColor(UIColor.red, for: .normal)
           // highButton.layer.borderWidth = 1
            highButton.layer.cornerRadius = 5

            prioiryButtons.addArrangedSubview(lowButton)
            prioiryButtons.addArrangedSubview(usuallyButton)
            prioiryButtons.addArrangedSubview(highButton)
            prioiryButtons.setCustomSpacing(4, after: lowButton)
            prioiryButtons.setCustomSpacing(4, after: usuallyButton)
            prioiryButtons.setCustomSpacing(0, after: highButton)
            prioiryButtons.layer.cornerRadius = 5
            prioiryButtons.backgroundColor = UIColor.systemGray6
            
            cell.accessoryView = prioiryButtons
           
            
            rowNum += 1
        } else {
            
            calendar.datePickerMode = .date
    
            cell.backgroundColor = UIColor.white
            cell.textLabel?.text = "Сделать до"
            cell.textLabel?.numberOfLines = 2
           
           
            switchView.setOn(false, animated: true)
            switchView.tag = indexPath.row // for detect which row switch Changed
            switchView.addTarget(self, action: #selector(timeSwitch), for: .valueChanged)
            
            cell.accessoryView = switchView
            
            cell.addSubview(calendar) // BETA VERSION
 
            calendar.isHidden = true
            
            rowNum = 0
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    @objc func timeSwitch() {
        if switchView.isOn {
            calendar.isHidden = false
            calendar.frame = CGRect(x: 85, y: 4, width: 180, height: 35)
            calendar.preferredDatePickerStyle = .compact
            calendar.locale = .current
            calendar.addTarget(self, action: #selector(timePicked), for: .valueChanged)
            deadline = calendar.date
            
        } else {
            calendar.isHidden = true
            deadline = nil
        }
    }
    
    @objc func lowTapped(){
        lowButton.backgroundColor = UIColor.white
        highButton.backgroundColor = UIColor.systemGray5
        usuallyButton.backgroundColor = UIColor.systemGray5
    }
    
    @objc func usuallyTapped() {
        usuallyButton.backgroundColor = UIColor.white
        highButton.backgroundColor = UIColor.systemGray5
        lowButton.backgroundColor = UIColor.systemGray5
    }
    
    @objc func highTapped() {
        highButton.backgroundColor = UIColor.white
        usuallyButton.backgroundColor = UIColor.systemGray5
        lowButton.backgroundColor = UIColor.systemGray5
    }
    
    @objc func timePicked() {
        deadline = calendar.date
    }

    
}



