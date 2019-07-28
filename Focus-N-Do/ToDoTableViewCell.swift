//
//  ToDoTableViewCell.swift
//  Focus-N-Do
//
//  Created by Elly Richardson on 7/6/19.
//  Copyright © 2019 EllyRichardson. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {
    // MARK: - Properties
    /*@IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var workDateLabel: UILabel!
    @IBOutlet weak var estTimeLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!*/
    
    @IBOutlet weak var toDoDateWeekDayLabel: UILabel!
    @IBOutlet weak var toDoTableView: UITableView!
    
    var toDos = [ToDo]()
    //var toDoSubMenuTable: UITableView?
    let dateFormatter = DateFormatter()
    var toDoDate = Date()
    
    let cellIdentifier = "ToDoGroupTableViewCell"
    
    override var intrinsicContentSize: CGSize {
        return self.intrinsicContentSize
    }
    
    // * -- NOTTEST
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //print("AWAKEFROMBIB")
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
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("Inner Cell Data");
        return toDos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ToDoGroupTableViewCell"
        let dueDateFormatter = DateFormatter()
        let workDateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "M/d/yy"
        dueDateFormatter.dateFormat = "M/d/yy, h:mm a"
        workDateFormatter.dateFormat = "h:mm a"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ToDoGroupTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ToDoGroupTableViewCell.")
        }
        
        // Fetches the appropriate toDo for the data source layout.
        let toDo = toDos[indexPath.row]
        
        //print("Inner Cell Dataaedad");
        
        cell.taskNameLabel.text = toDo.taskName
        cell.workDateLabel.text = workDateFormatter.string(from: toDo.workDate)
        cell.estTimeLabel.text = toDo.estTime
        cell.dueDateLabel.text = dueDateFormatter.string(from: toDo.dueDate)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            toDos.remove(at: indexPath.row)
            //saveToDos()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // MARK: - Private Methods
    
    private func loadToDos() -> [ToDo]? {
        print("loadToDos()")
        return NSKeyedUnarchiver.unarchiveObject(withFile: ToDo.ArchiveURL.path) as? [ToDo]
    }
    
    private func registerCell() {
        toDoTableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: "ToDoTableViewCell")
    }
    
    private func sortToDosByWorkDate() {
        //print("CALLING")
        toDos = toDos.sorted(by: {
            $1.workDate > $0.workDate
        })
     }
}
