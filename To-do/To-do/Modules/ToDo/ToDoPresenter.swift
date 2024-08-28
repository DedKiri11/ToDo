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
    
    func presentTodos() {
        view.displayTodos(interactor.getTodos())
    }
}
