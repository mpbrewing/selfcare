//
//  Event.swift
//  selfcare
//
//  Created by Michael Brewington on 2/8/21.
//

import Foundation
import UIKit
import Firebase

class Event {
    
    var id: String
    var date: [Date]
    var time: [String]
    var repeating: [String:Any]
    var notify: [[String:Any]]
    var location: [String]
    
    init(id: String, date: [Date],time: [String],repeating: [String:Any],notify: [[String:Any]],location: [String]) {
        self.id = id
        self.date = date
        self.time = time
        self.repeating = repeating
        self.notify = notify
        self.location = location
    }
    
    init(snapshot: [String:Any]) {
        self.id = snapshot["id"] as! String
        self.date = snapshot["date"] as! [Date]
        self.time = snapshot["time"] as! [String]
        self.repeating = snapshot["repeat"] as! [String:Any]
        self.notify = snapshot["notify"] as! [[String:Any]]
        self.location = snapshot["location"] as! [String]
    }
    
    func toAnyObject() -> Any {
        return [
            "date": date,
            "time": time,
            "repeat": repeating,
            "notify": notify,
            "location": location
        ]
    }
    
    func updateDate(date: [Date]){
        self.date = date
    }
    
    func updateTime(time: [String]){
        self.time = time
    }
    
    func updateRepeat(repeating: [String:Any]){
        self.repeating = repeating
    }
    
    func updateNotify(notify: [[String:Any]]){
        self.notify = notify
    }
    
    func updateLocation(location: [String]){
        self.location = location
    }
    
}
