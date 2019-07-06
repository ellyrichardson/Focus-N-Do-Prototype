//
//  ToDo.swift
//  Focus-N-Do
//
//  Created by Elly Richardson on 6/27/19.
//  Copyright © 2019 EllyRichardson. All rights reserved.
//

import UIKit
import os.log

class ToDo {
    // MARK: - Properties
    var taskName, workDate, estTime, dueDate: String
    
    // MARK: - Initialization
    init?(taskName: String, workDate: String, estTime: String, dueDate: String) {
        // To fail init if one of them is empty
        if taskName.isEmpty || workDate.isEmpty || estTime.isEmpty || dueDate.isEmpty {
            return nil
        }
        
        // Init stored properties
        self.taskName = taskName
        self.workDate = workDate
        self.estTime = estTime
        self.dueDate = dueDate
    }
}
