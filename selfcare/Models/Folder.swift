//
//  Folder.swift
//  selfcare
//
//  Created by Michael Brewington on 12/15/20.
//

import Foundation

class Folder {
    
    var title: String
    var emoji: String
    var photoURL: String
    var color: String
    
    init(title: String, emoji: String, photoURL: String, color: String) {
        self.title = title
        self.emoji = emoji
        self.photoURL = photoURL
        self.color = color
    }
    
    init(snapshot: [String:Any]) {
        self.title = snapshot["title"] as! String
        self.emoji = snapshot["emoji"] as! String
        self.photoURL = snapshot["photoURL"] as! String
        self.color = snapshot["color"] as! String
    }
    
    func setTitle(title: String, emoji: String) {
        self.title = title
        self.emoji = emoji
    }
    
    func setPhotoURL(url: String) {
        self.photoURL = url
    }
    
    func setColor(color: String) {
        self.color = color
    }
    
    func toAnyObject() -> Any {
        return [
            "title": title,
            "photoURL": photoURL,
            "color": color
        ]
    }
    
}
