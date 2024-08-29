//
//  ToDoInteractor.swift
//  To-do
//
//  Created by Кирилл Зезюков on 28.08.2024.
//

import UIKit

class ToDoInteractor: ToDoInteractorProtocol {
    weak var presenter: ToDoPresenterProtocol?
    let db = CoreDataService.shared
    var todos: [ToDoEntity] = CoreDataService.shared.fetchTodos()
    
    func loadTodos() {
        if !todos.isEmpty {
            DispatchQueue.main.async {
                self.retriveTodos()
            }
        } else {
            ToDoAPIService.shared.getData { [weak self] array in
                self?.todos = array
                
                DispatchQueue.main.async {
                    self?.retriveTodos()
                }
                
                self?.db.downloadTodos(todos: self?.todos ?? [])
            }
        }
    }
    
    func deleteFromDb(todo: ToDoEntity) {
        self.db.deleteToDo(todo: todo)
    }
    
    func retriveTodos() {
        presenter?.presentTodos(todos: todos)
    }
}
