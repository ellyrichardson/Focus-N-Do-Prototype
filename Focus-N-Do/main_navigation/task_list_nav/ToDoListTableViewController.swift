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
    
    private var buttonChecked: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // If there are saved ToDos, load them
        if let savedToDos = loadToDos() {
            toDos = savedToDos
        }
        
        toDos = sortToDoItems(toDoItems: toDos)
        addToDoInAppropriateSection()
        toDoSections = sortToDoSections(toDoSections: toDoSections)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        toDos = sortToDoItems(toDoItems: toDos)
        addToDoInAppropriateSection()
        toDoSections = sortToDoSections(toDoSections: toDoSections)
        reloadTableViewData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.toDoSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let toDoSection = self.toDoSections[section]
        return toDoSection.toDos.count
    }
    
    // Creates the date of a ToDo as a section header.
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Have section header if section is not empty.
        if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
            let toDoSection = self.toDoSections[section]
            let toDoDate = toDoSection.toDoDate
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd, yyyy"
            return dateFormatter.string(from: toDoDate)
        }
        // Remove header if section is empty
        else {
            return nil
        }
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
        
        let toDo = self.toDoSections[indexPath.section].toDos[indexPath.row]
        
        cell.taskNameLabel.text = toDo.taskName
        cell.workDateLabel.text = workDateFormatter.string(from: toDo.workDate)
        cell.estTimeLabel.text = toDo.estTime
        cell.dueDateLabel.text = "Due: " + dueDateFormatter.string(from: toDo.dueDate)
        
        cell.doneCheckBox.toDoSectionIndex = indexPath.section
        cell.doneCheckBox.toDoRowIndex = indexPath.row
        //cell.doneCheckBox = toDo.doneCheckBox
        print(indexPath.row)
        print(toDo.finished)
        cell.doneCheckBox.isChecked = toDo.finished
        cell.doneCheckBox.addTarget(self, action: #selector(onDoneCheckButtonTap(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if toDoSections[indexPath.section].collapsed {
            return 0
        }
        return 51
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toDoToBeDeleted = toDoSections[indexPath.section].toDos[indexPath.row]
            
            // Delete the row from the current toDoSection
            toDoSections[indexPath.section].toDos.remove(at: indexPath.row)
            
            // Delete ToDo from the actual ToDos data, not just toDoSection
            deleteToDoFromSections(toDoToBeDeleted: toDoToBeDeleted)
            saveToDos()
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView()
        let tapRecognizer = HeaderTapGesture(target: self, action: #selector(handleTap))
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        tapRecognizer.section = section
        headerView.addGestureRecognizer(tapRecognizer)
        
        return headerView
    }
    
    // MARK: - Actions
    @IBAction func unwindToToDoList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ToDoItemTableViewController, let toDo = sourceViewController.toDo {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing ToDo
                // TODO: NEED FIXING?
                //toDos.append(toDo)
                //toDoDateGroup[selectedIndexPath.row] = dateFormatter.string(from: toDo.workDate)
                //toDoSections[selectedIndexPath.section].toDos[selectedIndexPath.row] = toDo
                toDoSections[selectedIndexPath.section].toDos[selectedIndexPath.row] = toDo
                //tableView.reloadRows(at: [selectedIndexPath], with: .none)
                tableView.reloadSections(IndexSet(selectedIndexPath), with: UITableView.RowAnimation.automatic)
                print("Selected INDEX PATH")
                print(IndexSet(selectedIndexPath).count)
            }
            
            else {
                toDos.append(toDo)
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
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedToDoItemCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedToDoItem = toDoSections[indexPath.section].toDos[indexPath.row]
            print("Section + Row")
            print(toDoSections[indexPath.section].toDos[indexPath.row])
            toDoItemDetailViewController.toDo = selectedToDoItem
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    // MARK: - Private Methods
    
    private func saveToDos() {
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
    
    private func addToDoInAppropriateSection() {
        let toDoGroups = Dictionary(grouping: self.toDos) { (toDo) in
            return workDateOfToDo(date: toDo.workDate)
        }
        
        self.toDoSections = toDoGroups.map { (arg) -> ToDoDateSection in
            let (key, values) = arg
            return ToDoDateSection(toDoDate: key, toDos: values, collapsed: false)
        }
    }
    
    private func sortToDoSections(toDoSections: [ToDoDateSection]) -> [ToDoDateSection] {
        var sortToDoSections = toDoSections
        
        sortToDoSections = sortToDoSections.sorted(by: {
            $1 > $0
        })
        
        return sortToDoSections
    }
    
    // Sorts toDo items inside toDo sections
    private func sortToDoItems(toDoItems: [ToDo]) -> [ToDo] {
        var sortToDos = toDoItems
        
        sortToDos = sortToDos.sorted(by: {
            $1.workDate > $0.workDate
        })
        
        return sortToDos
    }
    
    private func reloadTableViewData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: Observers
    
    @objc func onDoneCheckButtonTap(sender: CheckBox) {
        let toDoRowIndex = sender.toDoRowIndex
        let toDoSectionIndex = sender.toDoSectionIndex
        let toDoToBeChanged: ToDo = toDoSections[toDoSectionIndex].toDos[toDoRowIndex]
        if toDoToBeChanged.finished {
            toDoToBeChanged.finished = false
        }
        else {
            toDoToBeChanged.finished = true
        }
        toDoSections[toDoSectionIndex].toDos[toDoRowIndex] = toDoToBeChanged
        saveToDos()
    }
    
    @objc func handleTap(gestureRecognizer: HeaderTapGesture, section: Int) {
        let sectionIndex = (gestureRecognizer.section)
        if toDoSections[sectionIndex].collapsed {
            toDoSections[sectionIndex].collapsed = false
        }
        else {
            toDoSections[sectionIndex].collapsed = true
        }
        
        self.tableView.reloadSections(NSIndexSet(index: sectionIndex) as IndexSet, with: UITableView.RowAnimation.automatic)
    }
    
    // MARK: - Fileprivate Methods
    
    fileprivate func workDateOfToDo(date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day, .year], from: date)
        return calendar.date(from: components)!
    }
}
