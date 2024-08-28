//
//  ToDoInteractor.swift
//  To-do
//
//  Created by Кирилл Зезюков on 28.08.2024.
//

import UIKit

class ToDoInteractor: ToDoInteractorProtocol {
    var todos: [ToDoEntity] = [ToDoEntity(id:  1, todo: "kacmakldad", completed: true),
                               ToDoEntity(id:  2, todo: "kacmakldad", completed: true),
                               ToDoEntity(id:  3, todo: "kacmakldad", completed: true),
                               ToDoEntity(id:  4, todo: "kacmakldad", completed: true),
                               ToDoEntity(id:  5, todo: "kacmakldad", completed: true)]
    
    func getTodos() -> [ToDoEntity] {
        return todos
    }
}
