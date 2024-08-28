//
//  ToDoEntity.swift
//  To-do
//
//  Created by Кирилл Зезюков on 28.08.2024.
//

import Foundation

struct ToDoEntity: Codable {
    var id: Int
    var todo: String
    var completed: Bool
    var date: Date = Date()
}
