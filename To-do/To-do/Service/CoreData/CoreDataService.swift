//
//  CoreDataService.swift
//  To-do
//
//  Created by Кирилл Зезюков on 29.08.2024.
//

import CoreData
import UIKit

class CoreDataService {
    static var shared = CoreDataService()
    
    private lazy var backgroundContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = PersistenseService.context
        return context
    }()
    
    private func saveContext(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createToDo(todo: ToDoEntity, completion: @escaping () -> (Void)) {
        backgroundContext.perform {
            let newTodo = ToDo(context: PersistenseService.context)
            newTodo.todo = todo.todo
            newTodo.id = Int64(todo.id)
            newTodo.completed = todo.completed
            newTodo.date = Date()
            
            PersistenseService.saveContext()
            completion()
        }
    }
    
    func fetchTodos(completion: @escaping ([ToDoEntity]) -> Void) {
        backgroundContext.perform {
            let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
            do {
                let todos = try PersistenseService.context.fetch(fetchRequest)
                var toDoEntities: [ToDoEntity] = []
                for todo in todos {
                    toDoEntities.append(EntityMapper.toToDoEntity(todo))
                }
                DispatchQueue.main.async {
                    completion(toDoEntities)
                }
            } catch {
                print("Error fetching todos: \(error)")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
    }
    
    func fetchTodo(by id: Int64, completion: @escaping (NSManagedObjectID) -> Void) {
        backgroundContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
            fetchRequest.predicate = NSPredicate(format: "id = %d", id)
            
            let context = PersistenseService.context
            do {
                let results = try context.fetch(fetchRequest)
                if let todo = results.first as? NSManagedObject {
                    DispatchQueue.main.async {
                        completion(todo.objectID)
                        return
                    }
                }
            } catch {
                
            }
        }
    }
    
    func downloadTodos(todos: [ToDoEntity]) {
        for entity in todos {
            let todo = EntityMapper.toToDo(entity)
            
            PersistenseService.saveContext()
        }
    }
    
    func updateToDo(todo: ToDoEntity, completion: @escaping () -> (Void)) {
        backgroundContext.perform {
            self.fetchTodo(by: Int64(todo.id)) { [weak self] objectId in
                guard let self = self else { return }
                do {
                    let objectToUpdate = try self.backgroundContext.existingObject(with: objectId)
                    objectToUpdate.setValue(todo.todo, forKey: "todo")
                    objectToUpdate.setValue(todo.completed, forKey: "completed")
                    
                    self.saveContext(context: self.backgroundContext)
                    completion()
                } catch {
                    print("Error to update: \(error)")
                }
                
            }
            
        }
    }
    
    func deleteToDo(todo: ToDoEntity) {
        backgroundContext.perform {
            self.fetchTodo(by: Int64(todo.id)) { [weak self] objectId in
                guard let self = self else { return }
                do {
                    let objectToDelete = try self.backgroundContext.existingObject(with: objectId)
                    self.backgroundContext.delete(objectToDelete)
                    
                    self.saveContext(context: self.backgroundContext)
                }
                catch {
                    print("Error to delete \(error)")
                }
            }
        }
    }
}
