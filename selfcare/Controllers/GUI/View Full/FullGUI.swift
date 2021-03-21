//
//  FullGUI.swift
//  selfcare
//
//  Created by Michael Brewington on 3/5/21.
//

import Foundation
import UIKit

class FullGUI: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var bg: UIImageView!
    
    var task = [Task]()
    var item = Item(id: "", index: 0, path: [], details: [:])
    var items = [Item]()
    var events = [Event]()
    var selectedEvents = [Event]()
    var wallet = [Wallet]()
    var tags = [Tag]()
    
    var favorited = Bool()
    
    var selectedRow = Int()
    let cellDescriptionIdentifier = "addDescription"
    let cellEventsId = "addEvents"
    let cellPriorityId = "addPriority"
    let cellTagsId = "addTags"
    
    var aboutHeight = CGFloat()
    var descriptionHeight: CGFloat = 50
    var holdTextView = UITextView()
    
    var descriptionBool = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "FullGUIView")
        //Observe Notifications for Task Details
        NotificationCenter.default.addObserver(self, selector: #selector(setupTaskDetails(notification:)), name: .toFullView, object: nil)
        hideKeyboardWhenTappedAround()
        updateTask()
        updateDescriptionHeight()
        calculateAboutHeight()
        setupTableView()
        setupBG()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.standardAppearance.setBackIndicatorImage(#imageLiteral(resourceName: "backIcon"), transitionMaskImage: #imageLiteral(resourceName: "backIcon"))
    }
    
    //About
    //Tasks
    //***Notes
    //***Projects
    //***Reflection
    
}

extension FullGUI {
    
    func setupNavigationBar() {
        //
        //let details = item.details
        //let emoji = details["emoji"] as? String ?? "🖤"
        //et title = details["title"] as? String ?? "(no title)"
        //
        //navigationItem.title = "\(title)"
        //Tint Color
        navigationController?.navigationBar.tintColor = UIColor.white
        //Font
        //navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "Nexa-Bold", size: 22)!]
        //Remove Back Bar Button Text
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //Style Navigation Bar
        navigationController?.navigationBar.standardAppearance.backgroundColor = .clear
        navigationController?.navigationBar.standardAppearance.backgroundEffect = .none
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        //
        updateButtons()
    }
    
    @objc func favoriteAction() {
        favorited = !favorited
        updateButtons()
        //Pass To Firebase
    }
    
    func returnFavorited()->UIImage {
        switch favorited {
        case true:
            let image = #imageLiteral(resourceName: "star_fill")
            return image
        case false:
            let image = #imageLiteral(resourceName: "star")
            return image
        }
    }
    
