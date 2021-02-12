//
//  EventNotifyCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/15/21.
//

import Foundation
import UIKit

class EventNotifyCell: UICollectionViewCell,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var notifyTableView: UITableView!
    
    var timeArray = [String]()
    var addLabel = String()
    var reset = false
    //var eventNotify = [[Int]]()
    var eventNotify = [[String:Any]]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(xibNotif(notification:)), name: .xibToNotify, object: nil)
        addLabel = "Does not notify"
    }
    
    @objc func xibNotif(notification: NSNotification) {
        if let state = notification.userInfo?["state"] as? Int {
            if state == 0 {
                labelNotif(notif: notification)
            } else if state == 1 {
                pickerNotif(notif: notification)
            } else {
                resetNotif(notif: notification)
            }
        }
    }
    
    func labelNotif(notif: NSNotification){
        let row = (notif.userInfo?["row"] as? Int)!
        timeArray.remove(at: row)
        //
        updateEventNotify(add: false, value: [String:Any](), row: row)
        //
        reset = true
        addLabel = "Does not notify"
        notifyTableView.reloadData()
    }
    
    func pickerNotif(notif: NSNotification){
        let add = (notif.userInfo?["add"] as? Bool)!
        if add == true {
            let label = (notif.userInfo?["label"] as? String)!
            timeArray.append(label)
            reset = true
            addLabel = "Does not notify"
            //
            //let value = (notif.userInfo?["eventNotify"] as? [Int])!
            let value = (notif.userInfo?["eventNotify"] as? [String:Any])!
            updateEventNotify(add: true, value: value, row: Int())
            //
        } else {
            addLabel = (notif.userInfo?["label"] as? String)!
        }
        notifyTableView.reloadData()
    }
    
    func resetNotif(notif: NSNotification){
        addLabel = (notif.userInfo?["label"] as? String)!
        reset = false
    }
    
}

extension EventNotifyCell {

    func setupTableView()
    {
        //Label
        notifyTableView.register(UINib(nibName: "EventLabelCell", bundle: nil), forCellReuseIdentifier: "eventLabel")
        //Picker
        notifyTableView.register(UINib(nibName: "NotifyPickerCell", bundle: nil), forCellReuseIdentifier: "notifyPicker")
        //
        notifyTableView.delegate = self
        notifyTableView.dataSource = self
        //
        notifyTableView.tableFooterView = UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch timeArray.count {
        case 0:
            return 2
        case 1...2:
            return (timeArray.count+2)
        case 3:
            return 3
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switchCellFor(tableView: tableView, cellForRowAt: indexPath)
    }
    
    func switchCellFor(tableView: UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell{
        switch indexPath.row {
        case (timeArray.count+1):
            let cell = tableView.dequeueReusableCell(withIdentifier: "notifyPicker", for: indexPath) as! NotifyPicker
            cell.resetPicker(bool: reset)
            return cell
        case timeArray.count:
            let cell = tableView.dequeueReusableCell(withIdentifier: "eventLabel", for: indexPath) as! EventLabel
            if timeArray.count != 3 {
                cell.cellInput(text: addLabel, bool: false)
            } else {
                cell.row = indexPath.row
                cell.cellInput(text: timeArray[indexPath.row], bool: true)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "eventLabel", for: indexPath) as! EventLabel
            cell.row = indexPath.row
            cell.cellInput(text: timeArray[indexPath.row], bool: true)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switchHeightFor(tableView: tableView, cellForRowAt: indexPath)
    }
    
    func switchHeightFor(tableView: UITableView, cellForRowAt indexPath: IndexPath)->CGFloat{
        switch indexPath.row {
        case (timeArray.count+1):
            return 208
        default:
            return 57
        }
    }
    
}

//Handle and Pass Event Notify
extension EventNotifyCell {
    
    func updateEventNotify(add:Bool,value: [String:Any],row:Int){
        if add == true {
            eventNotify.append(value)
        } else {
            eventNotify.remove(at: row)
        }
        passEventNotify()
    }
    
    func passEventNotify(){
        let notif = ["index":3,"notify":eventNotify] as [String : Any]
        NotificationCenter.default.post(name: .addEventXib, object: nil,userInfo: notif)
    }
    
}
