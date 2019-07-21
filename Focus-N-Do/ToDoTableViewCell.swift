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
    @IBOutlet weak var toDoGroupTableView: UITableView!
    
    var toDos = [ToDo]()
    var toDoSubMenuTable: UITableView?
    let dateFormatter = DateFormatter()
    var toDoDate = Date()
    
    // * -- TEST
    /*var toDos = [ToDo]()
    var toDoSubMenuTable: UITableView?*/
    
    // * -- NOTTEST
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        /*setupSubTable()*/
        dateFormatter.dateFormat = "M/d/yy, h:mm a"
        if let savedToDos = loadToDos() {
            for toDo in savedToDos {
                //let chosenWorkDate = toDo.workDate
                if toDo.workDate == toDoDate {
                    toDos.append(toDo)
                }
            }
        }
            /*for toDo in savedToDos {
                for toDoDate in toDoDates {
                    let chosenWorkDate = toDo.workDate
                    if chosenWorkDate != toDoDate {
                        toDoDates.append(chosenWorkDate)
                    }
                }
            }*/
            //for toDo in savedToDos
            //toDos = savedToDos
        sortToDosByWorkDate()
        reloadTableViewData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    // * -- TEST
    
    /*override func layoutSubviews() {
        super.layoutSubviews()
        toDoSubMenuTable?.frame = CGRect(x: 0.0, y: 0.0, width: self.bounds.size.width - 5, height: self.bounds.size.height - 5)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }*/
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "ToDoGroupTableViewCell")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ToDoGroupTableViewCell")
        }
        
        
        //cell?.textLabel?.text = toDos[indexPath.row].taskName
        
        return cell!*/
        
        let cellIdentifier = "ToDoGroupTableViewCell"
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "M/d/yy"
        dateFormatter.dateFormat = "M/d/yy, h:mm a"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ToDoGroupTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ToDoGroupTableViewCell.")
        }
        
        // Fetches the appropriate toDo for the data source layout.
        let toDo = toDos[indexPath.row]
        
        cell.taskNameLabel.text = toDo.taskName;
        cell.workDateLabel.text = dateFormatter.string(from: toDo.workDate);
        cell.estTimeLabel.text = toDo.estTime;
        cell.dueDateLabel.text = dateFormatter.string(from: toDo.dueDate);
        
        /*let toDo1 = ToDo(taskName: "Test", taskDescription: "Test Desc", workDate: Date(), estTime: "Test Est", dueDate: Date())
         let toDo2 = ToDo(taskName: "Test2", taskDescription: "Test Desc2", workDate: Date(), estTime: "Test Est2", dueDate: Date())
         let toDo3 = ToDo(taskName: "Test3", taskDescription: "Test Desc3", workDate: Date(), estTime: "Test Est3", dueDate: Date())
         
         cell.toDos.append(toDo1!)
         cell.toDos.append(toDo2!)
         cell.toDos.append(toDo3!)*/
        
        return cell
    }
    
    // MARK: - Private Methods
    
    private func loadToDos() -> [ToDo]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: ToDo.ArchiveURL.path) as? [ToDo]
    }
    
    private func setupSubTable() {
        toDoSubMenuTable = toDoGroupTableView
        toDoSubMenuTable?.delegate = self
        toDoSubMenuTable?.dataSource = self
        //self.addSubview(toDoSubMenuTable!)
    }
    
    private func sortToDosByWorkDate() {
        toDos = toDos.sorted(by: {
            $1.workDate > $0.workDate
        })
     }
    
    /*private func sortToDoGroupDates() {
        toDoDateGroup = toDoDateGroup.sorted(by: {
            $1 > $0
        })
    }*/
    
    private func reloadTableViewData() {
        DispatchQueue.main.async {
            self.toDoSubMenuTable?.reloadData()
        }
    }
}
