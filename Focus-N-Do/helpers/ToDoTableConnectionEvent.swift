//
//  ObserverConnectionEvent.swift
//  Focus-N-Do
//
//  Created by Elly Richardson on 8/7/19.
//  Copyright © 2019 EllyRichardson. All rights reserved.
//

protocol ToDoTableConnectionEvent {
    var deletedToDo: ToDo { get }
    var somethingWasDeleted: Bool { get }
}
