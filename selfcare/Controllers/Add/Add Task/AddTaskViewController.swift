//
//  AddTaskViewController.swift
//  selfcare
//
//  Created by Michael Brewington on 12/3/20.
//

import Foundation
import UIKit

class AddTaskViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "AddTaskView")
        //
        //print("Wallet: \(wallet.count)")
        //Table View
        setupTableView()
        //Hide Keyboard when user taps screen
        hideKeyboardWhenTappedAround()
        //Observe Notifications for Task Details
        NotificationCenter.default.addObserver(self, selector: #selector(setupTaskDetails(notification:)), name: .addTaskDetails, object: nil)
        //
        task.append(Task(title: "(no title)", emoji: "🖤", description: "", events: [], status: 0, priority: 0, tags: []))
        //
        item.append(Item(id: "", index: 0, path: [], details: [:]))
        //
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Setup Navigation Bar Style
        modifyAddNavBar()
        //Add Title and Save Button
        setupNavigationBar()
        navigationController?.navigationBar.standardAppearance.setBackIndicatorImage(#imageLiteral(resourceName: "exitIcon"), transitionMaskImage: #imageLiteral(resourceName: "exitIcon"))
    }
    
    let cellTitleIdentifier = "addTitle"
    let cellMenuIdentifier = "addMenu"
    
    var taskTitle = String()
    var taskEmoji = String()
    var taskDescription = String()
    var filePath = [String]()
    var events = [Event]()
    var status = Int()
    var priority = Int()
    var tags = [String]()
    
    var task = [Task]()
    var item = [Item]()
    var items = [Item]()
    var selectedItems = [Item]()
    var wallet = [Wallet]()
    
}

//Navigation Bar
extension AddTaskViewController {
    
    func setupNavigationBar() {
        //Setup Navigation Bar Title
        //Title
        navigationItem.title = "Task"
        //Frame
        let btn1 = UIButton(type: .custom)
        btn1.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        //Font
        btn1.titleLabel?.font =  UIFont(name: "Nexa-Normal", size: 10)
        //Setup Save Button
        //Title
        let attributedTitle = NSAttributedString(string: "Save", attributes: [.foregroundColor: UIColor.white, .font: UIFont(name: "Nexa-Bold", size: 14)!])
        btn1.setAttributedTitle(attributedTitle, for: .normal)
        //Corner Radius
        btn1.layer.cornerRadius = 8
        //Background Color
        btn1.backgroundColor = UIColor.systemGreen
        //Target Action
        btn1.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        //Set as Navigation Right Bar Button
        let saveButton = UIBarButtonItem(customView: btn1)
        navigationItem.rightBarButtonItem = saveButton
        //Remove Back Bar Button Text
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //Style Navigation Bar
        navigationController?.navigationBar.standardAppearance.backgroundColor = .clear
        navigationController?.navigationBar.standardAppearance.backgroundEffect = .none
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
     @objc func saveButtonAction() {
        print("AddTaskViewController: SaveButtonAction")
        //Upload Events
        uploadEvents(events: events, completion: {taskEvents in
            self.task[0].setEvents(events: taskEvents)
            //Upload Item
            let holdTask = self.task[0].toAnyObject() as! [String:Any]
            self.item[0].setDetails(details: holdTask)
            let holdItem = self.item[0].toAnyObject() as! [String:Any]
            self.uploadItem(item: holdItem, completion: { taskItem in
                print(taskItem)
            })
        })
        navigationController?.popViewController(animated: true)
     }
     
}

//UITableView
extension AddTaskViewController {

     func setupTableView()
     {
         // Title
         tableView.register(UINib(nibName: "AddTitleView", bundle: nil), forCellReuseIdentifier: cellTitleIdentifier)
         // Menu
         tableView.register(UINib(nibName: "AddMenuView", bundle: nil), forCellReuseIdentifier: cellMenuIdentifier)
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: //Title
            let cell = tableView.dequeueReusableCell(withIdentifier: cellTitleIdentifier, for: indexPath) as! AddTitleCell
            cell.state = 1
            return cell
        case 1: //Swipe Menu
            let cell = tableView.dequeueReusableCell(withIdentifier: cellMenuIdentifier, for: indexPath) as! AddMenuCell
            cell.addState = 1
            cell.selectedItems = selectedItems
            cell.items = items
            cell.wallet = wallet
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellTitleIdentifier, for: indexPath) as! AddTitleCell
            return cell
        }
    }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         switch indexPath.row {
         case 0: //Title Height
             return 60
         case 1: //Swipe Menu Height
             return 743
         default:
             return 50
         }
     }
    
}

//Handle Task Details
extension AddTaskViewController {
    
    @objc func setupTaskDetails(notification: NSNotification){
        if let index = notification.userInfo?["index"] as? Int {
            switchEventDetails(index: index, notification: notification)
        }
    }
    
    //Place data in object
    func switchEventDetails(index: Int,notification: NSNotification){
        switch index {
        case 0: //Title
            notifTitle(notif: notification)
        case 1: //Description
            notifDescription(notif: notification)
        case 2: //File Path
            notifFilePath(notif: notification)
        case 3: //Events
            notifEvents(notif: notification)
        case 4: //Status
            notifStatus(notif: notification)
        case 5: //Priority
            notifPriority(notif: notification)
        case 6: //Tags
            notifTags(notif: notification)
        case 7: //SwipeClass
            notifSwipeClass(notif: notification)
        default:
            break
        }
    }
    
    func notifTitle(notif:NSNotification){
        taskTitle = notif.userInfo?["title"] as? String ?? "(no title)"
        taskEmoji = notif.userInfo?["emoji"] as? String ?? "🖤"
        task[0].setTitle(title: taskTitle, emoji: taskEmoji)
    }
    
    func notifDescription(notif:NSNotification){
        taskDescription = notif.userInfo?["description"] as? String ?? ""
        task[0].setDescription(description: taskDescription)
    }
    
    func notifFilePath(notif:NSNotification){
        filePath = notif.userInfo?["filePath"] as? [String] ?? [String]()
        item[0].path = filePath
        item[0].index = filePath.count
        selectedItems = notif.userInfo?["selected"] as! [Item]
        tableView.reloadData()
    }
    
    func notifEvents(notif:NSNotification){
        let blank = Event(date: [Date()], time: [String](), repeating: [String:Any](), notify: [[String:Any]](), location: [String]())
        let event = notif.userInfo?["event"] as? Event ?? blank
        events.append(event)
    }
    
    func notifStatus(notif:NSNotification){
        status = notif.userInfo?["status"] as? Int ?? Int()
        task[0].setStatus(status: status)
    }
    
    func notifPriority(notif:NSNotification){
        priority = notif.userInfo?["priority"] as? Int ?? Int()
        task[0].setPriority(priority: priority)
    }
    
    func notifTags(notif:NSNotification){
        tags = notif.userInfo?["filePath"] as? [String] ?? [String]()
        task[0].setTags(tags: tags)
    }
    
    func notifSwipeClass(notif:NSNotification){
        print("notfiSwipeClass")
        wallet = notif.userInfo?["wallet"] as? [Wallet] ?? [Wallet]()
    }
    
}
