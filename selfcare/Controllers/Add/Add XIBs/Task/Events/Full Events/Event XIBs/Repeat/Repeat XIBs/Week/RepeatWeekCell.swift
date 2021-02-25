//
//  RepeatWeekCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/24/21.
//

import Foundation
import UIKit

class RepeatWeekCell: UITableViewCell,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var WeekCollectionView: UICollectionView!
    
    var selectedArray = [Bool]()
    var selection = Int()
    var eventDates: [Date] = [Date]() {
        didSet {
            //
            updateSelection()
            WeekCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        updateSelection()
        //selection = 0
        selectedArray = Array(repeating: false, count: 7)
        selectedArray[selection] = true
    }
    
    func updateSelection(){
        let calendar = Calendar.current
        var date = Date()
        if eventDates.count > 0 {
            date = eventDates[0]
        }
        let components = calendar.dateComponents([.year, .month, .day, .weekday], from: date)
        var weekDay = components.weekday ?? 0
        if weekDay >= 0 {
            weekDay = weekDay - 1
        }
        //print(weekDay)
        if selection != weekDay {
            selection = weekDay
            selectedArray = Array(repeating: false, count: 7)
            selectedArray[selection] = true
        }
    }
    
    func setupCollectionView(){
        self.WeekCollectionView.register(UINib(nibName: "WeekCell", bundle:nil), forCellWithReuseIdentifier: "weekCell")
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weekCell", for: indexPath as IndexPath) as! WeekClass
        cell.updateLabel(index: indexPath.row, selected: selectedArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedArray[indexPath.row] = !selectedArray[indexPath.row]
        checkFalse()
        passXibToRepeat()
        WeekCollectionView.reloadData()
    }
    
    func checkFalse(){
        if selectedArray.contains(true) {
            
        } else {
            selectedArray[selection] = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 7)
        return CGSize(width: width, height: 75)
    }
    
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    

}
//1
//
extension RepeatWeekCell {
    
    func passXibToRepeat()
    {
        let passState = ["index":1,"week":selectedArray] as [String : Any]
        NotificationCenter.default.post(name: .xibToRepeat, object: nil,userInfo: passState)
    }
    
}
