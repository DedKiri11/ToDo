//
//  ToDoViewController.swift
//  To-do
//
//  Created by Кирилл Зезюков on 28.08.2024.
//

import UIKit

class ToDoViewController: UIViewController, ToDoViewControllerProtocol, UITableViewDataSource, UITableViewDelegate {
    var presenter: ToDoPresenterProtocol!
    var todos: [ToDoEntity] = []
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.mainTitleText
        label.font = .systemFont(ofSize: Constants.fontSize20)
        label.textColor = .white
        return label
    }()
    
    private lazy var table: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        presenter.presentTodos()
    }
    
    private func setUpUI() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.titleLeading),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        view.addSubview(table)
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "TodoCell")
    }
    
    func displayTodos(_ todos: [ToDoEntity]) {
        self.todos = todos
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.todo
        return cell
    }
}
