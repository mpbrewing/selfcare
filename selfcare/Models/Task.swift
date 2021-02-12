//
//  Task.swift
//  selfcare
//
//  Created by Michael Brewington on 12/15/20.
//

import Foundation

struct Task {
    
    //title, description, emoji, events, priority, status, tags
    
    var title: String
    var emoji: String
    var description: String
    var events: [String]
    var status: Int
    var priority: Int
    var tags: [String]
     
    init(title: String, emoji: String, description: String, events: [String],status: Int, priority: Int,tags: [String]) {
        self.title = title
        self.emoji = emoji
        self.description = description
        self.events = events
        self.status = status
        self.priority = priority
        self.tags = tags
    }
     
    func toAnyObject() -> Any {
        return [
            "title": title,
            "emoji": emoji,
            "description": description,
            "events": events,
            "status": status,
            "priority": priority,
            "tags": tags
        ]
    }
     
    init(snapshot: [String:Any]) {
        self.title = snapshot["title"] as! String
        self.emoji = snapshot["emoji"] as! String
        self.description = snapshot["description"] as! String
        self.events = snapshot["events"] as! [String]
        self.status = snapshot["status"] as! Int
        self.priority = snapshot["priority"] as! Int
        self.tags = snapshot["tags"] as! [String]
    }
     
    mutating func setTitle(title: String, emoji: String) {
        self.title = title
        self.emoji = emoji
    }
    
    mutating func setDescription(description: String) {
        self.description = description
    }
    
    mutating func setEvents(events: [String]) {
        self.events = events
    }
    
    mutating func setStatus(status: Int) {
        self.status = status
    }
    
    mutating func setPriority(priority: Int) {
        self.priority = priority
    }
    
    mutating func setTags(tags: [String]) {
        self.tags = tags
    }
    
}
