//
//  Data.swift
//  ToDo List
//
//  Created by Максим Половинкин on 29.07.2022.
//

import Foundation

struct TodoItem{
    
    let id: String
    var task: String
    
    enum Importance{
        case important
        case nonImportant
        case usually
    }
    
    var deadLine: Date?
    var isCopmplete: Bool
    var createDate: Date
    
}

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
