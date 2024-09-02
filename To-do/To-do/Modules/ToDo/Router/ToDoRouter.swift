//
//  ToDoRouter.swift
//  To-do
//
//  Created by Кирилл Зезюков on 28.08.2024.
//

import UIKit

class ToDoRouter: ToDoRouterProtocol {
    static func createModule() -> ToDoViewController {
        let view = ToDoViewController()
        let presenter = ToDoPresenter()
        let interactor = ToDoInteractor()
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        
        return view
    }
}
