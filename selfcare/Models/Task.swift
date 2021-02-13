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
    var photoURL: String
    var color: String
     
    init(title: String, emoji: String, description: String, events: [String],status: Int, priority: Int,tags: [String],photoURL: String, color: String) {
        self.title = title
        self.emoji = emoji
        self.description = description
        self.events = events
        self.status = status
        self.priority = priority
        self.tags = tags
        self.photoURL = photoURL
        self.color = color
    }
     
    func toAnyObject() -> Any {
        return [
            "title": title,
            "emoji": emoji,
            "description": description,
            "events": events,
            "status": status,
            "priority": priority,
            "tags": tags,
            "photoURL": photoURL,
            "color": color
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
        self.photoURL = snapshot["photoURL"] as! String
        self.color = snapshot["color"] as! String
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
    
    mutating func setPhotoURL(url: String) {
        self.photoURL = url
    }
    
    mutating func setColor(color: String) {
        self.color = color
    }
    
}
