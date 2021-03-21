//
//  notificationExt.swift
//  selfcare
//
//  Created by Michael Brewington on 12/16/20.
//

import Foundation
import UIKit

//Notifications for updating add button frame and actions
extension Notification.Name {
    
    //AddButtonViewClass -> HomeViewController
    //*Update Frame
    static let addButton = Notification.Name("addButton")
    
    //AddButtonViewClass -> HomeViewController
    //*Segue based on tapped button
    static let addItemSegue = Notification.Name("addItemSegue")
    
    static let toSwipeBarClass = Notification.Name("toSwipeBarClass")
    
    static let toSwipeClass = Notification.Name("toSwipeClass")
    
}

//Notifications for adding folder
extension Notification.Name {
    
    //AddTitleCell -> AddFolderViewController
    //AddPhotoCell -> AddFolderViewController
    //AddColorCell -> AddFolderViewController
    //*Pass Values
    static let addFolderDetails = Notification.Name("addFolderDetails")
    
}


//Notifications for adding task
extension Notification.Name {
    
    //AddTitleCell -> AddTaskViewController
    //AddDescriptionCell -> AddTaskViewController
    //...filepath
    //FullEvents -> AddTaskViewController
    //AddStatusCell -> AddTaskViewController
    //AddPriorityCell -> AddTaskViewController
    //...tags
    //*Pass Description, *FilePath, Events, Status, Priority, and *Tags
    static let addTaskDetails = Notification.Name("addTaskDetails")

    //*Update Clock and Mini Clock
    static let xibToTime = Notification.Name("xibtoTime")
    
    //OccurrencesCell -> RepeatEnds
    //OnADateCell -> RepeatEnds
    //ExcludedDates -> RepeatEnds
    static let xibToEnds = Notification.Name("xibToEnds")
    
    //RepeatEnds -> RepeatSelection
    static let endsToSelection = Notification.Name("endsToSelection")
    
    //repeatMonthCell -> EventRepeatCell
    //RepeatWeekCell -> EventRepeatCell
    //RepeatSelectionCell -> EventRepeatCell
    static let xibToRepeat = Notification.Name("xibToRepeat")
    
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
    
    //SelectTagsTableViewCell -> AddTagsCell
    static let selectToAddTags = Notification.Name("selectToAddTags")
    
    //SwipeClass -> AddTaskViewController
    
    
}

extension Notification.Name {
    //FullViewDescription -> FullGUI
    static let toFullView = Notification.Name("toFullView")
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
