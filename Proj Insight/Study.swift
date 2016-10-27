//
//  Study.swift
//  Proj Insight
//
//  Created by Mackenzie Kary on 2016-10-24.
//  Copyright © 2016 Mackenzie Kary. All rights reserved.
//

import Foundation
import UIKit

class Study: NSObject, NSCoding {

    // MARK: Properties
    var name: String
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("saveStudy1")
    
    // MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
    }
    
    // MARK: Initialization
    
    init?(name: String) {
        // Initialize stored properties.
        self.name = name

        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty {
            return nil
        }
        
    }
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)

    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        
        // Must call designated initializer.
        self.init(name: name)
    }



    
}
