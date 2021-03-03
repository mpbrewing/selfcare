//
//  ViewTags.swift
//  selfcare
//
//  Created by Michael Brewington on 2/24/21.
//

import Foundation
import UIKit

class ViewTags: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var allTags: [Tag] = [Tag]() {
       didSet {
        allTags = allTags.sorted(by: { $0.color < $1.color })
        setupTags()
        tableView?.reloadData()
       }
    }
    var selectedTags: [Tag] = [Tag]() {
       didSet {
        selectedTags = selectedTags.sorted(by: { $0.color < $1.color })
        setupTags()
        tableView?.reloadData()
       }
    }
    
    var selectedArray = [Bool]()
    //var tags: [Tag] = [Tag]()
    var colors = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "ViewTagsView")
        setupNavigationBar()
        //setupStyle()
        setupTableView()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Tags"
        navigationController?.navigationBar.standardAppearance.backgroundColor = .clear
        navigationController?.navigationBar.standardAppearance.backgroundEffect = .none
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setupStyle(){
        view.layer.cornerRadius = 40
        view.layer.borderWidth = 8
        view.layer.borderColor = UIColor.systemTeal.cgColor
        colors = [UIColor.gainsboro,UIColor.brown,UIColor.black,UIColor.systemRed,UIColor.yourPink,UIColor.systemPurple,UIColor.systemBlue,UIColor.systemTeal,UIColor.systemGreen,UIColor.conifer,UIColor.systemYellow,UIColor.systemOrange]
    }
    
}

extension ViewTags {
    
    func setupTableView()
    {
        // Select Tags
        tableView.register(UINib(nibName: "ViewTagsTableViewCell", bundle: nil), forCellReuseIdentifier: "viewTagsCell")
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
        return allTags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewTagsCell", for: indexPath) as! ViewTagsCell
        let tag = allTags[indexPath.row]
        cell.updateSelected(input: tag.title, color: colors[tag.color], state: selectedArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 54
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedArray[indexPath.row] == true {
            selectedArray[indexPath.row] = false
            updateSelected(row: indexPath.row, bool: false)
        } else {
            selectedArray[indexPath.row] = true
            updateSelected(row: indexPath.row, bool: true)
        }
        tableView.reloadData()
    }
    
    func updateBool(){
        if allTags.count > 0 {
            for i in 0...allTags.count-1 {
                let tag = allTags[i]
                if selectedTags.contains(where: { $0 === tag }) {
                    selectedArray[i] = true
                } else {
                    selectedArray[i] = false
                }
            }
        }
    }
    
    func updateSelected(row: Int,bool: Bool){
        let tag = allTags[row]
        if bool == true {
            //append
            selectedTags.append(tag)
        } else {
            //remove
            for i in 0...selectedTags.count-1 {
                //print(selectedTags.count)
                if tag.id == selectedTags[i].id {
                    selectedTags.remove(at: i)
                    break
                }
            }
        }
        passTags()
    }
    
    func passTags()
    {
        //Pass Index and Tags
        let notif = ["index":6,"input":2,"selected":selectedTags] as [String : Any]
        NotificationCenter.default.post(name: .addTaskDetails, object: nil,userInfo: notif)
    }
    
    func setupTags(){
        selectedArray = Array(repeating: false, count: allTags.count)
        updateBool()
        //print(selectedTags.count)
        colors = [UIColor.gainsboro,UIColor.brown,UIColor.black,UIColor.systemRed,UIColor.yourPink,UIColor.systemPurple,UIColor.systemBlue,UIColor.systemTeal,UIColor.systemGreen,UIColor.conifer,UIColor.systemYellow,UIColor.systemOrange]
    }
    
}
