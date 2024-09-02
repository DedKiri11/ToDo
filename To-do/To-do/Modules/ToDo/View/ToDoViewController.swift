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
    private var isAddedState: Bool = false
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.mainTitleText
        label.font = .systemFont(ofSize: Constants.fontSize20)
        label.textColor = .white
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(viewDidTouch))
        view.addGestureRecognizer(recognizer)
        
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
    
    private func setUpUI() {
        configureNavBar()
        view.addSubview(tableView)
    
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ToDoTableCell.self, forCellReuseIdentifier: ToDoTableCell.identifier)
    }
    
    func configureNavBar() {
        navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "plus.app.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(addButtonTouched))
        navigationItem.titleView = titleLabel
    }
    
    func displayTodos(_ todos: [ToDoEntity]) {
        self.todos = todos
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = todos[indexPath.row].todo
        return calculateCellHeight(for: message)
    }
    
    func calculateCellHeight(for message: String) -> CGFloat {
        let ptrWidth = view.frame.width - 48 - 60
    
        let font = UIFont.systemFont(ofSize: Constants.textViewFontSize)
        let messageLabel = UITextView(frame: CGRect(x: 0, y: 0, width: ptrWidth, height: .greatestFiniteMagnitude))
        messageLabel.text = message
        messageLabel.font = font
        messageLabel.sizeToFit()
        let messageHeight = messageLabel.frame.height
        let minHeight: CGFloat = 30
        let padding: CGFloat = 20
        
        return max(messageHeight + padding * 2, minHeight)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteToDo(todo: todos[indexPath.row])
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableCell.identifier, for: indexPath) as? ToDoTableCell else {
            return UITableViewCell()
        }
        
        var todo = todos[indexPath.row]
        cell.configure(with: todo)
        cell.radioButtonUpdate = { [weak self] in
            todo.completed.toggle()
            self?.presenter.updateToDo(todo: todo)
        }
        
        cell.textFieldCommit = { [weak self] text in
            todo.todo = text
            if todo.id == 0 {
                self?.presenter.addToDo(todo: todo)
                return
            }

            self?.presenter.updateToDo(todo: todo)
        }
        
        return cell
    }
    
    @objc func addButtonTouched() {
        todos.insert(ToDoEntity.default, at: 0)
        tableView.reloadData()
    }
    
    @objc func viewDidTouch() {
        view.endEditing(true)
    }
}
