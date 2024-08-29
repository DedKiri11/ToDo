//
//  ToDoPresenter.swift
//  To-do
//
//  Created by Кирилл Зезюков on 28.08.2024.
//

import UIKit

class ToDoPresenter: ToDoPresenterProtocol {
    weak var view: ToDoViewControllerProtocol!
    var interactor: ToDoInteractorProtocol!
    
    func viewWillAppear() {
        interactor?.loadTodos()
    }
    
    func deleteToDo(todo: ToDoEntity) {
        interactor.deleteFromDb(todo: todo)
    }
    
    func presentTodos(todos: [ToDoEntity]) {
        view.displayTodos(todos)
    }
}
