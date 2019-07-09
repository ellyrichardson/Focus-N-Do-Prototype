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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ToDoTableViewCell"
        let dateFormatter = DateFormatter()
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ToDoTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ToDoTableViewCell.")
        }
        
        // Fetches the appropriate toDo for the data source layout.
        let toDo = toDos[indexPath.row]
        
        cell.taskNameLabel.text = toDo.taskName;
        cell.workDateLabel.text = dateFormatter.string(from: toDo.workDate);
        cell.estTimeLabel.text = toDo.estTime;
        cell.dueDateLabel.text = dateFormatter.string(from: toDo.dueDate);
        
        /*cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating*/

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    // MARK: - Actions
    @IBAction func unwindToToDoList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ToDoItemTableViewController, let toDo = sourceViewController.toDo {
            // Add a new toDo
            let newIndexPath = IndexPath(row: toDos.count, section: 0)
            
            toDos.append(toDo)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
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
        case "ShowToDoItemDetail":
            guard let toDoItemDetailViewController = segue.destination as? ToDoItemTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedToDoItemCell = sender as? ToDoTableViewCell else {
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

}
