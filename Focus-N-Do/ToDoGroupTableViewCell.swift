//
//  ToDoDateGroupTableViewCell.swift
//  Focus-N-Do
//
//  Created by Elly Richardson on 7/13/19.
//  Copyright © 2019 EllyRichardson. All rights reserved.
//

import UIKit

class ToDoGroupTableViewCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate{
    var toDos = [ToDo]()
    var toDoSubMenuTable: UITableView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupSubTable()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    // MARK: - Private Methods
    private func setupSubTable() {
        toDoSubMenuTable = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        toDoSubMenuTable?.delegate = self
        toDoSubMenuTable?.dataSource = self
        self.addSubview(toDoSubMenuTable!)
    }

}
