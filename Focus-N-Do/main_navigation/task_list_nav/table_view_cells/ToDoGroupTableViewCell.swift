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
    
    @IBOutlet weak var doneCheckBox: CheckBox!
    
    /*@IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var workDateLabel: UILabel!
    @IBOutlet weak var estTimeLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!*/
    
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
