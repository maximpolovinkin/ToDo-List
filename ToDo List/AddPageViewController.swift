//
//  AddPageViewController.swift
//  ToDo List
//
//  Created by Максим Половинкин on 31.07.2022.
//

import UIKit

class EmptyViewController : UIViewController, UITableViewDataSource, UIPopoverPresentationControllerDelegate, UITableViewDelegate {
    
   
    
    func deleteButton() {
        let deleteButton = UIButton(frame: CGRect(x: (view.bounds.width / 2) - 189, y: 450 , width: 379, height: 50))
        deleteButton.addTarget(self, action: #selector(bla), for: UIControl.Event.touchUpInside)
        
        deleteButton.setTitle("Удалить", for: .normal)
        deleteButton.backgroundColor = UIColor.white
        deleteButton.titleLabel?.textColor = UIColor.green
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        deleteButton.contentHorizontalAlignment = .center
        deleteButton.layer.cornerRadius = deleteButton.layer.bounds.height / 2
        view.addSubview(deleteButton)
    }
   
    func enterTextField(){
        let mainTextField = UITextView(frame: CGRect(x: (Int(view.bounds.width) / 2) - ((Int(view.bounds.width) - 35) / 2),
                                                      y: 80, width: Int(view.bounds.width) - 35, height: 150))
        
        mainTextField.text = "Что нужно сделать?"
        mainTextField.layer.cornerRadius = 10
        mainTextField.font =  UIFont.systemFont(ofSize: 18)
        mainTextField.backgroundColor = UIColor.white
        
        view.addSubview(mainTextField)
    }
    
     let table: UITableView = {
       
        let table = UITableView(frame: CGRect(x: 18, y: 280, width: 379, height: 200), style: .grouped)
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

        view.addSubview(table)

        table.dataSource = self
        table.delegate = self
        
        deleteButton()
    }
    
    @objc func cancelTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveTapped(){
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    var rowNum = 0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        if rowNum == 0{
            cell.backgroundColor = UIColor.white
            cell.textLabel?.text = "Важность"
            
            let lowButton = UIButton()
            let usuallyButton = UIButton()
            let highButton = UIButton()
           
            lowButton.setTitle("\u{025}", for: .normal)
            usuallyButton.setTitle("нет", for: .normal)
            highButton.setTitle("!!", for: .normal)
            highButton.titleLabel?.textColor = UIColor.red
            
            let prioiryButtons = UIStackView()
           
           // prioiryButtons.addArrangedSubview(lowButton)
           // prioiryButtons.addArrangedSubview(usuallyButton)
         //   prioiryButtons.addArrangedSubview(highButton)
         //   prioiryButtons.tag = indexPath.row
            
            cell.accessoryView = prioiryButtons
            
            rowNum += 1
        } else{
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
    

   
