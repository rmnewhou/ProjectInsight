//
//  BaseService.swift
//  Proj Insight
//
//  Created by Mackenzie Kary on 2016-12-04.
//  Copyright © 2016 Mackenzie Kary. All rights reserved.
//

import Foundation
import Firebase

let BASE_URL = ""

let FIREBASE_REF = Firebase(url: BASE_URL)

var CURRENT_USER: Firebase{
    let userID = UserDefaults.standard.value(forKey: "uid") as! String
    let currentUser = Firebase(url: "\(FIREBASE_REF)").child(byAppendingPath: "users").child(byAppendingPath: userID)
    
    return currentUser!
}
