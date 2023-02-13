//
//  Task+CoreDataProperties.swift
//  ToDo List
//
//  Created by Максим Половинкин on 13.02.2023.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id: String?
    @NSManaged public var task: String?
    @NSManaged public var importance: String?
    @NSManaged public var deadLine: Date?
    @NSManaged public var isCopmplete: Bool
    @NSManaged public var createDate: Date?

}

extension Task : Identifiable {

}
