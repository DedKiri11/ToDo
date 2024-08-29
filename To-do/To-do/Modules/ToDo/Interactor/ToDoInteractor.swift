//
//  ToDoInteractor.swift
//  To-do
//
//  Created by Кирилл Зезюков on 28.08.2024.
//

import UIKit

class ToDoInteractor: ToDoInteractorProtocol {
    weak var presenter: ToDoPresenterProtocol?
    var todos: [ToDoEntity] = []
    
    func loadTodos() {
        ToDoService.getData { [weak self] array in
            self?.todos = array
            print("Loaded todos: \(array)")
            DispatchQueue.main.async {
                self?.retriveTodos()
            }
        }
    }
    
    func retriveTodos() {
        presenter?.presentTodos(todos: todos)
    }
}
