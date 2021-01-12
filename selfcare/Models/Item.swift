//
//  Item.swift
//  selfcare
//
//  Created by Michael Brewington on 12/15/20.
//

//import Foundation
//import UIKit

class Item {
    
    var id: String
    var index: Int
    var path: [String]
    var details: [String:Any]
    
    init(id: String, index: Int, path: [String], details: [String:Any]) {
        self.id = id
        self.index = index
        self.path = path
        self.details = details
    }
    
    init(snapshot: [String:Any]) {
        self.id = snapshot["id"] as! String
        self.index = snapshot["index"] as! Int
        self.path = snapshot["path"] as! [String]
        self.details = snapshot["details"] as! [String:Any]
    }
    
    func setDetails(details: [String:Any]) {
        self.details = details
    }
    
    func toAnyObject() -> Any {
        return [
            "index": index,
            "path": path,
            "details": details
        ]
    }
    
}
