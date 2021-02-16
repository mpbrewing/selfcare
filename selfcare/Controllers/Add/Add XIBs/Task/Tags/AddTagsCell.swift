//
//  AddTagsCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/12/21.
//

import Foundation
import UIKit

class AddTagsCell: UITableViewCell,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var tagsTableView: UITableView!
    
    var tags = [String]()
    var selectedTags = [Tag]()
    var remainingTags = [Tag]()
    var holdTags = [Tag]()
    var allTags: [Tag] = [Tag]() {
       didSet {
            print("AddTagsCell: \(allTags.count)")
            //remainingTags = allTags
            filterRemainingTags()
            tagsTableView.reloadData()
       }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupXIB()
        setupTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(UpdateCells(notification:)), name: .selectToAddTags, object: nil)
    }
    
    func setupXIB() {
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor.gainsboro
        //filterRemainingTags()
    }
    
}

//TableView
extension AddTagsCell {
    
    func setupTableView()
    {
        // Select Tags
        tagsTableView.register(UINib(nibName: "SelectTagsCell", bundle: nil), forCellReuseIdentifier: "selectTags")
        // Add Another Tag
        tagsTableView.register(UINib(nibName: "AnotherTagCell", bundle: nil), forCellReuseIdentifier: "anotherTag")
        //
        tagsTableView.delegate = self
        tagsTableView.dataSource = self
        //
        tagsTableView.tableFooterView = UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return returnNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return returnCellForRowAt(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return returnHeightForRowAt(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            SegueToTags()
        }
    }
    
    func returnNumberOfRows()->Int{
        switch allTags.count {
        case 0:
            return 0
        case _ where allTags.count > 0:
            return 2
        default:
            return 0
        }
    }
    
    func returnCellForRowAt(tableView: UITableView, indexPath: IndexPath)->UITableViewCell{
        switch indexPath.row {
        case 0:
            return returnTagsCell(tableView: tableView, indexPath: indexPath)
        case 1:
            return returnAnotherCell(tableView: tableView, indexPath: indexPath)
        default:
            return returnAnotherCell(tableView: tableView, indexPath: indexPath)
        }
    }
    
    func returnTagsCell(tableView: UITableView, indexPath: IndexPath) -> SelectTagsTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectTags", for: indexPath) as! SelectTagsTableViewCell
        //cell.state = 1
        //cell.remainingTags = remainingTags
        cell.selectedTags = selectedTags
        cell.tags = holdTags
        //Pass selected and remaining in one array
        //Display differences
        return cell
    }
    
    func returnAnotherCell(tableView: UITableView, indexPath: IndexPath) -> AnotherTag{
        let cell = tableView.dequeueReusableCell(withIdentifier: "anotherTag", for: indexPath) as! AnotherTag
        return cell
    }
    
    func returnHeightForRowAt(tableView: UITableView, indexPath: IndexPath)->CGFloat{
        switch indexPath.row {
        case 0:
            return 100
        case 1:
            return 50
        default:
            return 50
        }
    }
    
    func SegueToTags(){
        //modifyBackButton()
        print("SegueToTags")
        let tags = FullTags()
        tags.modalPresentationStyle = .fullScreen
        let vc = findViewController()
        vc?.navigationController?.pushViewController(tags, animated: true)
    }
    
}

extension AddTagsCell {
    
    func passTags()
    {
        //Pass Index and Tags
        let notif = ["index":6,"input":1,"tags":tags] as [String : Any]
        NotificationCenter.default.post(name: .addTaskDetails, object: nil,userInfo: notif)
    }
    
    @objc func UpdateCells(notification: NSNotification) {
        if let index = notification.userInfo?["index"] as? Int {
            let tag = notification.userInfo?["tag"] as! Tag
            let path = notification.userInfo?["path"] as! Int
            if index == 0 {
                updateSelected(tag: tag, path: path)
            } else {
                updateRemaining(tag: tag, path: path)
            }
        }
    }
    
    func updateSelected(tag: Tag,path:Int){
        //Remove Tag From Selected
        selectedTags.remove(at: path)
        //Append Tag To Remaining
        remainingTags.append(tag)
        //Filter Tags
        filterRemainingTags()
        //
        tagsTableView.reloadData()
    }
    
    func updateRemaining(tag: Tag,path:Int){
        //Append Tag To Selected
        selectedTags.append(tag)
        //Remove Tag From Remaining
        remainingTags.remove(at: path)
        //
        filterRemainingTags()
        //
        tagsTableView.reloadData()
    }
    
    func filterRemainingTags(){
        /*
        remainingTags.sort {
            $0.title < $1.title
        } */
        remainingTags = allTags
        if selectedTags.count > 0 {
            let filtered = allTags.filter({ filter in
                if selectedTags.contains(where: { $0 === filter }){
                    return false
                } else {
                    return true
                }
            })
            remainingTags = filtered
        }
        updateHoldTags()
    }
    
    func updateHoldTags(){
        holdTags = selectedTags + remainingTags
    }
    
}
