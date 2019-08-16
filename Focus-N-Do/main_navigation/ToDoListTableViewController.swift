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
    var toDoSections = [ToDoDateSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // If there are saved ToDos, load them
        if let savedToDos = loadToDos() {
            toDos = savedToDos
        }
        
        let toDoGroups = Dictionary(grouping: self.toDos) { (toDo) in
            return workDateOfToDo(date: toDo.workDate)
        }
        
        self.toDoSections = toDoGroups.map { (key, values) in
            return ToDoDateSection(toDoDate: key, toDos: values)
        }
        sortToDoSections()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sortToDoSections()
        reloadTableViewData()
        
        //savedToDos = loadToDos()!
        
        /*groupToDosAccordingToDates()
        sortToDoGroupDates()
        reloadTableViewData()*/
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.toDoSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return toDoDateGroup.count
        let toDoSection = self.toDoSections[section]
        return toDoSection.toDos.count
    }
    
    // Creates the date of a ToDo as a section header.
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let toDoSection = self.toDoSections[section]
        let toDoDate = toDoSection.toDoDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter.string(from: toDoDate)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let dateCellIdentifier = "ToDoTableViewCell"
        
        let dueDateFormatter = DateFormatter()
        let workDateFormatter = DateFormatter()
        dueDateFormatter.dateFormat = "M/d/yy, h:mm a"
        workDateFormatter.dateFormat = "h:mm a"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: dateCellIdentifier, for: indexPath) as? ToDoGroupTableViewCell else {
            fatalError("The dequeued cell is not an instance of ToDoTableViewCell.")
        }
        
        let toDoSection = self.toDoSections[indexPath.section]
        let toDo = toDoSection.toDos[indexPath.row]
        
        cell.taskNameLabel.text = toDo.taskName
        cell.workDateLabel.text = workDateFormatter.string(from: toDo.workDate)
        cell.estTimeLabel.text = toDo.estTime
        cell.dueDateLabel.text = "Due: " + dueDateFormatter.string(from: toDo.dueDate)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 51
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source of the current toDoSection
            let toDoToBeDeleted = toDoSections[indexPath.section].toDos[indexPath.row]
            toDoSections[indexPath.section].toDos.remove(at: indexPath.row)
            // To delete ToDo from the actual ToDos data, not just toDoSection
            deleteToDoFromSections(toDoToBeDeleted: toDoToBeDeleted)
            saveToDos()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    // Override to support editing the table view.
    /*override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     toDos.remove(at: indexPath.row)
     saveToDos()
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }*/
    
    
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
                //let newIndexPath: IndexPath = IndexPath(row: toDos.count, section: 0)
                toDos.append(toDo)
                //tableView.insertRows(at: [newIndexPath], with: .automatic)
                
                /*var newIndexPath: IndexPath
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "M/d/yy"
                
                if (toDoDateGroup.isEmpty) {
                    newIndexPath = IndexPath(row: toDoDateGroup.count, section: 0)
                    toDoDateGroup.append(dateFormatter.string(from: toDo.workDate))
                    tableView.insertRows(at: [newIndexPath], with: .automatic)
                } else {
                    //groupToDosAccordingToDates()
                }*/
            }
            
            // Save the ToDos
            saveToDos()
        }
    }


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
        /*var toDosToBeSaved = [ToDo]()
        for toDoSection in toDoSections {
            //let toDoBuffer: [ToDo] = toDoSection.toDos
            //toDosToBeSaved.append(toDoSection.toDos)
            for toDo in toDoSection.toDos {
                toDosToBeSaved.append(toDo)
            }
        }*/
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
    
    private func deleteToDoFromSections(toDoToBeDeleted: ToDo) {
        if let index = toDos.index(of: toDoToBeDeleted) {
            let forDebugging: String = toDos[index].taskName
            toDos.remove(at: index)
            os_log("%@ task was deleted.", log: OSLog.default, type: .debug, forDebugging)
        }
    }
    
    /*private func sortToDosByWorkDate() {
        toDos = toDos.sorted(by: {
            $1.workDate > $0.workDate
        })
    }*/
    
    /*private func groupToDosAccordingToDates() {
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
    }*/
    
    private func sortToDoSections() {
        /*toDoDateGroup = toDoDateGroup.sorted(by: {
            $1 > $0
        })*/
        toDoSections = toDoSections.sorted(by: {
            $1 > $0
        })
    }
    
    private func reloadTableViewData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Fileprivate Methods
    fileprivate func workDateOfToDo(date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day, .year], from: date)
        return calendar.date(from: components)!
    }
}
