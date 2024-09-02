//
//  HTTPResponse.swift
//  To-do
//
//  Created by Кирилл Зезюков on 29.08.2024.
//

import Foundation

struct HTTPResponse: Codable {
    var todos: [ToDoEntity]
}
