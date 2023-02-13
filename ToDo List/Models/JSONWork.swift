//
//  JSONWork.swift
//  ToDo List
//
//  Created by Максим Половинкин on 13.02.2023.
//

import Foundation

class FileCache {
    
    var tasks = [TodoItem]()
    var a: Int
    
    func addTask(id: String, task: String, deadLine: Date?, isCopmplete: Bool, createDate: Date){
        if let deadLine = deadLine {
            let newTask = TodoItem(id: id, task: task, deadLine: deadLine, isCopmplete: isCopmplete, createDate: createDate)
            tasks.append(newTask)
            
        } else {
            let newTask = TodoItem(id: id, task: task, isCopmplete: isCopmplete, createDate: createDate)
            tasks.append(newTask)
        }
    }
    
    func editTask(numberOfTask: Int, id: String, task: String, deadLine: Date?, isCopmplete: Bool, createDate: Date){
        if let deadLine = deadLine {
            tasks[numberOfTask] = TodoItem(id: id, task: task, deadLine: deadLine, isCopmplete: isCopmplete, createDate: createDate)
            
            
        } else {
            tasks[numberOfTask] = TodoItem(id: id, task: task, isCopmplete: isCopmplete, createDate: createDate)
            
        }
    }
    
    func deleteTask(Id: String){
        for i in 0..<tasks.count{
            if tasks[i].id == Id{
                tasks.remove(at: i)
                return
            }
        }
        
    }
    
    init(a: Int){
        self.a = a
    }
}



