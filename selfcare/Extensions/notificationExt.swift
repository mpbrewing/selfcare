//
//  notificationExt.swift
//  selfcare
//
//  Created by Michael Brewington on 12/16/20.
//

import Foundation
import UIKit

extension Notification.Name {
    
    //AddButtonViewClass -> HomeViewController
    //*Update Frame
    static let addButton = Notification.Name("addButton")
    
    //AddButtonViewClass -> HomeViewController
    //*Segue based on tapped button
    static let addItemSegue = Notification.Name("addItemSegue")
    
}

//Notifications for adding folder
extension Notification.Name {
    
    //AddPhotoCell -> AddFolderViewController
    //AddColorCell -> AddFolderViewController
    //*Pass Values
    static let addFolderDetails = Notification.Name("addFolderDetails")
    
}


//Notifications for adding task
extension Notification.Name {
    
    //AddDescriptionCell -> AddTaskViewController
    //...filepath
    //FullEvents -> AddTaskViewController
    //AddStatusCell -> AddTaskViewController
    //AddPriorityCell -> AddTaskViewController
    //...tags
    //*Pass Description, *FilePath, Events, Status, Priority, and *Tags
    static let addTaskDetails = Notification.Name("addTaskDetails")
    
    //EventLabelCell -> EventNotifyCell
    //*Remove Notification
    static let xibToNotify = Notification.Name("xibToNotify")
    
    //EventDateCell -> FullEvents
    //EventTimeCell -> FullEvents
    //EventRepeatCell -> FullEvents
    //EventNotifyCell -> FullEvents
    //EventLocationCell -> FullEvents
    //*Pass Date, Time, Repeat, Notify, and Location
    static let addEventXib = Notification.Name("addEventXib")
    
    
}

/*
 
 ex. Observer
 
 NotificationCenter.default.addObserver(self, selector: #selector(setAddButton(notification:)), name: .addButton, object: nil)
 
 //
 
 ex. Observer Function
 
 @objc func setAddButton(notification: NSNotification) {
     if let state = notification.userInfo?["state"] as? Bool {
         setButtonFrame(state: state)
     }
 }
 
 //
 
 ex. Post Function
 
 func passButtonSelectionSegue(row: Int)
 {
     let passState = ["switchSegue":row]
     NotificationCenter.default.post(name: .addItemSegue, object: nil,userInfo: passState)
 }
 
*/