    func updateButtons(){
        let favoriteButton = UIBarButtonItem(image: returnFavorited(), style: .plain, target: self, action: #selector(favoriteAction))
        let editButton = UIBarButtonItem(image: #imageLiteral(resourceName: "pen"), style: .plain, target: self, action: #selector(editAction))
        let settingsButton = UIBarButtonItem(image: #imageLiteral(resourceName: "threedots"), style: .plain, target: self, action: #selector(settingsAction))
        navigationItem.rightBarButtonItems = [settingsButton,editButton,favoriteButton]
    }
    
    @objc func editAction() {
        //Segue To Edit
        handleEdit()
    }
    
    @objc func settingsAction() {
        //Open Model
    }
    
}

extension FullGUI {
    
    func setupTableView()
    {
        //print("AddMenuCell: allTags: \(allTags.count)")
        // Title
        tableView.register(UINib(nibName: "FullViewTitle", bundle: nil), forCellReuseIdentifier: "fullViewTitle")
        //
        // Folder
        //
        // Status
        tableView.register(UINib(nibName: "FullViewStatusCell", bundle: nil), forCellReuseIdentifier: "fullViewStatus")
        //
        // Task
        //
        // File Path
        tableView.register(UINib(nibName: "ViewFullFilePathCell", bundle: nil), forCellReuseIdentifier: "viewFullFilePath")
        // Menu
        tableView.register(UINib(nibName: "FullViewMenu", bundle: nil), forCellReuseIdentifier: "fullViewMenu")
        //
        tableView.register(UINib(nibName: "FullViewMenuMini", bundle: nil), forCellReuseIdentifier: "fullViewMenuMini")
       //
        tableView.register(UINib(nibName: "ViewFullMenuTableCell", bundle: nil), forCellReuseIdentifier: "viewFullMenuTable")
        
        tableView.delegate = self
        tableView.dataSource = self
        //
        tableView.tableFooterView = UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return switchNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return switchNumberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return switchCellForRowAt(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return switchHeightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section > 0 {
            if item.index == 0 {
                if selectedRow != indexPath.section {
                    selectedRow = indexPath.section
                    tableView.reloadData()
                }
            } else {
                if selectedRow != indexPath.section - 1 {
                    selectedRow = indexPath.section - 1
                    tableView.reloadData()
                }
            }
        }
    }
    
}

extension FullGUI {
    
    func switchCellForRowAt(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        if item.index == 0 {
            //Switch based on section
            return switchCellSectionFolder(tableView: tableView, indexPath: indexPath)
        } else {
            //Switch based on section
            return switchCellSectionTask(tableView: tableView, indexPath: indexPath)
        }
    }
    
    func switchCellSectionFolder(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        switch indexPath.section {
        case 0:
            return switchFolder(tableView: tableView, indexPath: indexPath)
        case 1...4:
            return switchFolderSection1(tableView: tableView, indexPath: indexPath)
        default:
            return switchFolder(tableView: tableView, indexPath: indexPath)
        }
    }
    
    func switchFolder(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        switch indexPath.row {
        case 0:
            return returnTitle(tableView: tableView, indexPath: indexPath)
        case 1:
            return returnStatus(tableView: tableView, indexPath: indexPath)
        default:
            return returnTitle(tableView: tableView, indexPath: indexPath)
        }
    }
    
    func switchCellSectionTask(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        switch indexPath.section {
        case 0:
            return switchTask(tableView: tableView, indexPath: indexPath)
        case 1...3:
            return switchTaskSection1(tableView: tableView, indexPath: indexPath)
        default:
            return switchTask(tableView: tableView, indexPath: indexPath)
        }
    }
    
    func switchTask(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        switch indexPath.row {
        case 0:
            return returnTitle(tableView: tableView, indexPath: indexPath)
        case 1:
            return returnFilePath(tableView: tableView, indexPath: indexPath)
        case 2:
            if selectedEvents.count > 0 {
                return returnRelevantEvent(tableView: tableView, indexPath: indexPath)
            } else {
                return returnStatus(tableView: tableView, indexPath: indexPath)
            }
        case 3:
            return returnStatus(tableView: tableView, indexPath: indexPath)
        default:
            return returnTitle(tableView: tableView, indexPath: indexPath)
        }
    }
    
    func returnTitle(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "fullViewTitle", for: indexPath) as! FullViewTitleCell
        let details = item.details
        let emoji = details["emoji"] as? String ?? "🖤"
        let title = details["title"] as? String ?? "(no title)"
        cell.setDetails(emoji: emoji, name: title)
        cell.index = item.index
        if item.index == 0 {
            cell.updateType()
        } else {
            let status = details["status"] as? Int ?? 0
            cell.input = status
            cell.updateType()
        }
        cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0);
        return cell
    }
    
    //
    
    func returnStatus(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "fullViewStatus", for: indexPath) as! FullViewStatus
        passStatus(cell: cell)
        //cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0);
        return cell
    }
    
    func switchFolderSection1(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        switch indexPath.row {
        case 0:
            return returnFolderMenu(tableView: tableView, indexPath: indexPath)
        default:
            return returnTaskMenuTable(tableView: tableView, indexPath: indexPath)
        }
    }
    
    func returnFolderMenu(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "fullViewMenu", for: indexPath) as! FullViewMenuCell
        let row = indexPath.section-1
        cell.updateFolderStyle(index: row)
        //print(selectedRow)
        if selectedRow == indexPath.section {
            cell.ifSelected(selected: true)
        } else {
            cell.ifSelected(selected: false)
        }
        //cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0);
        return cell
    }
    
