//
//  ToDoListTableViewController.swift
//  Focus-N-Do
//
//  Created by Elly Richardson on 6/27/19.
//  Copyright © 2019 EllyRichardson. All rights reserved.
//

import UIKit
import os.log

class ToDoListTableViewController: UITableViewController {

    // MARK: - Properties
    var toDos = [ToDo]()
    var toDoDateGroup = [String]()
    var savedToDos = [ToDo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If there are saved ToDos, load them
        groupToDosAccordingToDates()
        sortToDoGroupDates()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        savedToDos = loadToDos()!
        
        groupToDosAccordingToDates()
        sortToDoGroupDates()
        reloadTableViewData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDoDateGroup.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ToDoTableViewCell"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy, h:mm a"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ToDoTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ToDoTableViewCell.")
        }
        
        // Fetches the appropriate toDo for the data source layout.
        let toDo = toDos[indexPath.row]
        
        cell.taskNameLabel.text = toDo.taskName;
        cell.workDateLabel.text = dateFormatter.string(from: toDo.workDate);
        cell.estTimeLabel.text = toDo.estTime;
        cell.dueDateLabel.text = dateFormatter.string(from: toDo.dueDate);

        return cell
         */
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ToDoTableViewCell"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy"
        //dateFormatter.dateFormat = "M/d/yy, h:mm a"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ToDoTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ToDoTableViewCell.")
        }
        
        // Fetches the appropriate toDo for the data source layout.
        let toDoDate = toDoDateGroup[indexPath.row]
        
        cell.toDoDate = dateFormatter.date(from: toDoDate)!
        cell.toDoDateWeekDayLabel.text = toDoDate
        /*let toDo1 = ToDo(taskName: "Test", taskDescription: "Test Desc", workDate: Date(), estTime: "Test Est", dueDate: Date())
        let toDo2 = ToDo(taskName: "Test2", taskDescription: "Test Desc2", workDate: Date(), estTime: "Test Est2", dueDate: Date())
        let toDo3 = ToDo(taskName: "Test3", taskDescription: "Test Desc3", workDate: Date(), estTime: "Test Est3", dueDate: Date())
        
        cell.toDos.append(toDo1!)
        cell.toDos.append(toDo2!)
        cell.toDos.append(toDo3!)*/
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    // MARK: - Actions
    @IBAction func unwindToToDoList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ToDoItemTableViewController, let toDo = sourceViewController.toDo {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "M/d/yy"
                // Update an existing ToDo
                //toDos.append(toDo)
                toDoDateGroup[selectedIndexPath.row] = dateFormatter.string(from: toDo.workDate)
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            
            else {
                // Add a new toDo
                toDos.append(toDo)
                
                var newIndexPath: IndexPath
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "M/d/yy"
                
                if (toDoDateGroup.isEmpty) {
                    newIndexPath = IndexPath(row: toDoDateGroup.count, section: 0)
                    toDoDateGroup.append(dateFormatter.string(from: toDo.workDate))
                    tableView.insertRows(at: [newIndexPath], with: .automatic)
                } else {
                    groupToDosAccordingToDates()
                }
            }
            
            // Save the ToDos
            saveToDos()
        }
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            toDos.remove(at: indexPath.row)
            saveToDos()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "AddToDoItem":
            os_log("Adding a new ToDo item.", log: OSLog.default, type: .debug)
        case "ShowToDoItemDetails":
            guard let toDoItemDetailViewController = segue.destination as? ToDoItemTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedToDoItemCell = sender as? ToDoGroupTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedToDoItemCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedToDoItem = toDos[indexPath.row]
            toDoItemDetailViewController.toDo = selectedToDoItem
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    // MARK: - Private Methods
    private func saveToDos() {
        //sortToDosByWorkDate()
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(toDos, toFile: ToDo.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("ToDos successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save toDos...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadToDos() -> [ToDo]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: ToDo.ArchiveURL.path) as? [ToDo]
    }
    
    /*private func sortToDosByWorkDate() {
        toDos = toDos.sorted(by: {
            $1.workDate > $0.workDate
        })
    }*/
    
    private func groupToDosAccordingToDates() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy"
        //dateFormatter.dateFormat = "M/d/yy, h:mm a"
        
        var newIndexPath: IndexPath
        
        for toDo in toDos {
            print(toDo.taskName)
            let chosenWorkDate = dateFormatter.string(from: toDo.workDate)
            if !toDoDateGroup.contains(chosenWorkDate) {
                print(chosenWorkDate)
                newIndexPath = IndexPath(row: toDoDateGroup.count, section: 0)
                toDoDateGroup.append(chosenWorkDate)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    private func sortToDoGroupDates() {
        toDoDateGroup = toDoDateGroup.sorted(by: {
            $1 > $0
        })
    }
    
    private func reloadTableViewData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}
