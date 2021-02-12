//
//  repeatMonthCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/24/21.
//

import Foundation
import UIKit

class repeatMonthCell: UITableViewCell,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var monthTableView: UITableView!
    
    var state = 2
    var selectedArray = [Bool]()
    var selection = 0
    var eventDates = [Date]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
        selectedArray = Array(repeating: false, count: 4)
        selectedArray[selection] = true
    }
    
    func setupTableView()
    {
        //Month Cell
        monthTableView.register(UINib(nibName: "MonthCell", bundle: nil), forCellReuseIdentifier: "monthCell")
        //
        monthTableView.delegate = self
        monthTableView.dataSource = self
        //
        monthTableView.tableFooterView = UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "monthCell", for: indexPath) as! MonthClass
      cell.updateLabel(index: indexPath.row, selected: selectedArray[indexPath.row])
      return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedArray[indexPath.row] == true {
            
        } else {
            selectedArray = Array(repeating: false, count: 4)
            selectedArray[indexPath.row] = !selectedArray[indexPath.row]
            selection = indexPath.row
            passXibToRepeat()
            monthTableView.reloadData()
        }
        
    }
    
    
}
//2
//
extension repeatMonthCell {
    
    func passXibToRepeat()
    {
        let passState = ["index":2,"month":selection] as [String : Any]
        NotificationCenter.default.post(name: .xibToRepeat, object: nil,userInfo: passState)
    }
    
}
