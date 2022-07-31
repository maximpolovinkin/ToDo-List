//
//  AddPageViewController.swift
//  ToDo List
//
//  Created by Максим Половинкин on 31.07.2022.
//

import UIKit

class EmptyViewController : UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveTapped))
        let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelTapped))
        
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = cancelButton
        
        title = "Новое дело"
    
        view.backgroundColor = UIColor.white
       
    }
    
    @objc func cancelTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveTapped(){
        
    }
}
    

   