    func switchTaskSection1(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        switch indexPath.row {
        case 0:
            return returnTaskMenu(tableView: tableView, indexPath: indexPath)
        default:
            return returnTaskMenuTable(tableView: tableView, indexPath: indexPath)
        }
    }
    
    func returnTaskMenu(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "fullViewMenu", for: indexPath) as! FullViewMenuCell
        let row = indexPath.section-1
        cell.updateTaskStyle(index: row)
        if selectedRow == indexPath.section - 1 {
            cell.ifSelected(selected: true)
        } else {
            cell.ifSelected(selected: false)
        }
        //cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0);
        return cell
    }
    
    func returnTaskMenuTable(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewFullMenuTable", for: indexPath) as! ViewFullMenuTable
        cell.state = selectedRow
        cell.events = selectedEvents
        cell.tags = tags
        cell.task = []
        cell.task.append(task[0])
        cell.aboutHeight = aboutHeight
        if descriptionBool {
            cell.descriptionH = descriptionHeight
            descriptionBool = false
        }
        cell.descriptionHeight = descriptionHeight
        cell.updateAboutCellHeights()
        cell.tableView.reloadData()
        
        if (indexPath.section == 4 && selectedRow == 4 && item.index == 0) || (item.index > 0 && indexPath.section == 3 && selectedRow == 2){
            cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0);
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        }
        
        //cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0);
        return cell
    }
    
    func returnFilePath(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewFullFilePath", for: indexPath) as! ViewFullFilePath
        passFilePath(cell: cell)
        if item.index > 0 {
            //if items.count > 0 {
            if returnIfStatus() {
                //print("1")
                cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0);
            } else if selectedEvents.count > 0 {
                //print("2")
                cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0);
            } else {
                //print("3")
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        return cell
    }
    
    func returnRelevantEvent(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewFullFilePath", for: indexPath) as! ViewFullFilePath
        passRelevantEvent(cell: cell)
        if returnIfStatus() {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0);
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        return cell
    }
    
    func switchNumberOfSections()->Int{
        if item.index == 0 {
            return folderNumberOfSections()
        } else {
            return taskNumberOfSections()
        }
    }
    
    func folderNumberOfSections()->Int{
        return 5
        //return 5
    }
    
    func taskNumberOfSections()->Int{
        return 4
        //return 4
    }
    
    func switchNumberOfRowsInSection(section: Int)->Int{
        if item.index == 0 {
            return folderNumberOfRowsInSection(section: section)
        } else {
            return taskNumberOfRowsInSection(section: section)
        }
    }
    
    func folderNumberOfRowsInSection(section: Int)-> Int {
        switch section {
        case 0:
            //return 2
            return 2
        case 1...4:
            if selectedRow == (section) {
                return 2
            } else {
                return 1
            }
        default:
            return 0
        }
    }
    
    func returnRow0()->Int{
        var row = 2
        if selectedEvents.count > 0 {
            row = row + 1
        }
        if item.index < 3 {
            let next = wallet[item.index+1].items
            if next.count > 0 {
                row = row + 1
            }
        }
        return row
    }
    
    func taskNumberOfRowsInSection(section: Int) -> Int {
        switch section {
        case 0:
            //return 3
            let row = returnRow0()
            //print(row)
            return row
        case 1...3:
            if selectedRow == (section - 1) {
                return 2
            } else {
                return 1
            }
        default:
            return 1
        }
    }
    
    func switchHeightForRowAt(indexPath: IndexPath)->CGFloat{
        if item.index == 0 {
            return folderHeightForRowAt(indexPath: indexPath)
        } else {
            return taskHeightForRowAt(indexPath: indexPath)
        }
    }
    
    //min 400
    //max 420
    //determine height
    
    func determineTableHeight()->CGFloat{
        var height = view.frame.height
        //74 -> if items
        if item.index == 0 {
            height = height - 92 - (3 * (54)) - 60 - 88 - 92
        } else {
            height = height - 60 - 36 - 88 - (4 * (54)) - 92
            if selectedEvents.count > 0 {
                height = height - 36
            }
        }
        //print(height)
        return height
    }
    
    func folderHeightForRowAt(indexPath: IndexPath)->CGFloat{
        switch indexPath.section {
        case 0:
            return folderSection0Height(indexPath: indexPath)
        case 1...4:
            if indexPath.row == 0 {
                return 54
            } else {
                //return determineTableHeight()
                //determine task, note, project, and reflection height
                return 400
            }
        default:
            return 60
        }
    }
    
    func folderSection0Height(indexPath: IndexPath)->CGFloat{
        switch indexPath.row {
        case 0:
            return 60
        case 1:
            if item.index < 3 {
                if wallet[item.index+1].items.count > 0 {
                    return 66
                } else {
                    return 36
                }
            }
            return 36
            //return 74
            //change height if no tasks
        default:
            return 60
        }
    }
    
    func taskHeightForRowAt(indexPath: IndexPath)->CGFloat{
        switch indexPath.section {
        case 0:
            return taskSection0Height(indexPath: indexPath)
        case 1...4:
            if indexPath.row == 0 {
                return 54
            } else {
               // return 44
                //return determineTableHeight()
                if selectedRow == 0 {
                    return aboutHeight
                } else {
                    //determine task, note, project, and reflection height
                    return 400
                }
            }
        default:
            return 60
        }
    }
    
    func taskSection0Height(indexPath: IndexPath)->CGFloat{
        switch indexPath.row {
        case 0:
            return 60
        case 1:
            return 36
        case 2:
            if selectedEvents.count > 0 {
                //print("events >")
                return 36
            } else {
                return 66
            }
        case 3:
            return 66
        default:
            return 36
        }
    }
    
}

