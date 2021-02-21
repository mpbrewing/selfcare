//
//  AddMenuCell.swift
//  selfcare
//
//  Created by Michael Brewington on 12/8/20.
//

import Foundation
import UIKit

class AddMenuCell: UITableViewCell,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuBar: UIView!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var tasksButton: UIButton!
    @IBOutlet weak var notesButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib(){
        super.awakeFromNib()
        setupXIB()
        setupTableView()
        setupSwipe()
    }
    
    func setupXIB()
    {
        menuBar.layer.cornerRadius = 3
    }
    
    var addState = 0
    var menuState = 0
    var tagsHeight: CGFloat = 50
    var eventsHeight: CGFloat = 50
    
    let cellPhotoIdentifier = "addPhoto"
    let cellColorIdentifier = "addColor"
    let cellDescriptionIdentifier = "addDescription"
    let cellFilePathId = "addFilePath"
    let cellEventsId = "addEvents"
    let cellStatusId = "addStatus"
    let cellPriorityId = "addPriority"
    let cellTagsId = "addTags"
    
    @IBAction func aboutAction(_ sender: Any) {
        menuState = 0
        animateSwitch()
    }
    
    @IBAction func taskAction(_ sender: Any) {
        menuState = 1
        animateSwitch()
    }
    
    @IBAction func notesAction(_ sender: Any) {
        menuState = 2
        animateSwitch()
    }
    
    var items = [Item]()
    var wallet = [Wallet]()
    //var selectedFilePath = [Item]()
    var selectedFilePath: [Item] = [Item]() {
        didSet {
            //print("filePath: \(selectedFilePath.count)")
            tableView.reloadData()
        }
    }
    //var allTags = [Tag]()
    var allTags: [Tag] = [Tag]() {
       didSet {
        if allTags.count > 0 {
            tagsHeight = CGFloat(200)
        } else {
            tagsHeight = CGFloat(50)
        }
        //print("AddMenuCell: \(allTags.count)")
       }
    }
    
    var events: [Event] = [Event]() {
        didSet {
            //print("events: \(events.count)")
            tableView.reloadData()
             if events.count > 0 {
                 eventsHeight = CGFloat(160)
             } else {
                 eventsHeight = CGFloat(50)
             }
        }
    }
}

extension AddMenuCell {
    
    func setupSwipe(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeAction))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeAction))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        contentView.addGestureRecognizer(leftSwipe)
        contentView.addGestureRecognizer(rightSwipe)
    }
    
    @objc func leftSwipeAction() {
        menuState = menuState + 1
        animateSwitch()
    }
     
    @objc func rightSwipeAction() {
        menuState = menuState - 1
        animateSwitch()
    }
    
    func animateSwitch()
    {
        UIView.animate(withDuration: 0.2, animations: {
            self.switchMenuState()
            self.tableView.reloadData()
        })
    }
    
    func switchMenuState()
    {
        limitMenuState()
        let buttonArray = [aboutButton,tasksButton,notesButton]
        let updateFrameArray: [CGFloat] = [CGFloat(0),CGFloat(138),CGFloat(276)]
        
        for i in 0...2 {
            if i == menuState {
                changeButtonState(button: buttonArray[i]!, state: true)
                updateFrame(x: updateFrameArray[i])
            } else {
                changeButtonState(button: buttonArray[i]!, state: false)
            }
        }
    }
    
    func changeButtonState(button: UIButton, state: Bool)
    {
        if state == true {
            button.setTitleColor(.gray, for: .normal)
            button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: 20)
        } else {
            button.setTitleColor(.gainsboro, for: .normal)
            button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: 14)
        }
    }
    
    func updateFrame(x:CGFloat){
        menuBar.frame = CGRect(x: x, y: 44, width: 138, height: 8)
    }
    
    func limitMenuState()
    {
        if menuState > 2 {
            menuState = 0
        } else if menuState < 0 {
            menuState = 2
        }
    }
    
    
    
}

extension AddMenuCell {
    
   

