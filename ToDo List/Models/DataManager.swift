//
//  DataMManager.swift
//  ToDo List
//
//  Created by Максим Половинкин on 13.02.2023.
//

import Foundation
import CoreData

class DataMManager {
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "tasksModel")
        container.loadPersistentStores { storeDiscription, error in
            if let error = error as NSError?{
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
     //MARK: - Core Data Saving Support
    func saveContext(){
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do{
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
