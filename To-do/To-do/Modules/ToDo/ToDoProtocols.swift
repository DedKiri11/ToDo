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
    func deleteToDo(todo: ToDoEntity)
    func viewWillAppear()
    func presentTodos(todos: [ToDoEntity])
}

protocol ToDoInteractorProtocol: AnyObject {
    func loadTodos()
    func deleteFromDb(todo: ToDoEntity)
    func retriveTodos()
}

protocol ToDoRouterProtocol: AnyObject {
    static func createModule() -> ToDoViewController
}
