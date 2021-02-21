//
//  FullFilePath.swift
//  selfcare
//
//  Created by Michael Brewington on 1/14/21.
//

import Foundation
import UIKit

class FullFilePath: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func saveButtonAction(_ sender: Any) {
        passFilePath()
        navigationController?.popViewController(animated: true)
    }
    
    var items = [Item]()
    var wallet = [Wallet]()
    var itemWallet = [Wallet]()
    var selectedItems = [Item]()
    var filePath = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "FilePathView")
        setupStyle()
        setupNavigationBar()
        //Table View
        setupTableView()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "File Path"
        //Add Save Button
        /*
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
         */
    }
    /*
    @objc func saveButtonAction() {
       print("FullFilePath: SaveButtonAction")
    }
    */
    
    func setupStyle(){
        view.layer.cornerRadius = 40
        view.layer.borderWidth = 8
        view.layer.borderColor = UIColor.appleGreen.cgColor
        saveButton.layer.cornerRadius = 20
        saveButton.layer.backgroundColor = UIColor.appleGreen.cgColor
        itemWallet = wallet
    }
    
}

extension FullFilePath {
    
    func setupTableView()
    {
        // Title
        tableView.register(UINib(nibName: "FilePathRow", bundle: nil), forCellReuseIdentifier: "filePath")
        //
        tableView.delegate = self
        tableView.dataSource = self
        //
        tableView.tableFooterView = UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //numberOfSections: Selected Count +1 if (count<4 and contains files)
        return returnNumberOfSection()
    }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //numberOfRowsInSection: if (section selected count is 1) else (wallet[section].items.count)
        return returnNumberOfRowsInSection(section: section)
    }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filePath", for: indexPath) as! FilePathCell
        var title = String()
        if (indexPath.section < filePath.count) && (filePath.count > 0) {
            let item = selectedItems[indexPath.section]
            cell.updateSelected(select: true)
            title = returnTitle(details: item.details)
            cell.updateCell(input: title, files: returnFiles(item: item))
        } else {
            let item = itemWallet[indexPath.section].items[indexPath.row]
            cell.updateSelected(select: false)
            title = returnTitle(details: item.details)
            cell.updateCell(input: title, files: returnFiles(item: item))
        }
        return cell
     }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 3 {
            if (indexPath.section < filePath.count) && (filePath.count > 0) {
                for _ in indexPath.section...filePath.count-1{
                    //print(indexPath.section)
                    //filePath.remove(at: i)
                    //selectedItems.remove(at: i)
                    filePath.removeLast()
                    selectedItems.removeLast()
                }
                //filterNext()
                self.tableView.reloadData()
            } else {
                filePath.append(itemWallet[indexPath.section].items[indexPath.row].id)
                selectedItems.append(itemWallet[indexPath.section].items[indexPath.row])
                filterNext()
                self.tableView.reloadData()
            }
        }
        //print("section: \(indexPath.section), row: \(indexPath.row), count: \(filePath.count)")
    }
     
}

extension FullFilePath {
    
    func returnNumberOfSection()->Int{
        switch filePath.count {
        case 0:
            if items.count > 0 {
                return 1
            } else {
                return 0
            }
        case 1...3:
            //print("Item Count: \(wallet[filePath.count].items.count)")
            //if (wallet[filePath.count].items.count > 0) && (returnNext(item: selectedItems[filePath.count-1]))  {
            if (returnNext(item: selectedItems[filePath.count-1]))  {
                return (filePath.count + 1)
            } else {
                return filePath.count
            }
        default:
            return 0
        }
    }
    
    func returnNumberOfRowsInSection(section: Int)->Int{
        switch section {
        case 0:
            if items.count > 0 && filePath.count == 0 {
                return wallet[0].items.count
            } else if items.count > 0 && filePath.count > 0 {
                return 1
            } else {
                return 0
            }
        case 1...3:
            if section < filePath.count {
                return 1
           // } else if wallet.count - section == 1 {
            } else if (filePath.count == section) {
                return itemWallet[section].items.count
            } else {
                return 0
            }
        default:
            return 0
        }
    }
    
    func returnNext(item:Item)->Bool{
        let id = item.id
        let filtered = wallet[filePath.count].items.filter({ filter in
            if filter.id != id {
                return filter.path.contains(id)
            } else {
                return false
            }
        })
        if filtered.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    func returnFiles(item: Item)->Bool{
        let id = item.id
        //files -> if (items in (filePath.count + 1) contains id) return true else return false
        let filtered = items.filter({ filter in
            if filter.id != id {
                return filter.path.contains(id)
            } else {
                return false
            }
        })
        if filtered.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    func filterNext(){
        if selectedItems.count > 0 {
            let id = selectedItems[selectedItems.count-1].id
            if selectedItems.count < 3 {
                let filtered = wallet[selectedItems.count].items.filter({ filter in
                    if filter.path.contains(id) {
                        return true
                    } else {
                        return false
                    }
                })
                itemWallet[selectedItems.count] = Wallet(items: filtered)
            }
        }
    }
    
    func returnTitle(details: [String:Any])->String{
        let title = details["title"] as! String
        return title
    }
    
}

//Handle and Pass File Path
extension FullFilePath {
    
    func passFilePath()
    {
        //Pass Index and File Path
        let notif = ["index":2,"filePath":filePath,"selected":selectedItems] as [String : Any]
        NotificationCenter.default.post(name: .addTaskDetails, object: nil,userInfo: notif)
    }
    
    
}
