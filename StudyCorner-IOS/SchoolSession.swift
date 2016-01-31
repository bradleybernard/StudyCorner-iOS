//
//  SchoolSession.swift
//  StudyCorner-IOS
//
//  Created by Spencer Albrecht on 1/30/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation


class SchoolSession {
    
    var title : String = ""
    var location : String = ""
    var time : String = ""
    var people : Int = 0
    
    init(title: String, location: String, time: String, people: Int) {
        self.title   = title
        self.location = location
        self.time  = time
        self.people = people
    }
}