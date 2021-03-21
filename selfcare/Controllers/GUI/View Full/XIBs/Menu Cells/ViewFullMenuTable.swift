//
//  ViewFullMenuTable.swift
//  selfcare
//
//  Created by Michael Brewington on 3/14/21.
//

import Foundation
import UIKit
//UITableViewDelegate, UITableViewDataSource
class ViewFullMenuTable: UITableViewCell,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    //About, Tasks, Notes, Projects, Reflection
    
    //
    var state = Int()
    //
    var aboutHeight = CGFloat()
    //
    var descriptionH: CGFloat = 50
    var descriptionBool = Bool()
    var descriptionHeight: CGFloat = CGFloat() {
        didSet {
            if descriptionHeight != descriptionH && descriptionBool == false  {
                descriptionH = descriptionHeight
                descriptionBool = true
                self.tableView.reloadData()
            } else {
            }
        }
    }
    //
    var eventsHeight = CGFloat()
    var priorityHeight = CGFloat()
    var tagsHeight = CGFloat()
    //
    var descriptionText = String()
    var events = [Event]()
    var priority = Int()
    var tags = [Tag]()
    var task: [Task] = [Task](){
        didSet{
            
        }
    }
    var descriptionState = Bool()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateAboutCellHeights()
        setupTableView()
        //print("content size: \(tableView.contentSize.height)")
        //print("frame: \(tableView.frame.height)")
    }
    
    
    
    
}

extension ViewFullMenuTable {
    
    func setupTableView()
    {
        //Menu Cell
        tableView.register(UINib(nibName: "FullViewMenuMini", bundle: nil), forCellReuseIdentifier: "fullViewMenuMini")
        //Description
        tableView.register(UINib(nibName: "FullViewDescriptionCell", bundle: nil), forCellReuseIdentifier: "fullViewDescription")
        //Events
        tableView.register(UINib(nibName: "FullViewEventsCell", bundle: nil), forCellReuseIdentifier: "fullViewEvents")
        //Priority
        tableView.register(UINib(nibName: "FullViewPriorityCell", bundle: nil), forCellReuseIdentifier: "fullViewPriority")
        //Tags
        tableView.register(UINib(nibName: "FullViewTagsCell", bundle: nil), forCellReuseIdentifier: "fullViewTags")
        //
        tableView.delegate = self
        tableView.dataSource = self
        //
        tableView.tableFooterView = UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return switchStateNumberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case 0:
            return returnAboutMenuCells(tableView: tableView, indexPath: indexPath)
        default:
            return returnTasksMenuCell(tableView: tableView, indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return returnHeightForRowAt(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension ViewFullMenuTable {
    
    func switchStateNumberOfRowsInSection()->Int{
        switch state {
        case 0: //About
            return 4
        /*case 1:
            return items.count
        */
        //2 -> notes
        //3 -> projects
        //4 -> reflections
        default:
            return 0
        }
    }
    
    func returnAboutMenuCells(tableView: UITableView,indexPath: IndexPath)->UITableViewCell {
        switch indexPath.row {
        case 0:
            return returnDescription(tableView: tableView, indexPath: indexPath)
        case 1:
            return returnEvents(tableView: tableView, indexPath: indexPath)
        case 2:
            return returnPriority(tableView: tableView, indexPath: indexPath)
        case 3:
            return returnTags(tableView: tableView, indexPath: indexPath)
        default:
            return returnDescription(tableView: tableView, indexPath: indexPath)
        }
    }
    
    //About Cells: Description, Events, Priority, Tags
    
    func returnDescription(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "fullViewDescription", for: indexPath) as! FullViewDescription
        //print("Bool: \(descriptionBool)")
        if cell.descriptionTextView.text! != "Description" && descriptionBool == true{
            //print("contains")
            descriptionBool = false
            cell.updateDescription()
        }
        cell.height = descriptionHeight
        if task.count > 0 {
            if task[0].description != "" && descriptionState == false && task[0].description != "Description" {
                //descriptionState = true
                cell.descriptionTextView.text! = task[0].description
                cell.descriptionTextView.textColor = UIColor.white
            }
        }
        return cell
    }
    
    func returnEvents(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "fullViewEvents", for: indexPath) as! FullViewEvents
        cell.events = events
        return cell
    }
    
    func returnPriority(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "fullViewPriority", for: indexPath) as! FullViewPriority
        cell.priority = priority
        return cell
    }
    
    func returnTags(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "fullViewTags", for: indexPath) as! FullViewTags
        cell.tags = tags
        return cell
    }
    
    // Task/Note Cells
    
    func returnTasksMenuCell(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "fullViewMenuMini", for: indexPath) as! FullViewMenuMiniCell
        cell.updateLabel(string: "\(state): \(indexPath.row)")
        return cell
    }
    
    //Returns Height For Row At
    
    func returnHeightForRowAt(tableView: UITableView,indexPath: IndexPath) -> CGFloat{
        if state == 0 {
            switch indexPath.row {
            case 0:
                return descriptionH + 6
            case 1:
                return eventsHeight
            case 2:
                return priorityHeight
            case 3:
                return tagsHeight
            default:
                return 50
            }
        } else {
            return 50
        }
    }
    
}

extension ViewFullMenuTable {
    
    func updateAboutCellHeights(){
        updateDescriptionHeight()
        updateEventsHeight()
        priorityHeight = 50
        updateTagsHeight()
    }
    
    func updateDescriptionHeight(){
        //Determine based on length of description
        if descriptionHeight == 0 {
            descriptionHeight = 50
        }
    }
    
    func updateDescriptionHeight2(){
        //Determine based on length of description
        if task.count > 0 {
            if task[0].description != "" {
                let holdTextView = UITextView(frame: CGRect(x: 0, y: 0, width: 414, height: 300))
                holdTextView.text = task[0].description
                let height = holdTextView.contentSize.height
                //print("Height: \(height)")
                descriptionHeight = height
            }
        }
    }
    
    func updateEventsHeight(){
        //Determine based on events count
        if events.count > 0 {
            eventsHeight = 170
        } else {
            eventsHeight = 50
        }
    }
    
    func updateTagsHeight(){
        //update based on tags count
        if tags.count > 0 {
            tagsHeight = 200
        } else {
            tagsHeight = 50
        }
    }
    
}
/*
 
 📄📃📋🗒📰🔖📍📌🖋📖📓📁🗄🗃🗂📚📑📜

 Descriptions
 🗓 Events
 ❗️ Priority
 🏷 Tags


 🕑❗️‼️⏳⌛️🕰⏰⏲⏱🧭👁👀🗓📆📅

 📂Folder
 🧩Task
 📝Note
 📚Project
 👁Reflection
 */
