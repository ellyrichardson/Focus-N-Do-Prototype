//
//  ToDoTableObservable.swift
//  Focus-N-Do
//
//  Created by Elly Richardson on 8/7/19.
//  Copyright © 2019 EllyRichardson. All rights reserved.
//

// Observer pattern is using push mechanism
protocol ToDoTableObservable: class {
    func addObserver(observer: ToDoTableObserver)
    func removeObserver(observer: ToDoTableObserver)
    func notifyObservers()
}
