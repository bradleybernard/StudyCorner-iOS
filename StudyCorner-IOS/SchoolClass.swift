//
//  SchoolClass.swift
//  StudyCorner-IOS
//
//  Created by Aidan Gadberry on 1/30/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation

class SchoolClass{
    
    var user_id: String = ""
    var class_id: String = ""
    var class_name: String = ""
    var priority: Bool = true
    
    init(user_id: String, class_id: String, class_name: String, priority: Bool) {
        self.user_id   = user_id
        self.class_id = class_id
        self.class_name  = class_name
        self.priority = priority
    }
}