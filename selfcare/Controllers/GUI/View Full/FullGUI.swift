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
    
    var item = Item(id: "", index: 0, path: [], details: [:])
    var items = [Item]()
    
    var favorited = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "FullGUIView")
        setupTableView()
        setupBG()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.standardAppearance.setBackIndicatorImage(#imageLiteral(resourceName: "backIcon"), transitionMaskImage: #imageLiteral(resourceName: "backIcon"))
    }
    
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
        // File Path
        tableView.register(UINib(nibName: "ViewFullFilePathCell", bundle: nil), forCellReuseIdentifier: "viewFullFilePath")
        //
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
        return switchHeightForRowAt()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension FullGUI {
    
    func switchCellForRowAt(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        if item.index == 0 {
            //Switch based on section
            return switchFolder(tableView: tableView, indexPath: indexPath)
        } else {
            //Switch based on section
            return switchTask(tableView: tableView, indexPath: indexPath)
        }
    }
    
    func switchFolder(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        switch indexPath.row {
        case 0:
            return returnTitle(tableView: tableView, indexPath: indexPath)
        default:
            return returnTitle(tableView: tableView, indexPath: indexPath)
        }
    }
    
    func switchTask(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        switch indexPath.row {
        case 0:
            return returnTitle(tableView: tableView, indexPath: indexPath)
        case 1:
            return returnFilePath(tableView: tableView, indexPath: indexPath)
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
        return cell
    }
    
    //file path, events
    //if events.count > 0
    //display most urgent event
    
    //nav bar clear on disappear
    
    func returnFilePath(tableView: UITableView,indexPath: IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewFullFilePath", for: indexPath) as! ViewFullFilePath
        let filepath = updateLabel(items: items)
        //let string = "In List: \(filepath)"
        let attribute = [ NSAttributedString.Key.font: UIFont(name: "Nexa-Bold", size: 20.0)!,NSAttributedString.Key.foregroundColor: UIColor.init(red: 220/255, green: 220/255, blue: 220/255, alpha: 0.9) ]
        let preString = NSMutableAttributedString(string: "In File: ", attributes: attribute )
        let attribute2 = [ NSAttributedString.Key.font: UIFont(name: "Nexa-Bold", size: 20.0)!,NSAttributedString.Key.foregroundColor: UIColor.white ]
        let postString = NSMutableAttributedString(string: filepath, attributes: attribute2 )
        preString.append(postString)
        cell.updateFilePath(string: preString)
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
        return 1
        //return 5
    }
    
    func taskNumberOfSections()->Int{
        return 1
        //return 4
    }
    
    func switchNumberOfRowsInSection(section: Int)->Int{
        if item.index == 0 {
            return folderNumberOfRowsInSection(section: section)
        } else {
            return 2
        }
    }
    
    func folderNumberOfRowsInSection(section: Int)-> Int {
        switch section {
        case 0:
            //return 2
            return 1
        case 1: //Based on selected field - return 1 or count + 1
            return 0
        case 2:
            return 0
        case 3:
            return 0
        case 4:
            return 0
        default:
            return 0
        }
    }
    
    func taskNumberOfRowsInSection(section: Int) -> Int {
        switch section {
        case 0:
            //return 3
            return 2
        case 1: //Based on selected field - return 1 or count + 1
            return 0
        case 2:
            return 0
        case 3:
            return 0
        default:
            return 0
        }
    }
    
    func switchHeightForRowAt()->CGFloat{
        return 60
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
    
    
    
}
