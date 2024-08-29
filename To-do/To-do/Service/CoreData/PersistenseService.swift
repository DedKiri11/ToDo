//
//  PersistenseService.swift
//  To-do
//
//  Created by Кирилл Зезюков on 29.08.2024.
//

import UIKit
import CoreData

class PersistenseService {
    static var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "ToDo")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
    
    static var context: NSManagedObjectContext {
            return persistentContainer.viewContext
        }
    
    static func saveContext() {
           let context = persistentContainer.viewContext
           if context.hasChanges {
               do {
                   try context.save()
               } catch {
                   let nserror = error as NSError
                   fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
               }
           }
       }
    
}
