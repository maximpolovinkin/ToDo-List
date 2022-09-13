//
//  JSONWork.swift
//  ToDo List
//
//  Created by Максим Половинкин on 05.09.2022.
//

import Foundation

extension TodoItem{
    static func parse(json: Any) -> TodoItem?{
        guard let id = json as? String,
              let task = json as? String,
              let isCopmlete = json as? Bool,
              let createDate = json as? Date,
              let deadLine = json as? Date
        else{
            return nil
        }
        
     return self.init(id: id, task: task, deadLine: deadLine, isCopmplete: isCopmlete, createDate: createDate)

    }
    
    var json: Any{
        //sdas
        return 0
    }
}


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



