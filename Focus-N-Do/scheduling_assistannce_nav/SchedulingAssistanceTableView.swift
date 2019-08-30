//
//  ToDoListTableView.swift
//  Focus-N-Do
//
//  Created by Elly Richardson on 8/29/19.
//  Copyright © 2019 EllyRichardson. All rights reserved.
//

import UIKit

class ToDoListTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //var toDoItems = [ToDo]()
    private var toDosInDate = [ToDo]()
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.toDosInDate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dateCellIdentifier = "ToDoTableViewCell"
        
        let dueDateFormatter = DateFormatter()
        let workDateFormatter = DateFormatter()
        dueDateFormatter.dateFormat = "M/d/yy, h:mm a"
        workDateFormatter.dateFormat = "h:mm a"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: dateCellIdentifier, for: indexPath) as? ToDoGroupTableViewCell else {
            fatalError("The dequeued cell is not an instance of ToDoTableViewCell.")
        }
        
        let toDo = self.toDosInDate[indexPath.row]
        
        cell.taskNameLabel.text = toDo.taskName
        cell.estTimeLabel.text = toDo.estTime
        cell.workDateLabel.text = workDateFormatter.string(from: toDo.workDate)
        cell.dueDateLabel.text = dueDateFormatter.string(from: toDo.dueDate)
        
        return cell
    }
    
    // MARK: - Setters
    func setToDoItems(toDoItems: [ToDo]) {
        self.toDosInDate = toDoItems
    }
    
    // MARK: - Getters
    func getToDoItems() -> [ToDo] {
        return self.toDosInDate
    }
}
