//
//  ToDoDetailPresenter.swift
//  ToDoList
//
//  Created by Serguei Diaz on 03.04.2025.
//

final class DefaultToDoDetailPresenter: ToDoDetailPresenterProtocol {
        
    let saveToDoInteractor: SaveToDoUseCase
    
    var view: ToDoDetailViewControllerProtocol?
    
    var router: ToDoDetailRouterProtocol?
    
    private var creatingToDo: Bool = false
    
    private var newToDoId: String? = nil
        
    init(saveToDoInteractor: SaveToDoUseCase, view: ToDoDetailViewControllerProtocol? = nil, router: ToDoDetailRouterProtocol? = nil) {
        self.saveToDoInteractor = saveToDoInteractor
        self.view = view
        self.router = router
    }
    
    func saveToDo(toDo: ToDoEntity) {
        if creatingToDo { return }
        
        let newToDo: ToDoEntity
        
        if let id: String = toDo.id ?? newToDoId {
            newToDo = .init(id: id,
                            title: toDo.title,
                            description: toDo.description,
                            date: toDo.date,
                            isDone: toDo.isDone
            )
        }
        else {
            newToDo = toDo
            creatingToDo = true
        }
        
        saveToDoInteractor.saveToDo(newToDo)
    }
    
    func onSaveToDoSuccess(_ toDo: ToDoEntity) {
        creatingToDo = false
        newToDoId = toDo.id
    }
    
    func onSaveToDoError(_ error: Error) {
        print(error)
        view?.showError("Ошибка сохранения")
    }
    
}
