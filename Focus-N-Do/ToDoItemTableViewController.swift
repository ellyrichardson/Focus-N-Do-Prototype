//
//  ToDoItemTableViewController.swift
//  Focus-N-Do
//
//  Created by Elly Richardson on 6/20/19.
//  Copyright © 2019 EllyRichardson. All rights reserved.
//

import UIKit

// For the individual tables in the view
struct TaskItemSections {
    var name = String()
    var collapsed = Bool()
    
    init(name: String, collapsed: Bool = false) {
        self.name = name
        self.collapsed = collapsed
    }
}

class ToDoItemTableViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate {
    
    // MARK: Properties
    @IBOutlet weak var taskDetailsLabel: UILabel!
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    @IBOutlet weak var workDateLabel: UILabel!
    @IBOutlet weak var workDatePicker: UIDatePicker!
    @IBOutlet weak var estTimeLabel: UILabel!
    @IBOutlet weak var estTimeField: UITextField!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    var taskItemsSections = [TaskItemSections]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Auto resizing the height of the cell
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension

        taskItemsSections = [
            TaskItemSections(name: "Task Details"),
            TaskItemSections(name: "Work Date"),
            TaskItemSections(name: "Estimated Time"),
            TaskItemSections(name: "Due Date"),
        ]
        
        // Handles the changes for the labels through user input
        taskNameField.delegate = self
        taskDescriptionTextView.delegate = self
        estTimeField.delegate = self
    }
    
    // MARK: UITextFieldDelegate
    
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
    }

    // MARK: Table View Data Source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return taskItemsSections.count
    }*/

    /*override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sections[section].collapsed == true {
            // With + 1 since the title also gets counted as a section
            return sections[section].items.count + 1
        } else {
            return 1
        }
    }*/

    /*override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "toDoConfigCell") else {
                return UITableViewCell()
            }
            cell.textLabel?.text = sections[indexPath.section].name
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "toDoConfigCell") else {
                return UITableViewCell()
            }
            // For the specific items inside the drop down, with -1 because of + 1 from counting sections
            cell.textLabel?.text = (sections[indexPath.section].items[dataIndex] as! String)
            return cell
        }
    }*/
    
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
                return 250
            }
        }
        if indexPath.row == 2 {
            if taskItemsSections[2].collapsed {
                return 100
            }
        }
        if indexPath.row == 3 {
            if taskItemsSections[3].collapsed {
                return 250
            }
        }
        return 50
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
