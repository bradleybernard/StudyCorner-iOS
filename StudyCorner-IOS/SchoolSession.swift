//
//  SchoolSession.swift
//  StudyCorner-IOS
//
//  Created by Spencer Albrecht on 1/30/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation


class SchoolSession {
    
    var created_at: String = ""
    var title: String = ""
    var details: String = ""
    var latitude: Double = 0.0
    var location: String = ""
    var owner_id: Int = 0
    var priority: Bool = true
    var going_count: Int = 0
    var time_start: String = ""
    var id: Int = 0
    var updated_at: String = ""
    var longitude: Double = 0.0
    var user_id: Int = 0
    var time_end: String = ""
    var class_id: Int = 0
    var class_name: String = ""
    var status: Int = 0
    
    init(created_at: String, title: String, details: String, latitude: Double, location: String, owner_id: Int, priority: Bool, going_count: Int, time_start: String, id: Int, updated_at: String, longitude: Double, user_id: Int, time_end: String, class_id: Int, class_name: String, status: Int) {
        self.created_at = created_at
        self.title = title
        self.details = details
        self.latitude = latitude
        self.location = location
        self.owner_id = owner_id
        self.priority = priority
        self.going_count = going_count
        self.time_start = time_start
        self.id = id
        self.updated_at = updated_at
        self.longitude = longitude
        self.user_id = user_id
        self.time_end = time_end
        self.class_id = class_id
        self.class_name = class_name
        self.status = status
    }
}