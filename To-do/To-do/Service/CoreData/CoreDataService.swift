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
    
    func createToDo(title: String, completed: Bool) {
        let todo = ToDo(context: PersistenseService.context)
        todo.todo = title
        todo.completed = completed
        todo.date = Date()
        
        PersistenseService.saveContext()
    }
    
    func fetchTodos() -> [ToDoEntity] {
        let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        do {
            let todos = try PersistenseService.context.fetch(fetchRequest)
            var toDoEntities: [ToDoEntity] = []
            for todo in todos {
                toDoEntities.append(EntityMapper.toToDoEntity(todo))
            }
            return toDoEntities
        } catch {
            print("Error fetching todos: \(error)")
            return []
        }
    }
    
    func fetchTodo(by id: Int64) -> NSManagedObjectID? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)
        
        let context = PersistenseService.context
        do {
            let results = try context.fetch(fetchRequest)
            if let todo = results.first as? NSManagedObject {
                return todo.objectID
            }
        } catch {
            print("Ошибка при выполнении запроса: \(error)")
        }
        
        return nil
    }
    
    func downloadTodos(todos: [ToDoEntity]) {
        for entity in todos {
            let todo = EntityMapper.toToDo(entity)
            
            PersistenseService.saveContext()
        }
    }
    
    func updateToDo(todo: ToDo, newTitle: String, completed: Bool) {
        todo.todo = newTitle
        todo.completed = completed
        
        PersistenseService.saveContext()
    }
    
    func deleteToDo(todo: ToDoEntity) {
        do {
            guard let objectId = fetchTodo(by: Int64(todo.id)) else { return }
            
            let objectToDelete = try PersistenseService.context.existingObject(with: objectId)
            
            PersistenseService.context.delete(objectToDelete)
            PersistenseService.saveContext()
        } catch {
            print("Ошибка при удалении объекта: \(error)")
        }
    }
}
