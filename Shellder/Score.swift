//
//  Score.swift
//  Shellder
//
//  Created by Robert Demuth on 11/18/15.
//  Copyright © 2015 CS 4720. All rights reserved.
//

import UIKit

class Score {
    
    // MARK: Properties
    
    var name: String
    var completed: Int
    
    // MARK: Initialization
    
    init(name: String, completed: Int) {
        // Initialize stored properties.
        self.name = name
        self.completed = completed
    }
    
}
