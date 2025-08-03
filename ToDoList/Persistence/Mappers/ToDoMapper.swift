//
//  ToDoMapper.swift
//  ToDoList
//
//  Created by Serguei Diaz on 06.04.2025.
//

struct ToDoMapper: MapperProtocol {
    
    typealias T = ToDoEntity
    
    private let id : Int
    private let todo: String
    private let completed: Bool
    private let userId: Int
    
    func execute() -> ToDoEntity? {
        return .init(
            id: "\(id)",
            title: todo,
            description: "some description",
            date: nil,
            isDone: completed
        )
    }
}

struct ToDoListMapper: MapperProtocol {
    
    typealias T = [ToDoEntity]
    
    private let todos: [ToDoMapper]
    private let total: Int
    private let skip: Int
    private let limit: Int
    
    func execute() -> [ToDoEntity]? {
        return todos.compactMap { mapper in
            mapper.execute()
        }
    }
    
}
