//
//  ToDoTableCell.swift
//  To-do
//
//  Created by Кирилл Зезюков on 29.08.2024.
//

import UIKit

class ToDoTableCell: UITableViewCell {
    static let identifier = "TodoTableViewCell"
    var radioButtonUpdate: (() -> ())?
    var textFieldCommit: ((String) -> ())?
    
    private lazy var todoTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: Constants.textViewFontSize)
        textView.isScrollEnabled = false
        return textView
    }()

    private lazy var dateOfCreation: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.dateOfCreationFontSize)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var radioButton: RadioButton = {
        let radioButton = RadioButton()
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        radioButton.layer.cornerRadius = Constants.radioButtonCornerRadius
        radioButton.layer.borderWidth = Constants.radioButtonBorderWidth
        radioButton.layer.borderColor = UIColor.white.cgColor
        
        radioButton.addTarget(self, action: #selector(radioButtonDidTouched), for: .touchUpInside)
        return radioButton
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setUpUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        radioButton.isSelected = false
        todoTextView.isScrollEnabled = false
    }

    @objc func radioButtonDidTouched() {
        radioButtonUpdate?()
    }
    
    func setUpUI() {
        contentView.addSubview(todoTextView)
        contentView.addSubview(radioButton)
        contentView.addSubview(dateOfCreation)
        
        NSLayoutConstraint.activate([
            radioButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.radioButtonLeadingPadding),
            radioButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            radioButton.widthAnchor.constraint(equalToConstant: Constants.radioButtonSize),
            radioButton.heightAnchor.constraint(equalToConstant: Constants.radioButtonSize),
            
            todoTextView.leadingAnchor.constraint(equalTo: radioButton.trailingAnchor, constant: Constants.todoTextViewLeadingPadding),
            todoTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.todoTextViewTrailingPadding),
            todoTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.todoTextViewBottomPadding),
            todoTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.todoTextViewTopPadding),
            
            dateOfCreation.leadingAnchor.constraint(equalTo: todoTextView.trailingAnchor, constant: Constants.dateOfCreationLeadingPadding),
            dateOfCreation.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateOfCreation.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.dateOfCreationTrailingPadding),
            dateOfCreation.centerYAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.dateOfCreationCenterY),
            
        ])
        
        todoTextView.delegate = self
        backgroundColor = .black
    }
    
    func configure(with todo: ToDoEntity) {
        todoTextView.text = todo.todo
        todoTextView.isScrollEnabled = todo.todo.isEmpty
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let dateString = dateFormatter.string(from: todo.date)
        dateOfCreation.text = dateString
        radioButton.isSelected = todo.completed
    }
}

extension ToDoTableCell: UITextViewDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textFieldCommit?(textView.text)
        return true
    }
}
