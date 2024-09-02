//
//  EntityMapper.swift
//  To-do
//
//  Created by Кирилл Зезюков on 29.08.2024.
//

import Foundation
import CoreData

class EntityMapper {
    static func toToDoEntity(_ todo: ToDo) -> ToDoEntity {
        return ToDoEntity(
            id: Int(todo.id),
            todo: todo.todo ?? "",
            completed: todo.completed,
            date: todo.date ?? Date())
    }
    
    static func toToDo(_ todo: ToDoEntity) -> ToDo {
        let todoDb = ToDo(context: PersistenseService.context)
        todoDb.id = Int64(todo.id)
        todoDb.todo = todo.todo
        todoDb.completed = todo.completed
        todoDb.date = todo.date
        return todoDb
    }
}
