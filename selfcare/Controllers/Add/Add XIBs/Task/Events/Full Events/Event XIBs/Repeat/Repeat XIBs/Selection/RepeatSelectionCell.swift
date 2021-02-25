//
//  RepeatSelectionCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/23/21.
//

import Foundation
import UIKit

class RepeatSelectionCell: UITableViewCell,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var selectionTableView: UITableView!
    var selectedArray = [Bool]()
    var excludedCount = Int()
    var selection = Int()
    var occur = Int()
    var date = Date()
    var eventDates: [Date] = [Date]() {
        didSet {
            //
        }
    }
    var selectedDates: [CalendarDate] = [CalendarDate]() {
        didSet {
            //
            //print(selectedDates.count)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
        selection = 0
        excludedCount = 0
        selectedArray = Array(repeating: false, count: 3)
        selectedArray[selection] = true
        NotificationCenter.default.addObserver(self, selector: #selector(setSelection(notification:)), name: .endsToSelection, object: nil)
    }
    
    func excludedBool() -> Bool{
        if excludedCount > 0 {
            return true
        } else {
            return false
        }
    }
    
}

//Move selection into sections
//Ends on a date: Open Calendar Nib underneath
//After number of occurrences: Open keyboard and change nib to textfield with label
//Excluded dates: Open calendar nib underneath

extension RepeatSelectionCell {
    
    func setupTableView()
    {
        //Selection
        selectionTableView.register(UINib(nibName: "SelectionRow", bundle: nil), forCellReuseIdentifier: "selectionRow")
        //
        selectionTableView.delegate = self
        selectionTableView.dataSource = self
        //
        selectionTableView.tableFooterView = UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       //Change based on selected
       return 4
   }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //Switch: Week, Month, Selection
     let cell = tableView.dequeueReusableCell(withIdentifier: "selectionRow", for: indexPath) as! SelectionRowCell
     if indexPath.row > 2 {
        cell.updateLabel(index: indexPath.row, selected: excludedBool())
     } else {
        cell.updateLabel(index: indexPath.row, selected: selectedArray[indexPath.row])
     }
     return cell
   }
    
    func switchSeque(index: IndexPath){
        switch index.row {
        case 1:
            //Set up Ends on a date
            segueToEnds(index: index.row)
        case 2:
            //Set up after # of occurrences
            segueToEnds(index: index.row)
        case 3:
            //Set up Excluded dates
            segueToExcluded()
        default:
            break
        }
    }

    func segueToEnds(index: Int){
        let passView = RepeatEnds()
        passView.state = index
        //Date
        passView.eventDates = eventDates
        passView.selectedDates = selectedDates
        passView.modalPresentationStyle = .fullScreen
        let vc = findViewController()
        vc?.navigationController?.pushViewController(passView, animated: true)
    }
    
    func segueToExcluded(){
        let passView = ExcludedDates()
        passView.modalPresentationStyle = .fullScreen
        //Date, Repeat
        passView.eventDates = eventDates
        let vc = findViewController()
        vc?.navigationController?.pushViewController(passView, animated: true)
    }
    
    //Select and open nib underneath
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 2 {
            //Segue
        } else {
            if selectedArray[indexPath.row] == true {
                
            } else {
                selectedArray = Array(repeating: false, count: 3)
                selectedArray[indexPath.row] = !selectedArray[indexPath.row]
                selection = indexPath.row
                selectionTableView.reloadData()
            }
        }
        if indexPath.row != 0 {
            switchSeque(index: indexPath)
        } else {
            passXibToRepeat()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
//0
//
extension RepeatSelectionCell {
    
    //Receive
    @objc func setSelection(notification: NSNotification) {
        if let index = notification.userInfo?["index"] as? Int {
            if index == 1 {
                //default date
                date = notification.userInfo?["date"] as? Date ?? Date()
            } else if index == 2 {
                occur = notification.userInfo?["occur"] as? Int ?? 1
            } else {
                //Excluded
            }
        }
        passXibToRepeat()
    }
    
    func passXibToRepeat()
    {
        let ends = ["ends":selection,"date":date,"occur":occur] as [String : Any]
        //excluded
        let passState = ["index":0,"ends":ends] as [String : Any]
        NotificationCenter.default.post(name: .xibToRepeat, object: nil,userInfo: passState)
    }
    
}
