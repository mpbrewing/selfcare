//
//  AddPriorityCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/12/21.
//

import Foundation
import UIKit

class AddPriorityCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var measure: UIView!
    @IBOutlet weak var overlay: UIView!
    @IBOutlet weak var handle: UIView!
    
    var priority = Int()
    var gesture = UIPanGestureRecognizer()
    
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
         //let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        gesture.cancelsTouchesInView = false
        handle.addGestureRecognizer(gesture)
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
            passPriority()
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
            priority = 0
            priorityLabel.text = "Priority"
            priorityLabel.textColor = UIColor.lightGray
            updateIcon(image: #imageLiteral(resourceName: "priority_icon"))
        case 101...203:
            //overlay.layer.backgroundColor = UIColor.lightGray.cgColor
            //handle.layer.backgroundColor = UIColor.lightGray.cgColor
            overlay.layer.backgroundColor = UIColor.systemGreen.cgColor
            handle.layer.backgroundColor = UIColor.systemGreen.cgColor
            priority = 1
            priorityLabel.text = "Low Priority"
            priorityLabel.textColor = UIColor.black
            updateIcon(image: #imageLiteral(resourceName: "priority_icon"))
        case 203...305:
            //overlay.layer.backgroundColor = UIColor.systemGray.cgColor
            //handle.layer.backgroundColor = UIColor.systemGray.cgColor
            overlay.layer.backgroundColor = UIColor.systemYellow.cgColor
            handle.layer.backgroundColor = UIColor.systemYellow.cgColor
            priority = 2
            priorityLabel.text = "Medium Priority"
            priorityLabel.textColor = UIColor.black
            updateIcon(image: #imageLiteral(resourceName: "mediumPriority"))
        case 305...414:
            //overlay.layer.backgroundColor = UIColor.darkGray.cgColor
            //handle.layer.backgroundColor = UIColor.darkGray.cgColor
            overlay.layer.backgroundColor = UIColor.systemRed.cgColor
            handle.layer.backgroundColor = UIColor.systemRed.cgColor
            priority = 3
            priorityLabel.text = "High Priority"
            priorityLabel.textColor = UIColor.black
            updateIcon(image: #imageLiteral(resourceName: "highPriority"))
        default:
            break
        }
    }
    
    func updateIcon(image: UIImage){
        icon.image = image
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor.gainsboro
    }
    
    func returnFinalHandleLocation(point: CGPoint){
        //50, 156, 263, 370
        //103, 209, 316
        //
        //50, 152, 254, 356
        //101, 203, 305
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

//Handle and Pass Priority
extension AddPriorityCell {
    
    func updateIcon(){
        if priority > 0 {
            //let colors = [UIColor.gainsboro,UIColor.systemGreen,UIColor.systemYellow,UIColor.systemRed]
            //icon.tintColor = colors[status]
            //icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
            //icon.tintColor = UIColor.silver
            //icon.tintColor = UIColor.systemGreen
            //icon.tintColor = colors[priority]
        } else {
            icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
            icon.tintColor = UIColor.gainsboro
        }
    }
    
    func passPriority()
    {
        updateIcon()
        //Pass Index and Status
        let notif = ["index":5,"priority":priority] as [String : Any]
        NotificationCenter.default.post(name: .addTaskDetails, object: nil,userInfo: notif)
    }
    
}