     func setupTableView()
     {
         //print("AddMenuCell: allTags: \(allTags.count)")
         // Title
         tableView.register(UINib(nibName: "AddPhotoView", bundle: nil), forCellReuseIdentifier: cellPhotoIdentifier)
         // Color
         tableView.register(UINib(nibName: "AddColorView", bundle: nil), forCellReuseIdentifier: cellColorIdentifier)
         // Description
         tableView.register(UINib(nibName: "AddDescriptionView", bundle: nil), forCellReuseIdentifier: cellDescriptionIdentifier)
         // File Path
         tableView.register(UINib(nibName: "AddFilePathView", bundle: nil), forCellReuseIdentifier: cellFilePathId)
         // Events
         tableView.register(UINib(nibName: "AddEventsView", bundle: nil), forCellReuseIdentifier: cellEventsId)
         // Status
         tableView.register(UINib(nibName: "AddStatusView", bundle: nil), forCellReuseIdentifier: cellStatusId)
         // Priority
         tableView.register(UINib(nibName: "AddPriorityView", bundle: nil), forCellReuseIdentifier: cellPriorityId)
         // Tags
         tableView.register(UINib(nibName: "AddTagsView", bundle: nil), forCellReuseIdentifier: cellTagsId)
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
        return switchMenuStateNumberOfRows()
    }
    
    func returnAboutNumberOfRows() -> Int
    {
        switch addState {
        case 0:
            return 2
        case 1:
            return 6
        default:
            return 0
        }
    }
    
    func switchMenuStateNumberOfRows() -> Int
    {
        switch menuState {
        case 0:
            return returnAboutNumberOfRows()
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch addState {
        case 0:
            return returnFolderCells(indexPath: indexPath)
        case 1:
            return returnTaskCells(indexPath: indexPath)
        default:
            return returnFolderCells(indexPath: indexPath)
        }
    }
    
    //switchMenuCellForRowAt
    
    func returnFolderCells(indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellPhotoIdentifier, for: indexPath) as! AddPhotoCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellColorIdentifier, for: indexPath) as! AddColorCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellPhotoIdentifier, for: indexPath) as! AddPhotoCell
            return cell
        }
    }
    
    func returnTaskCells(indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellDescriptionIdentifier, for: indexPath) as! AddDescriptionCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellFilePathId, for: indexPath) as! AddFilePathCell
            cell.updateLabel(items: selectedFilePath)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellEventsId, for: indexPath) as! AddEventsCell
            cell.updateLabel(events: events)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellStatusId, for: indexPath) as! AddStatusCell
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellPriorityId, for: indexPath) as! AddPriorityCell
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellTagsId, for: indexPath) as! AddTagsCell
            cell.allTags = allTags
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellDescriptionIdentifier, for: indexPath) as! AddDescriptionCell
            return cell
        }
    }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch addState {
        case 0:
            return returnFolderCellHeight(indexPath: indexPath)
        case 1:
            return returnTaskCellHeight(indexPath: indexPath)
        default:
            return returnFolderCellHeight(indexPath: indexPath)
        }
     }
    
    //switchMenuHeightForRowAt()
    
    func returnFolderCellHeight(indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.row {
        case 0:
            return CGFloat(300)
        case 1:
            return CGFloat(380)
        default:
            return CGFloat(100)
        }
    }
    
    func returnTaskCellHeight(indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.row {
        case 0: //Description
            return CGFloat(50)
        case 2: //Events
            return eventsHeight
        case 3,4: //Status, Priority
            return CGFloat(100)
        case 5: //Tags
            return tagsHeight
        default:
            return CGFloat(50)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch addState {
        case 1:
            returnTaskDidSelectRowAt(indexPath: indexPath)
        default:
            //print(indexPath.row)
            break
        }
        //print(indexPath.row)
    }
    
    func returnTaskDidSelectRowAt(indexPath: IndexPath){
        switch indexPath.row {
        case 1:
            SegueToFilePath()
        case 2:
            if events.count == 0 {
                SegueToEvents()
            }
        case 5:
            if allTags.count == 0 {
                SegueToTags()
            }
        default:
            //print(indexPath.row)
            break
        }
    }
    
    func SegueToFilePath(){
        modifyBackButton()
        let filepath = FullFilePath()
        filepath.wallet = wallet
        filepath.items = items
        filepath.modalPresentationStyle = .fullScreen
        let vc = findViewController()
        vc?.navigationController?.pushViewController(filepath, animated: true)
    }
    
    func SegueToEvents(){
        modifyBackButton()
        let events = FullEvents()
        events.modalPresentationStyle = .fullScreen
        let vc = findViewController()
        vc?.navigationController?.pushViewController(events, animated: true)
    }
    
    func SegueToTags(){
        modifyBackButton()
        let tags = FullTags()
        tags.modalPresentationStyle = .fullScreen
        let vc = findViewController()
        vc?.navigationController?.pushViewController(tags, animated: true)
    }
    
    func modifyBackButton(){
        let vc = findViewController()
        vc?.navigationController?.navigationBar.standardAppearance.setBackIndicatorImage(#imageLiteral(resourceName: "back2"), transitionMaskImage: #imageLiteral(resourceName: "back2"))
    }
    
    
}


