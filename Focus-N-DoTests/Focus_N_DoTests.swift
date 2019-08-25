//
//  Focus_N_DoTests.swift
//  Focus-N-DoTests
//
//  Created by Elly Richardson on 6/20/19.
//  Copyright © 2019 EllyRichardson. All rights reserved.
//

import XCTest
@testable import Focus_N_Do

class Focus_N_DoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSortToDoSections() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        /*let navigationController = UINavigationController()
        let listToDoViewController = ToDoListTableViewController()
        navigationController.viewControllers = [listToDoViewController]
        
        let testViewController = navigationController.viewControllers[0]*/
        
        let listToDo = storyboard.instantiateInitialViewController() as! ToDoListTableViewController
        let _ = listToDo.view
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy, h:mm a"
        
        let expectedResult: [ToDo] = [
            ToDo(taskName: "Third Task", taskDescription: "Third Task Description", workDate: dateFormatter.date(from: "07/22/2019")!, estTime: "2", dueDate: dateFormatter.date(from: "07/23/2019")!, finished: false),
            ToDo(taskName: "First Task", taskDescription: "First Task Description", workDate: dateFormatter.date(from: "07/15/2019")!, estTime: "1", dueDate: dateFormatter.date(from: "07/16/2019")!, finished: false),
            ToDo(taskName: "Second Task", taskDescription: "Second Task Description", workDate: dateFormatter.date(from: "07/18/2019")!, estTime: "3", dueDate: dateFormatter.date(from: "07/19/2019")!, finished: false)
            ] as! [ToDo]
        
        listToDo.toDos = [
            ToDo(taskName: "Third Task", taskDescription: "Third Task Description", workDate: dateFormatter.date(from: "07/22/2019")!, estTime: "2", dueDate: dateFormatter.date(from: "07/23/2019")!, finished: false),
            ToDo(taskName: "First Task", taskDescription: "First Task Description", workDate: dateFormatter.date(from: "07/15/2019")!, estTime: "1", dueDate: dateFormatter.date(from: "07/16/2019")!, finished: false),
            ToDo(taskName: "Second Task", taskDescription: "Second Task Description", workDate: dateFormatter.date(from: "07/18/2019")!, estTime: "3", dueDate: dateFormatter.date(from: "07/19/2019")!, finished: false)
            ] as! [ToDo]
        
        
        listToDo.viewDidLoad()
        XCTAssertEqual(expectedResult, listToDo.toDos)
    }

}
