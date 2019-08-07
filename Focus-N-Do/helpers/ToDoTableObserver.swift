//
//  ToDoTableObserver.swift
//  Focus-N-Do
//
//  Created by Elly Richardson on 8/7/19.
//  Copyright © 2019 EllyRichardson. All rights reserved.
//

// Observer pattern is using push mechanism
protocol ToDoTableObserver: class {
    func notifyChangedConnection(toDoTable: ToDoTableObservable, event: ToDoTableConnectionEvent)
}
