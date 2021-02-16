//
//  Tag.swift
//  selfcare
//
//  Created by Michael Brewington on 2/14/21.
//

//import Foundation

class Tag {
    
    var id: String
    var color: Int
    var title: String
    
    init(id: String,color:Int,title:String){
        self.id = id
        self.color = color
        self.title = title
    }
    
    init(snapshot: [String:Any]) {
        self.id = snapshot["id"] as! String
        self.color = snapshot["color"] as! Int
        self.title = snapshot["title"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "color": color,
            "title": title
        ]
    }
    
}
