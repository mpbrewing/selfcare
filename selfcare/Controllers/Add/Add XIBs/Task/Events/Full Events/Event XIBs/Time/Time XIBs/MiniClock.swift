//
//  MiniClock.swift
//  selfcare
//
//  Created by Michael Brewington on 1/20/21.
//

import Foundation
import UIKit

class MiniClock: UIView {
    
    @IBOutlet var ViewHandle: UIView!
    @IBOutlet weak var littleHand: UIView!
    @IBOutlet weak var bigHand: UIView!
    @IBOutlet weak var littleHandHolder: UIView!
    @IBOutlet weak var bigHandHolder: UIView!
    @IBOutlet weak var circle: UIView!
    @IBOutlet weak var clockface: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonAction(_ sender: Any) {
        //send notification
         let passInfo = ["count":count] as [String : Any]
         NotificationCenter.default.post(name: .mini, object: nil,userInfo: passInfo)
    }
    
    let centerPoint = CGPoint(x: 85, y: 85)
    var hour = 12
    var minute = 0
    var count = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        ViewHandle = loadViewFromNib(name: "MiniClockView")
        // use bounds not frame or it'll be offset
        ViewHandle!.frame = bounds
        // Make the view stretch with containing view
        ViewHandle!.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(ViewHandle!)
        handleInit()
    }
     
    func handleInit() {
        circle.layer.cornerRadius = circle.frame.width/2
        littleHand.layer.cornerRadius = 2
        bigHand.layer.cornerRadius = 2
        clockface.image = clockface.image?.withRenderingMode(.alwaysTemplate)
        clockface.tintColor = UIColor.darkGray
        littleHand.backgroundColor = UIColor.gray
        bigHand.backgroundColor = UIColor.gray
        circle.backgroundColor = UIColor.gray
    }
    
    func updateLittleHand(){
        let angle = CGFloat((hour * 360) / 12)
        let radians = atan2(littleHandHolder.transform.b, littleHandHolder.transform.a)
        let degrees = radians * 180 / .pi
        let difference = angle - degrees
        littleHandHolder.transform = littleHandHolder.transform.rotated(by: difference / 180.0 * .pi)
    }
    
    func updateBigHand(){
        let angle = CGFloat((minute * 360) / 60)
        let radians = atan2(bigHandHolder.transform.b, bigHandHolder.transform.a)
        let degrees = radians * 180 / .pi
        let difference = angle - degrees
        bigHandHolder.transform = bigHandHolder.transform.rotated(by: difference / 180.0 * .pi)
    }
    
    func updateMiniClock(hour: Int,minute: Int){
        self.hour = hour
        self.minute = minute
        updateLittleHand()
        updateBigHand()
    }
    
}
