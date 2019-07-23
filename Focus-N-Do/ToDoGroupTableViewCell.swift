//
//  ToDoDateGroupTableViewCell.swift
//  Focus-N-Do
//
//  Created by Elly Richardson on 7/13/19.
//  Copyright © 2019 EllyRichardson. All rights reserved.
//

import UIKit

class ToDoGroupTableViewCell: UITableViewCell, UITableViewDelegate {
    /*var toDos = [ToDo]()
    var toDoSubMenuTable: UITableView?*/
    
    // MARK: - Properties
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var workDateLabel: UILabel!
    @IBOutlet weak var estTimeLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //setupSubTable()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

/*class ToDoGroupTableViewCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate{
    var toDos = [ToDo]()
    var toDoSubMenuTable: UITableView?
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cellID")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cellID")
        }
        
        cell?.textLabel?.text = toDos[indexPath.row].taskName
        
        return cell!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupSubTable()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Private Methods
    private func setupSubTable() {
        toDoSubMenuTable = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        toDoSubMenuTable?.delegate = self
        toDoSubMenuTable?.dataSource = self
        self.addSubview(toDoSubMenuTable!)
    }
    
}*/