extension FullGUI {
    
    func setupBG(){
        let details = item.details
        let photoURL = details["photoURL"] as? String ?? ""
        let placeholderImage = UIImage(named: "placeholder.jpg")
        bg.sd_setImage(with: URL(string: photoURL), placeholderImage: placeholderImage)
        bg.frame = view.bounds
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.init(rawValue: Int(3.5))!)
         let blurEffectView = UIVisualEffectView(effect: blurEffect)
         blurEffectView.frame = view.bounds
         blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         bg.addSubview(blurEffectView)
        
        if item.index == 0 {
            selectedRow = 1
        }
    }
    
    func SegueToAddFolder(){
        let addFolderView = AddFolderViewController()
        addFolderView.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(addFolderView, animated: true)
    }
    
    func SegueToAddTask(){
        let addTaskView = AddTaskViewController()
        //addTaskView.allTags = tags
        //addTaskView.items = swipeClassView.items
        //addTaskView.wallet = swipeClassView.itemWallet
        addTaskView.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(addTaskView, animated: true)
    }
    
    func handleEdit(){
        if item.index == 0 {
            SegueToAddFolder()
        } else {
            SegueToAddTask()
        }
    }
    
    func updateLabel(items:[Item])->String{
        var string = String()
        //➡️
        if items.count > 0 {
            for i in 0...item.index-1{
                let details = items[i].details
                let title = details["title"] as! String
                string.append(title)
                if i != item.index-1 {
                    string.append(" ➡️ ")
                }
            }
           return string
        } else {
           return ""
        }
    }
    
    func passFilePath(cell: ViewFullFilePath) {
        let filepath = updateLabel(items: items)
        //let string = "In List: \(filepath)"
        let attribute = [ NSAttributedString.Key.font: UIFont(name: "Nexa-Bold", size: 20.0)!,NSAttributedString.Key.foregroundColor: UIColor.init(red: 220/255, green: 220/255, blue: 220/255, alpha: 0.9) ]
        let preString = NSMutableAttributedString(string: "In File: ", attributes: attribute )
        let attribute2 = [ NSAttributedString.Key.font: UIFont(name: "Nexa-Bold", size: 20.0)!,NSAttributedString.Key.foregroundColor: UIColor.white ]
        let postString = NSMutableAttributedString(string: filepath, attributes: attribute2 )
        preString.append(postString)
        cell.updateFilePath(string: preString)
    }
    
    func updateEventLabel()->String{
        //print("events: \(selectedEvents.count)")
        if selectedEvents.count > 0 {
            let first = selectedEvents[0]
            let dates = dateLabel(event: first)
            let times = timeLabel(event: first)
            return "\(dates) ∙ \(times)"
        } else {
            return ""
        }
    }
    
    func passRelevantEvent(cell: ViewFullFilePath){
        let eventString = updateEventLabel()
        //let attribute2 = [ NSAttributedString.Key.font: UIFont(name: "Nexa-Bold", size: 20.0)!,NSAttributedString.Key.foregroundColor: UIColor.white ]
        //let string = NSMutableAttributedString(string: eventString, attributes: attribute2 )
       // cell.updateFilePath(string: string)
        //⏱⌛️⏳🗓📆📅
        cell.filePath.font = cell.filePath.font.withSize(18)
        cell.updateFilePath2(string: "🗓 \(eventString)")
    }
    
    func passStatus(cell: FullViewStatus){
        if item.index == 0 {
            //let next = wallet[item.index].items
            let next = wallet[1].items
            //print("next: \(next.count)")
            cell.items = next
            cell.updateArray()
        } else {
            if item.index < 3 {
                let next = wallet[item.index+1].items
                //print("next: \(next.count)")
                cell.items = next
                cell.updateArray()
            }
        }
    }
    
    func returnIfStatus()->Bool{
        if item.index < 3 {
            let next = wallet[item.index+1].items
            if next.count > 0 {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    //Title, Status, [Tasks,Notes,Projects,Reflections]
    //Title, File Path, Relevant Event, [About, Files, Notes]
    //Modify, Favorite, Settings(*Pin, Delete, Cancel)
    
    
    
}

extension UIViewController {
    
    func dateLabel(event: Event) -> String {
        var labelText = String()
        //print("date count: \(event.date.count)")
        if event.date.count > 0 {
            for i in 0...event.date.count-1{
                labelText.append("\(returnDateString(date: event.date[i]))")
                if i != event.date.count-1 {
                    labelText.append(" - ")
                }
            }
        }
        return labelText
    }
    
    func returnDateString(date: Date)->String{
        let formatter = DateFormatter()
        //formatter.dateFormat = "MMM d, yyyy"
        formatter.dateFormat = "E, MMM d"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    //Sort Time
    //No Time
    
    func timeLabel(event: Event) -> String {
        var labelText = String()
        if event.time.count > 0 {
            for i in 0...event.time.count-1{
                if event.time[i] == "24:00" {
                    
                } else {
                    labelText.append(convertFromMilitary(time: "\(event.time[i])"))
                    if !event.time.contains("24:00") && i != event.time.count - 1 {
                        labelText.append(" - ")
                    }
                }
            }
            if labelText.isEmpty {
                labelText = "All-day"
            }
        }
        return labelText
    }
    
    func convertFromMilitary(time: String)->String{
        let array = time.components(separatedBy: ":")
        var hour = Int(array[0]) ?? 0
        let minute = array[1]
        var convertedTime = String()
        var ending = String()
        if array.count > 0 {
            if hour >= 12{
                if hour == 24 {
                    convertedTime = "All-day"
                } else {
                    hour = hour - 12
                    if hour == 0 {
                        hour = 12
                    }
                    ending = "PM"
                    convertedTime = "\(hour):\(minute) \(ending)"
                }
            } else {
                if hour == 0 {
                    hour = 12
                }
                ending = "AM"
                convertedTime = "\(hour):\(minute) \(ending)"
            }
        }
        return convertedTime
    }
    
}

extension FullGUI {
    
    @objc func setupTaskDetails(notification: NSNotification){
        if let index = notification.userInfo?["index"] as? Int {
            switchEventDetails(index: index, notification: notification)
        }
    }
    
    //Place data in object
    func switchEventDetails(index: Int,notification: NSNotification){
        switch index {
        case 0: //Description
            notifDescription(notif: notification)
        case 1: //Events
            notifEvents(notif: notification)
        case 2: //Priority
            notifPriority(notif: notification)
        case 3: //Tags
            notifTags(notif: notification)
        default:
            break
        }
    }
    
    func notifDescription(notif:NSNotification){
        let taskDescription = notif.userInfo?["description"] as? String ?? ""
        descriptionHeight = notif.userInfo?["height"] as? CGFloat ?? CGFloat(50)
        calculateAboutHeight()
        //print("\(descriptionHeight) : \(taskDescription)")
        task[0].setDescription(description: taskDescription)
        tableView.reloadData()
    }
    
    func notifEvents(notif:NSNotification){
        //Modify or New
        //let blank = Event(id: "", date: [Date()], time: [String](), repeating: [String:Any](), notify: [[String:Any]](), location: [String]())
        //let event = notif.userInfo?["event"] as? Event ?? blank
        //events.append(event)
        tableView.reloadData()
    }
    
    func notifPriority(notif:NSNotification){
        let priority = notif.userInfo?["priority"] as? Int ?? Int()
        task[0].setPriority(priority: priority)
    }
    
    func notifTags(notif:NSNotification){
        let input = notif.userInfo?["input"] as? Int ?? Int()
        if input == 0 {
            //print("zero")
            //let tag = notif.userInfo?["tag"] as! Tag
            //allTags.append(tag)
            //Refresh from database or pass holdTags or sort tags by title
            tableView.reloadData()
        } else if input == 1 {
            //print("one")
            //tags = notif.userInfo?["tags"] as? [String] ?? tags
            //task[0].setTags(tags: tags)
            //selectedTags = notif.userInfo?["selected"] as? [Tag] ?? selectedTags
            tableView.reloadData()
        } else {
            //print("two")
            //selectedTags = notif.userInfo?["selected"] as? [Tag] ?? selectedTags
            tableView.reloadData()
        }
        
    }
    
    //✅ Create XIBS for cells
    //Determine Height Based On Details
    //Pass in height values
    //Retrive changes from XIB and reload table view
    
    func updateDescriptionHeight(){
        if task.count > 0 && item.index > 0 {
            if task[0].description != "" {
                descriptionBool = true
                holdTextView = UITextView(frame: CGRect(x: 0, y: 0, width: 414, height: 100))
                holdTextView.translatesAutoresizingMaskIntoConstraints = false
                holdTextView.isScrollEnabled = false
                holdTextView.text = task[0].description
                let height = holdTextView.contentSize.height
                //let height = holdTextView.contentSize.height
                //print("\(height): \(task[0].description)")
                if height >= 50 {
                    descriptionHeight = height
                } else {
                    descriptionHeight = height + 6
                }
                //print("")
            }
        }
    }
    
    func calculateAboutHeight(){
        var height: CGFloat = 50 //Priority
        height = height + descriptionHeight + 6
        if events.count > 0 {
            height = height + 170
        } else {
            height = height + 50
        }
        if tags.count > 0 {
            height = height + 200
        } else {
            height = height + 50
        }
        aboutHeight = height
    }
    
    func updateTask(){
        if item.index == 0 {
            task.append(Task(title: "(no title)", emoji: "🖤", description: "", events: [], status: 0, priority: 0, tags: [], photoURL: "", color: ""))
        } else {
            let hold = Task(snapshot: item.details)
            task.append(hold)
        }
    }
    
}
