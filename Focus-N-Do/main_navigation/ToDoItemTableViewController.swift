//
//  ToDoItemTableViewController.swift
//  Focus-N-Do
//
//  Created by Elly Richardson on 6/20/19.
//  Copyright © 2019 EllyRichardson. All rights reserved.
//

import UIKit
import os.log

// For the individual tables in the view
/*struct TaskItemSections {
    var name = String()
    var collapsed = Bool()
    
    init(name: String, collapsed: Bool = false) {
        self.name = name
        self.collapsed = collapsed
    }
}*/

class ToDoItemTableViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var taskDetailsLabel: UILabel!
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    @IBOutlet weak var workDateLabel: UILabel!
    @IBOutlet weak var workDatePicker: UIDatePicker!
    @IBOutlet weak var estTimeLabel: UILabel!
    @IBOutlet weak var estTimeField: UITextField!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var toDo: ToDo?
    //var toDoDate: ToDoDate?
    var taskItemsSections = [TableItemSection]()
    var finished: Bool
    private var chosenWorkDate: Date
    private var chosenDueDate: Date
    
    required init?(coder aDecoder: NSCoder) {
        chosenWorkDate = Date()
        chosenDueDate = Date()
        finished = false
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Auto resizing the height of the cell
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy, h:mm a"

        taskItemsSections = [
            TableItemSection(name: "Task Details"),
            TableItemSection(name: "Work Date"),
            TableItemSection(name: "Estimated Time"),
            TableItemSection(name: "Due Date"),
        ]
        
        // Handles the changes for the labels through user input
        taskNameField.delegate = self
        taskDescriptionTextView.delegate = self
        estTimeField.delegate = self
        
        // Set up views if editing an existing ToDo.
        if let toDo = toDo {
            navigationItem.title = toDo.taskName
            taskNameField.text = toDo.taskName
            taskDescriptionTextView.text = toDo.taskDescription
            taskDetailsLabel.text = "Task Details: " + toDo.taskName
            workDateLabel.text = "Work Date: " + dateFormatter.string(from: toDo.workDate)
            workDatePicker.date = toDo.workDate
            estTimeLabel.text = "Estmated Time: " + toDo.estTime
            estTimeField.text = toDo.estTime
            dueDateLabel.text = "Due Date: " + dateFormatter.string(from: toDo.dueDate)
            dueDatePicker.date = toDo.dueDate
        }
        
        updateSaveButtonState()
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Determines which of the textfield is it working
        if textField == taskNameField {
            taskDetailsLabel.text = "Task Details: " + textField.text!
        }
        else if textField == estTimeField {
            estTimeLabel.text = "Estimated Time: " + textField.text!
        }
        updateSaveButtonState()
    }
    
    // MARK: - Actions
    @IBAction func workDatePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        chosenWorkDate = sender.date
        let strDate = dateFormatter.string(from: chosenWorkDate)
        workDateLabel.text = "Work Date: " + strDate
    }
    
    @IBAction func dueDatePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        
        chosenDueDate = sender.date
        let strDate = dateFormatter.string(from: chosenDueDate)
        dueDateLabel.text = "Due Date: " + strDate
    }

    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if taskItemsSections[0].collapsed {
                taskItemsSections[0].collapsed = false
            } else {
                taskItemsSections[0].collapsed = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        if indexPath.row == 1 {
            if taskItemsSections[1].collapsed {
                taskItemsSections[1].collapsed = false
            } else {
                taskItemsSections[1].collapsed = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        if indexPath.row == 2 {
            if taskItemsSections[2].collapsed {
                taskItemsSections[2].collapsed = false
            } else {
                taskItemsSections[2].collapsed = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        if indexPath.row == 3 {
            if taskItemsSections[3].collapsed {
                taskItemsSections[3].collapsed = false
            } else {
                taskItemsSections[3].collapsed = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if taskItemsSections[0].collapsed {
                return 210
            }
        }
        if indexPath.row == 1 {
            if taskItemsSections[1].collapsed {
                return 100
            }
        }
        if indexPath.row == 2 {
            if taskItemsSections[2].collapsed {
                return 140
            }
        }
        if indexPath.row == 3 {
            if taskItemsSections[3].collapsed {
                return 140
            }
        }
        return 50
    }

    // MARK: - Navigation
    // Prepares view controller before it gets presented
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Only prepare view controller when the save button is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling new item", log: OSLog.default,
                   type: .debug)
            return
        }
        
        let taskName = taskNameField.text
        let taskDescription = taskDescriptionTextView.text
        let workDate = chosenWorkDate
        let estTime = estTimeField.text
        let dueDate = chosenDueDate
        
        updateSaveButtonState()
        navigationItem.title = taskName
        
        // Set the ToDo to be passed to ToDoListTableViewController after pressing save with unwind segue
        toDo = ToDo(taskName: taskName!, taskDescription: taskDescription!, workDate: workDate, estTime: estTime!, dueDate: dueDate, finished: finished)
        //toDoDate = ToDoDate(toDoDate: workDate)
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddToDoMode = presentingViewController is UINavigationController
        
        if isPresentingInAddToDoMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The ToDoItemTableViewController is not inside a navigation controller.")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    // Disable the save button if the text field is empty
    private func updateSaveButtonState() {
        saveButton.isEnabled = false
        
        // Only allow saveButton if textFields are not empty
        taskNameField.addTarget(self, action: #selector(textFieldsAreNotEmpty), for: .editingChanged)
        estTimeField.addTarget(self, action: #selector(textFieldsAreNotEmpty), for: .editingChanged)
    }
    
    // MARK: - Observers
    // Only allow saveButton if textFields are not empty
    @objc func textFieldsAreNotEmpty(sender: UITextField) {
        guard
            let taskName = taskNameField.text, !taskName.isEmpty,
            let estTime = estTimeField.text, !estTime.isEmpty
            else {
                self.saveButton.isEnabled = false
                return
        }
        // Enable save button if all conditions are met
        saveButton.isEnabled = true
    }
}
