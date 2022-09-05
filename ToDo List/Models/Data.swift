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
