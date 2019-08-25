//
//  CalendarCell.swift
//  Focus-N-Do
//
//  Created by Elly Richardson on 8/24/19.
//  Copyright © 2019 EllyRichardson. All rights reserved.
//

import JTAppleCalendar

class CalendarCell: JTAppleCell {
    
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    /*var normalDayColor = UIColor.black
    var weekendDayColor = UIColor.gray
    
    func setupCellBeforeDisplay(cellState: CellState, date: Date) {
        // Setup Cell text
        dayLabel.text = cellState.text
        
        // Setup text color
        
        configureTextColor(cellState: cellState)
    }
    
    func configureTextColor(cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            dayLabel.textColor = normalDayColor
        } else {
            dayLabel.textColor = weekendDayColor
        }
    }*/
    
    
}
