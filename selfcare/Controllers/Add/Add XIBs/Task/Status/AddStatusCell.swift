//
//  AddStatusCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/12/21.
//

import Foundation
import UIKit

class AddStatusCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var measure: UIView!
    @IBOutlet weak var overlay: UIView!
    @IBOutlet weak var handle: UIView!
    
    var status = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupXIB()
        setupSlider()
        addPanGesture()
    }
    
    func setupXIB() {
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor.gainsboro
    }
    
    func setupSlider(){
        measure.layer.backgroundColor = UIColor.gainsboro.cgColor
        measure.layer.cornerRadius = 2
        overlay.layer.backgroundColor = UIColor.gainsboro.cgColor
        overlay.layer.cornerRadius = 2
        handle.layer.backgroundColor = UIColor.gainsboro.cgColor
        handle.layer.cornerRadius = 10
    }
    
    func addPanGesture() {
         let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
         self.handle.addGestureRecognizer(panGesture)
    }
     
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {

         switch sender.state {
         case .changed:
            let point = sender.location(in: contentView)
            modifyHandleLocation(point: point)
            //print(point.x)
         case .ended:
            //print("ended")
            let point = sender.location(in: contentView)
            returnFinalHandleLocation(point: point)
            passStatus()
         default: break
             //print("handlePan")
         }
    }
    
    func modifyHandleLocation(point: CGPoint){
        if point.x >= 40 && point.x <= 356 {
            handle.frame = CGRect(x: point.x, y: 57, width: 28, height: 28)
            modifyHandleStyle(point: point)
        }
    }
    
    func modifyHandleStyle(point: CGPoint){
        let width = point.x - 50
        overlay.frame = CGRect(x: 50, y: 70, width: width, height: 3)
        switch point.x {
        case 0...101:
            overlay.layer.backgroundColor = UIColor.gainsboro.cgColor
            handle.layer.backgroundColor = UIColor.gainsboro.cgColor
            status = 0
            statusLabel.text = "Status"
            statusLabel.textColor = UIColor.lightGray
        case 101...203:
            overlay.layer.backgroundColor = UIColor.systemRed.cgColor
            handle.layer.backgroundColor = UIColor.systemRed.cgColor
            status = 1
            statusLabel.text = "To-Do"
            statusLabel.textColor = UIColor.black
        case 203...305:
            overlay.layer.backgroundColor = UIColor.systemYellow.cgColor
            handle.layer.backgroundColor = UIColor.systemYellow.cgColor
            status = 2
            statusLabel.text = "In Progress"
            statusLabel.textColor = UIColor.black
        case 305...414:
            overlay.layer.backgroundColor = UIColor.systemGreen.cgColor
            handle.layer.backgroundColor = UIColor.systemGreen.cgColor
            status = 3
            statusLabel.text = "Completed"
            statusLabel.textColor = UIColor.black
        default:
            break
        }
    }
    
    func returnFinalHandleLocation(point: CGPoint){
        //50, 156, 263, 370
        //103, 209, 316
        switch point.x {
        case 0...101:
            handle.frame = CGRect(x: 50, y: 57, width: 28, height: 28)
        case 101...203:
            handle.frame = CGRect(x: 152, y: 57, width: 28, height: 28)
        case 203...305:
            handle.frame = CGRect(x: 254, y: 57, width: 28, height: 28)
        case 305...414:
            handle.frame = CGRect(x: 356, y: 57, width: 28, height: 28)
        default:
            break
        }
        modifyHandleStyle(point: handle.center)
    }

}

//Handle and Pass Status
extension AddStatusCell {
    
    func passStatus()
    {
        //Pass Index and Status
        let notif = ["index":4,"status":status] as [String : Any]
        NotificationCenter.default.post(name: .addTaskDetails, object: nil,userInfo: notif)
    }
    
}
