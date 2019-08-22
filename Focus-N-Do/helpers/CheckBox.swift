//
//  CheckBox.swift
//  Focus-N-Do
//
//  Created by Elly Richardson on 8/19/19.
//  Copyright © 2019 EllyRichardson. All rights reserved.
//

import UIKit

class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "biege-checked-box")! as UIImage
    let uncheckedImage = UIImage(named: "biege-unchecked-box")! as UIImage
    
    var toDoSectionIndex: Int = Int()
    var toDoRowIndex: Int = Int()
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
        self.toDoSectionIndex = Int()
        self.toDoRowIndex = Int()
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
