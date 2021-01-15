//
//  EventDateCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/15/21.
//

import Foundation
import UIKit
class EventDateCell: UICollectionViewCell,UIPickerViewDelegate, UIPickerViewDataSource,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var textBox: UIView!
    @IBOutlet weak var tabLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var datePicker: UIPickerView!
    @IBOutlet weak var dateCollection: UICollectionView!
    
    var monthData: [String] = [String]()
    var yearData: [Int] = [Int]()
    let dateReuseID = "dateNib"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
        setupPickerData()
        setupCollectionView()
        setupSwipe()
    }
    
    func setupStyle(){
        textBox.layer.cornerRadius = 8
        cancelButton.layer.cornerRadius = 8
        textBox.layer.backgroundColor = UIColor.lightGains.cgColor
        cancelButton.backgroundColor = UIColor.gainsboro
        let cancelButtonImage = #imageLiteral(resourceName: "cancel")
        cancelButton.setImage(cancelButtonImage.withTintColor(.darkGray, renderingMode: .alwaysOriginal), for: .normal)
        toggleStyle(state: false)
        tabLabel.text = "Fri, Jan 15"
    }
    
    func toggleStyle(state: Bool){
        switch state {
        case true:
            tabLabel.frame = CGRect(x: 20, y: 6, width: 328, height: 46)
            cancelButton.isHidden = false
            textBox.isHidden = false
            tabLabel.textColor = UIColor.darkGray
        case false:
            tabLabel.frame = CGRect(x: 12, y: 6, width: 390, height: 46)
            cancelButton.isHidden = true
            textBox.isHidden = true
            tabLabel.textColor = UIColor.gainsboro
        }
    }
     func setupSwipe(){
         let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(upSwipeAction))
         let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(downSwipeAction))
         upSwipe.direction = .up
         downSwipe.direction = .down
         contentView.addGestureRecognizer(upSwipe)
         contentView.addGestureRecognizer(downSwipe)
     }
     
     @objc func upSwipeAction() {
        let row = datePicker.selectedRow(inComponent: 0) + 1
        if row < monthData.count {
            datePicker.selectRow(row, inComponent: 0, animated: true)
        } //change year
     }
      
     @objc func downSwipeAction() {
        let row = datePicker.selectedRow(inComponent: 0) - 1
        if row > -1 {
            datePicker.selectRow(row, inComponent: 0, animated: true)
        } //change year
     }
     
    //save month and year
    //swipe to change year at 0,11
    //pull correct calendar dates
    //change calendar with picker selections
    //change style of previous dates, current dates, and future dates
    //make previous dates non-selectable
    //make dates selectable
    //change label text with selected dates
    
    
}

extension EventDateCell {
    
    func setupPickerData(){
        datePicker.delegate = self
        datePicker.dataSource = self
        monthData = ["January","February","March","April","May","June","July","August","September","October","November","December"]
        yearData = Array(2021...2121)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return monthData.count
        case 1:
            return yearData.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel { label = v }
        //label.font = UIFont (name: "Nexa-Bold", size: 30)
        label.textColor = .black
        label.textAlignment = .center
        if component == 0 {
            label.text =  monthData[row]
            label.font = UIFont (name: "Nexa-Bold", size: 30)
        } else {
            label.text = "\(yearData[row])"
            label.font = UIFont (name: "Nexa-Bold", size: 28)
        }
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 56.0
    }
    /*
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            <#code#>
        default:
            <#code#>
        }
    } */
    
}

extension EventDateCell {
    
    func setupCollectionView(){
        self.dateCollection.register(UINib(nibName: "MiniDate", bundle:nil), forCellWithReuseIdentifier: dateReuseID)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 35
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dateReuseID, for: indexPath as IndexPath) as! MiniDateCell
        cell.date.text = "\(indexPath.row)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 7)
        return CGSize(width: width, height: width)
   }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
}
