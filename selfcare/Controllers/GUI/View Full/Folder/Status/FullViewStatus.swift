//
//  FullViewStatus.swift
//  selfcare
//
//  Created by Michael Brewington on 3/9/21.
//

import Foundation
import UIKit

class FullViewStatus: UITableViewCell,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var label: UILabel!
    @IBAction func buttonAction(_ sender: Any) {
        updateLabel()
    }
    
    var items = [Item]()
    var statusArray = [Int]()
    var remodel = [Int]()
    var remove = [Int]()
    var reel = [Int]()
    var modelLength = [CGFloat]()
    
    var holdBg = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        holdBg.isHidden = true
        contentView.addSubview(holdBg)
        setupCollectionView()
        //statusArray = Array(repeating: 0, count: 4)
    }
    
    //
    func getStatus(item: Item)->Int{
        let details = item.details
        let status = details["status"] as? Int ?? 0
        return status
    }
    
    func updateArray(){
        statusArray = Array(repeating: 0, count: 4)
        if items.count > 0 {
            for i in 0...items.count-1{
                let status = getStatus(item: items[i])
                let hold = statusArray[status]
                statusArray[status] = hold + 1
            }
        }
        updateRemodel()
        updateModelLength()
        updateLabel()
        collectionView.reloadData()
    }
    
    func updateRemodel(){
        remove = [Int]()
        reel = [Int]()
        remodel = [Int]()
        for i in 0...3{
            if statusArray[i] == 0 {
                remove.append(i)
                //print("remove: \(i)")
            } else {
                reel.append(i)
                //print("reel: \(i)")
            }
        }
        if remove.count > 0 {
            for i in 0...statusArray.count-1{
                if reel.contains(i) {
                    remodel.append(statusArray[i])
                }
            }
        } else {
            remodel = statusArray
        }
    }
    
}

extension FullViewStatus {
    
    func setupCollectionView(){
        self.collectionView.register(UINib(nibName: "FVMiniStatus", bundle:nil), forCellWithReuseIdentifier: "fVMiniStatus")
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return remodel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fVMiniStatus", for: indexPath as IndexPath) as! FVMiniStatusCell
        updateCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateLabelTap(input: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        updateLabel()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: width, height: 100)
        //update to be based on percentage
        //let width = (collectionView.frame.width / CGFloat(remodel.count))
        let width = modelLength[indexPath.row]
        //print("width: \(width)")
        return CGSize(width: width, height: 22)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
}

extension FullViewStatus {
    
    func updateLabel(){
        let total = getItemTotal()
        if total > 0 {
            let holdItems = (total - statusArray[0]) - statusArray[3]
            label.text = "\(holdItems) of \(total) \(returnIfOne(value: total)) remaining"
            manageAnimation(status: 0, bool: false)
        } else {
            label.text = "No tasks"
        }
        
    }
    
    func updateLabelTap(input: Int){
        let stringArray = ["wihout status","to-do","in progress","completed"]
        let value = reel[input]
        let total = getItemTotal()
        if total > 0 {
            let holdItems = statusArray[value]
            label.text = "\(holdItems) \(returnIfOne(value: holdItems)) \(stringArray[value])"
            manageAnimation(status: value, bool: true)
        } else {
            label.text = "No tasks"
        }
    }
    
    func returnIfOne(value:Int)->String{
        if value == 1 {
            return "task"
        } else {
            return "tasks"
        }
    }
    
    //Get Percentage
    func getItemTotal()->Int{
        var counter = Int()
        if remodel.count > 0 {
            for i in 0...remodel.count - 1 {
                counter = counter + remodel[i]
            }
            return counter
        } else {
            return 0
        }
    }
    
    func updateModelLength(){
        modelLength = [CGFloat]()
        if remodel.count > 0 {
            let total = getItemTotal()
            for i in 0...remodel.count-1{
                let percentage: CGFloat = (CGFloat(remodel[i]) / CGFloat(total))
                //print("percentage: \(percentage)")
                //print("total: \(total)")
                //print("remodel: \(remodel[i])")
                let hold = CGFloat(percentage) * 396
                //print("hold: \(hold)")
                modelLength.append(hold)
            }
        }
    }
    
    //Switch Cell
    
    func updateCell(cell: FVMiniStatusCell,indexPath: IndexPath){
        if reel.count > 0 {
            let status = reel[indexPath.row]
            let width = modelLength[indexPath.row]
            cell.updateFrame(width: width)
            cell.updateColor(status: status)
        }
    }
    
    func returnColor(status: Int)->UIColor{
        switch status {
        case 0:
            holdBg.alpha = 0.4
            return UIColor.gainsboro
        case 1:
            holdBg.alpha = 1
            return UIColor.systemRed
        case 2:
            holdBg.alpha = 1
            return UIColor.systemYellow
        case 3:
            holdBg.alpha = 1
            return UIColor.systemGreen
        default:
            return UIColor.gainsboro
        }
    }
    
    func updateHold(status: Int,bool:Bool){
        holdBg.frame = CGRect(x: 10, y: 8, width: 20, height: 20)
        holdBg.backgroundColor = returnColor(status: status)
        holdBg.layer.cornerRadius = 4
        if bool == false {
            holdBg.isHidden = true
            label.frame = CGRect(x: 10, y: 6, width: 384, height: 30)
        } else {
            holdBg.isHidden = false
            label.frame = CGRect(x: 40, y: 6, width: 384, height: 30)
        }
    }
    
    func manageAnimation(status: Int,bool:Bool) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
            self.updateHold(status: status, bool: bool)
        }, completion: { finished in
          //print("animation complete!")
        })
    }

    
}
