//
//  ToDo.swift
//  Focus-N-Do
//
//  Created by Elly Richardson on 6/27/19.
//  Copyright © 2019 EllyRichardson. All rights reserved.
//

import UIKit
import os.log

class ToDo: NSObject, NSCoding {
    // MARK: - Properties
    var taskName, taskDescription, estTime: String
    var workDate, dueDate: Date
    //var doneCheckBox: CheckBox
    var finished: Bool
    
    // MARK: - Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Focus-N-Do: ToDos")
    
    // MARK: - Types
    struct PropertyKey {
        static let taskName = "taskName"
        static let taskDescription = "taskDescription"
        static let workDate = "workDate"
        static let estTime = "estTime"
        static let dueDate = "dueDate"
        //static let doneCheckBox = "doneCheckBox"
        static let finished = "finished"
    }
    
    // MARK: - Initialization
    init?(taskName: String, taskDescription: String, workDate: Date, estTime: String, dueDate: Date, finished: Bool) {
        // To fail init if one of them is empty
        if taskName.isEmpty || workDate == nil || estTime.isEmpty || dueDate == nil {
            return nil
        }
        
        // Init stored properties
        self.taskName = taskName
        self.taskDescription = taskDescription
        self.workDate = workDate
        self.estTime = estTime
        self.dueDate = dueDate
        self.finished = finished
    }
    
    // MARK: - NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(taskName, forKey: PropertyKey.taskName)
        aCoder.encode(taskDescription, forKey: PropertyKey.taskDescription)
        aCoder.encode(workDate, forKey: PropertyKey.workDate)
        aCoder.encode(estTime, forKey: PropertyKey.estTime)
        aCoder.encode(dueDate, forKey: PropertyKey.dueDate)
        aCoder.encode(finished, forKey: PropertyKey.finished)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let taskName = aDecoder.decodeObject(forKey: PropertyKey.taskName) as? String
            else {
                os_log("Unable to decode the name for a ToDo object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        // Because taskDescription is a required property of ToDo, although can be empty, just use conditional cast.
        guard let taskDescription = aDecoder.decodeObject(forKey: PropertyKey.taskDescription) as? String
            else {
                os_log("Unable to decode the description for a ToDo object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        // Because workDate is a required property of ToDo, just use conditional cast.
        guard let workDate = aDecoder.decodeObject(forKey: PropertyKey.workDate) as? Date
            else {
                os_log("Unable to decode the work date for a ToDo object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        // Because estTime is a required property of ToDo, just use conditional cast.
        guard let estTime = aDecoder.decodeObject (forKey: PropertyKey.estTime) as? String
            else {
                os_log("Unable to decode the estimated time for a ToDo object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        
        // Because dueDate is a required property of ToDo, just use conditional cast.
        guard let dueDate = aDecoder.decodeObject (forKey: PropertyKey.dueDate) as? Date
            else {
                os_log("Unable to decode the due date for a ToDo object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        let finished = Bool(aDecoder.decodeBool(forKey: PropertyKey.finished))
        if finished == nil {
            os_log("Unable to decode if ToDo object is finished.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(taskName: taskName, taskDescription: taskDescription, workDate: workDate, estTime: estTime, dueDate: dueDate, finished: finished)
    }
}
