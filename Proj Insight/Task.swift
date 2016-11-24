//
//  Task.swift
//  Proj Insight
//
//  Created by Mackenzie Kary on 2016-11-10.
//  Copyright © 2016 Mackenzie Kary. All rights reserved.
//

import Foundation
import UIKit
import ResearchKit

class Task: NSObject, NSCoding {
    
    // MARK: Properties
    var name: String            // Name of task
    var photo: UIImage?         // Image of task
    var type: String            // Type of task
    var task: ORKTask
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("taskSave") 
    
    // MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let typeKey = "type"
        static let taskKey = "task"
    }
    
    // MARK: Initialization
    
    init?(name: String, photo: UIImage?, type: String, task: ORKTask) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.type = type
        self.task = task
        
        super.init()
    }
    
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(photo, forKey: PropertyKey.photoKey)
        aCoder.encode(type, forKey: PropertyKey.typeKey)
        aCoder.encode(task, forKey: PropertyKey.taskKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as? UIImage
        
        let type = aDecoder.decodeObject(forKey: PropertyKey.typeKey) as! String        // Decoder for the type variable
        let task = aDecoder.decodeObject(forKey: PropertyKey.taskKey) as! ORKTask
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, type: type, task: task)
    }
    
}
