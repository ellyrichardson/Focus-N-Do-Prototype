//
//  ToDoTableViewCell.swift
//  Focus-N-Do
//
//  Created by Elly Richardson on 7/6/19.
//  Copyright © 2019 EllyRichardson. All rights reserved.
//

import UIKit
import os.log

class ToDoTableViewCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate, ToDoTableObservable {
    // MARK: - Properties
    
    @IBOutlet weak var toDoDateWeekDayLabel: UILabel!
    @IBOutlet weak var toDoTableView: UITableView!
    
    var toDos = [ToDo]()
    let dateFormatter = DateFormatter()
    var toDoDate = Date()
    
    
    var deletedToDo: ToDo?
    var somethingWasDeleted: Bool?
    private var observers: [ToDoTableObserver] = []
    
    let cellIdentifier = "ToDoGroupTableViewCell"
    
    override var intrinsicContentSize: CGSize {
        return self.intrinsicContentSize
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dateFormatter.dateFormat = "M/d/yy, h:mm a"
        sortToDosByWorkDate()
        //reloadTableViewData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
    }
    
    func addObserver(observer: ToDoTableObserver) {
        if observers.contains(where: {$0 === observer}) == false {
            observers.append(observer)
        }
    }
    
    func removeObserver(observer: ToDoTableObserver) {
        if let index = observers.index(where: {$0 === observer}) {
            observers.remove(at: index)
        }
    }
    
    func notifyObservers() {
        <#code#>
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("Inner Cell Data");
        return toDos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ToDoGroupTableViewCell"
        let dueDateFormatter = DateFormatter()
        let workDateFormatter = DateFormatter()
        dueDateFormatter.dateFormat = "M/d/yy, h:mm a"
        workDateFormatter.dateFormat = "h:mm a"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ToDoGroupTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ToDoGroupTableViewCell.")
        }
        
        // Fetches the appropriate toDo for the data source layout.
        let toDo = toDos[indexPath.row]
        
        cell.taskNameLabel.text = toDo.taskName
        cell.workDateLabel.text = workDateFormatter.string(from: toDo.workDate)
        cell.estTimeLabel.text = toDo.estTime
        cell.dueDateLabel.text = dueDateFormatter.string(from: toDo.dueDate)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source of the current tableViewCell
            let toDoToBeDeleted = toDos[indexPath.row]
            //tableView.beginUpdates()
            toDos.remove(at: indexPath.row)
            saveToDos(toDoToBeDeleted: toDoToBeDeleted)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            
            //tableView.endUpdates()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // MARK: - Private Methods
    
    private func saveToDos(toDoToBeDeleted: ToDo?) {
        // TODO: Refactor the deletion part of this function to be its own delete function
        // If there are existing toDos, load them
        if var savedToDos = loadToDos() {
            // If a there is a specific toDo to be deleted after save
            if toDoToBeDeleted != nil {
                print("toDoToBeDeleted is not nil")
                print(savedToDos)
                /*while let toDoIdToDelete = savedToDos.index(of: toDoToBeDeleted!) {
                    print("Index Exists in savedToDos")
                    savedToDos.remove(at: toDoIdToDelete)
                }*/
                savedToDos.removeAll{$0 == toDoToBeDeleted}
                let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(savedToDos, toFile: ToDo.ArchiveURL.path)
                if isSuccessfulSave {
                    os_log("A ToDo was deleted and ToDos is successfully saved.", log: OSLog.default, type: .debug)
                }
            // If there is no specific toDo to be deleted
            } else {
                let lastToDosItem: Int = toDos.count - 1
                savedToDos.append(toDos[lastToDosItem])
                let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(savedToDos, toFile: ToDo.ArchiveURL.path)
                if isSuccessfulSave {
                    os_log("A ToDo was added and ToDos is successfully saved.", log: OSLog.default, type: .debug)
                }
            }
        // If this is the initial save and no other toDos exists
        } else {
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(toDos, toFile: ToDo.ArchiveURL.path)
            if isSuccessfulSave {
                os_log("The initial ToDo is successfully saved.", log: OSLog.default, type: .debug)
            }
        }
    }
    
    private func loadToDos() -> [ToDo]? {
        print("loadToDos()")
        return NSKeyedUnarchiver.unarchiveObject(withFile: ToDo.ArchiveURL.path) as? [ToDo]
    }
    
    private func registerCell() {
        toDoTableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: "ToDoTableViewCell")
    }
    
    private func sortToDosByWorkDate() {
        toDos = toDos.sorted(by: {
            $1.workDate > $0.workDate
        })
    }
    
    private func getToDoTableConnectionEvent() -> ToDoTableConnectionEvent? {
        var event: ToDoTableConnectionEvent?
        if let deletedToDo = self.deletedToDo, let somethingWasDeleted = self.somethingWasDeleted {
            // TODO: Add ConnectionState something for this function
        }
    }
}
