//
//  TaskItemSection.swift
//  Focus-N-Do
//
//  Created by Elly Richardson on 8/19/19.
//  Copyright © 2019 EllyRichardson. All rights reserved.
//

// For the individual tables in the view
struct TableItemSection {
    var name = String()
    var collapsed = Bool()
    
    init(collapsed: Bool = false, name: String?) {
        self.name = name ?? "default"
        self.collapsed = collapsed
    }
}
