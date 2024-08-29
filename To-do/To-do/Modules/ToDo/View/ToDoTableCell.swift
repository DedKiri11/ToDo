//
//  ToDoTableCell.swift
//  To-do
//
//  Created by Кирилл Зезюков on 29.08.2024.
//

import UIKit

class ToDoTableCell: UITableViewCell {
    static let identifier = "TodoTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateOfCreation: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let checkmarkImageView:  UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Добавляем subviews
        contentView.addSubview(titleLabel)
        contentView.addSubview(checkmarkImageView)
        contentView.addSubview(dateOfCreation)
        
        // Устанавливаем ограничения
        NSLayoutConstraint.activate([
            checkmarkImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkmarkImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 24),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: checkmarkImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            
            dateOfCreation.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -25),
            dateOfCreation.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateOfCreation.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            dateOfCreation.centerYAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
        ])
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = .init(red: 255, green: 255, blue: 255, alpha: 1)
        contentView.layer.cornerRadius = 5
        contentView.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Метод для настройки ячейки
    func configure(with todo: ToDoEntity) {
        titleLabel.text = todo.todo
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let dateString = dateFormatter.string(from: Date())
        dateOfCreation.text = dateString
        checkmarkImageView.image = todo.completed ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
    }
}
