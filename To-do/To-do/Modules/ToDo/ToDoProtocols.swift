//
//  ToDoProtocols.swift
//  To-do
//
//  Created by Кирилл Зезюков on 28.08.2024.
//

import Foundation

protocol ToDoViewControllerProtocol: AnyObject {
    func displayTodos(_ todos: [ToDoEntity])
}

protocol ToDoPresenterProtocol: AnyObject {
    func presentTodos()
}

protocol ToDoInteractorProtocol: AnyObject {
    func getTodos() -> [ToDoEntity]
}

protocol ToDoRouterProtocol: AnyObject {
    static func createModule() -> ToDoViewController
}
