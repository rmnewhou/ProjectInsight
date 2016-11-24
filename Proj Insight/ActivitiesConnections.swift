//
//  ActivitiesConnections.swift
//  Proj Insight
//
//  Created by Ryan Newhouse on 2016-11-07.
//  Copyright © 2016 Mackenzie Kary. All rights reserved.
//

import Foundation

class ActivitiesConnections {
    static let sharedInstance: ActivitiesConnections = {
        let instance = ActivitiesConnections()
        
        // setup code
        return instance
    }()
    
    var studyArr = [Study]()
    var studyCurrent = Study(name: "Test")
    var tempTaskListRow: TaskListRow? = nil
    

    
}
