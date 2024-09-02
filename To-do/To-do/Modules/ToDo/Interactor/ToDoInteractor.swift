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
    var todos: [ToDoEntity] = []
    
    func loadTodos() {
        db.fetchTodos(completion: { [weak self] todos in
            self?.todos = todos
            
            if !todos.isEmpty {
                self?.retriveTodos()
                return
            }
            
            ToDoAPIService.shared.getData { [weak self] array in
                self?.todos = array
                self?.db.downloadTodos(todos: self?.todos ?? [])
                
                self?.retriveTodos()
            }
        })
    }
    
    func createToDo(todo: ToDoEntity) {
        self.db.createToDo(todo: ToDoEntity(id: findNextId(), todo: todo.todo, completed: todo.completed)) { [weak self] in
            self?.db.fetchTodos(completion: { [weak self] todos in
                self?.todos = todos
                
                self?.retriveTodos()
            })
        }
    }
    
    func updateToDo(todo: ToDoEntity) {
        self.db.updateToDo(todo: todo) { [weak self] in
            self?.db.fetchTodos(completion: { [weak self] todos in
                self?.todos = todos
                
                self?.retriveTodos()
            })
        }
    }
    
    func deleteFromDb(todo: ToDoEntity) {
        self.db.deleteToDo(todo: todo)
    }
    
    func retriveTodos() {
        DispatchQueue.main.async {
            self.presenter?.presentTodos(todos: self.todos)
        }
    }
    
    func findNextId() -> Int {
        return (self.todos.map { $0.id }.max() ?? 0) + 1
    }
}
