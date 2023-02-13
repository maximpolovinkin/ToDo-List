//
//  Data.swift
//  ToDo List
//
//  Created by Максим Половинкин on 13.02.2023.
//

import Foundation

struct TodoItem {
    
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
