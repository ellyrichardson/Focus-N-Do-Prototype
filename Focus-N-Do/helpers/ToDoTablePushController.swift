//
//  ToDoTablePushController.swift
//  Focus-N-Do
//
//  Created by Elly Richardson on 8/7/19.
//  Copyright © 2019 EllyRichardson. All rights reserved.
//

class ToDoTablePushController: ToDoTableObserver {
    //private var toDoListTable: ToDoListTableViewController
    private var deletedToDo: ToDo?
    private var somethingWasDeleted: Bool?
    
    private weak var observable: ToDoTableObservable?
    
    init(withObservable observable: ToDoTableObservable) {
        self.observable = observable
        self.observable?.addObserver(observer: self)
    }
    
    func cleanup() {
        self.observable?.removeObserver(observer: self)
    }
    
    func notifyChangedToDoTableRow(toDoTable: ToDoTableObservable, event: ToDoTableRowEvent) {
        self.deletedToDo = event.deletedToDo
        self.somethingWasDeleted = event.somethingWasDeleted
        
        print("ToDo Table Push Controller Called: Reloading ToDoList Data - ", self.deletedToDo)
    }
}
