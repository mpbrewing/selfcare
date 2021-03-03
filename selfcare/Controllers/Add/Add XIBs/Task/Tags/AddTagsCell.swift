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
    
    //Dict
    
    var tags = [String]()
    
    var selectedTags: [Tag] = [Tag]() {
        didSet  {
            tagsTableView.reloadData()
        }
    }
    //var counter = 0
    var remainingTags = [Tag]()
    var holdTags = [Tag]()
    
    var allTags: [Tag] = [Tag]() {
       didSet {
            filterRemainingTags()
       }
    }
    
    var status = Int()
    
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
    
    func updateLabel(){
        if selectedTags.count > 0 {
            tagsLabel.textColor = UIColor.black
            if selectedTags.count == 1 {
                //tagsLabel.text = "\(selectedTags.count) tag selected"
                tagsLabel.text = "\(selectedTags.count) Tag"
            } else {
                //tagsLabel.text = "\(selectedTags.count) tags selected"
                tagsLabel.text = "\(selectedTags.count) Tags"
            }
        } else {
            tagsLabel.textColor = UIColor.lightGray
            tagsLabel.text = "Tags"
        }
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
        cell.tags = holdTags
        cell.selectedTags = selectedTags
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
            return 90
        case 1:
            return 50
        default:
            return 50
        }
    }
    
    func SegueToTags(){
        //print("SegueToTags")
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

extension AddTagsCell {
    
    func updateIcon(){
       // let colors = [UIColor.gainsboro,UIColor.systemRed,UIColor.systemYellow,UIColor.systemGreen]
        if selectedTags.count > 0 {
            icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
           // icon.tintColor = UIColor.silver
            //icon.tintColor = UIColor.systemGreen
            //icon.tintColor = colors[status]
        } else {
            icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
            icon.tintColor = UIColor.gainsboro
        }
    }
    
    func passTags()
    {
        //Pass Index and Tags
        let notif = ["index":6,"input":1,"tags":tags,"selected":selectedTags] as [String : Any]
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
            //print("index: \(index)")
            passTags()
        }
    }
    
    func updateSelected(tag: Tag,path:Int){
        //Remove Tag From Selected
        selectedTags.remove(at: path)
        //Append Tag To Remaining
        remainingTags.append(tag)
        //Filter Tags
        //print("selected: \(selectedTags.count)")
        filterRemainingTags()
        //
        tagsTableView.reloadData()
    }
    
    func updateRemaining(tag: Tag,path:Int){
        //Append Tag To Selected
        selectedTags.append(tag)
        //Remove Tag From Remaining
        //print(remainingTags.count)
        remainingTags.remove(at: path)
        //
        //print("\(tag.title): \(selectedTags.count)")
        filterRemainingTags()
        //
        tagsTableView.reloadData()
    }
    
    func filterRemainingTags(){
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
        sortTags()
        updateHoldTags()
    }
    
    func sortTags(){
        selectedTags = selectedTags.sorted(by: { $0.color < $1.color })
        remainingTags = remainingTags.sorted(by: { $0.color < $1.color })
    }
    
    func updateHoldTags(){
        holdTags = selectedTags + remainingTags
        updateLabel()
        updateIcon()
    }
   
    
}
