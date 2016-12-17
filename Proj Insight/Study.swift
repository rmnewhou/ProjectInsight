//
//  Study.swift
//  Proj Insight
//
//  Created by Mackenzie Kary on 2016-10-24.
//  Copyright © 2016 Mackenzie Kary. All rights reserved.
//

/*
 This file is a "Study" object. Studies will contain information such as the name of the study, the 
 tasks accociated 
 */

import Foundation
import UIKit
import ResearchKit


class Study {

    // MARK: Properties
    var name: String
    
    

    var tasksArr = [Task]()
    
    // MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
    }
    
    
    
    //This is the important ones
    func addTask(_ task: Task) {
        tasksArr += [task]
    }
    func getTasks() -> [Task]{
        return self.tasksArr
    }
    
    
    // MARK: Initialization
    
    init?(name: String) {
        // Initialize stored properties.
        self.name = name
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty {
            return nil
        }
        
    }
    



    
}
