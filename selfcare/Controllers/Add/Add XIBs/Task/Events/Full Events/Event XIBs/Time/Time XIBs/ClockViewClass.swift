//
//  ClockViewClass.swift
//  selfcare
//
//  Created by Michael Brewington on 1/19/21.
//

import Foundation
import UIKit

class ClockViewClass: UIView {
    
    @IBOutlet var ViewHandle: UIView!
    @IBOutlet weak var innerCircle: UIView!
    @IBOutlet weak var outerCircle: UIView!
    @IBOutlet weak var littleHand: UIView!
    @IBOutlet weak var bigHand: UIView!
    @IBOutlet weak var am: UIButton!
    @IBOutlet weak var pm: UIButton!
    @IBOutlet weak var amImage: UIImageView!
    @IBOutlet weak var pmImage: UIImageView!
    @IBOutlet weak var clockface: UIImageView!
    
    @IBOutlet weak var twelve: UIButton!
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var nine: UIButton!
    @IBOutlet weak var ten: UIButton!
    @IBOutlet weak var eleven: UIButton!
    
    @IBOutlet weak var bigHandHolder: UIView!
    @IBOutlet weak var littleHandHolder: UIView!
    
    @IBAction func timeButtonDown(_ sender: UIButton) {
        //print(sender.title(for: .normal) ?? "timeButtonDown")
        let hourString = sender.title(for: .normal) ?? "12"
        hour = Int(hourString) ?? 12
        updateTimeButtonStyle()
        updateLittleHand()
        passClock()
    }
    
    @IBOutlet weak var bgButton: UIButton!
    
    @IBAction func bgButtonAction(_ sender: Any) {
        state = !state
        updateState()
    }
    
    @IBAction func amDown(_ sender: Any) {
        timePeriod = true
        updateTimePeriod()
    }
    
    @IBAction func pmDown(_ sender: Any) {
        timePeriod = false
        updateTimePeriod()
    }
    
    var timePeriod = true
    var state = false
    var hour = 12
    var minute = 0
    var period = "AM"
    var hourArray = [Int]()
    var buttonArray = [UIButton]()
    var panGesture = UIPanGestureRecognizer()
    let centerPoint = CGPoint(x: 207, y: 207)
    var count = 0
    var send = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        ViewHandle = loadViewFromNib(name: "ClockView")
        // use bounds not frame or it'll be offset
        ViewHandle!.frame = bounds
        // Make the view stretch with containing view
        ViewHandle!.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(ViewHandle!)
        handleInit()
    }
     
    func handleInit() {
        innerCircle.layer.cornerRadius = innerCircle.frame.width/2
        outerCircle.layer.cornerRadius = outerCircle.frame.width/2
        littleHand.layer.cornerRadius = 2
        bigHand.layer.cornerRadius = 2
        updateTimePeriod()
        hourArray = Array(1...12)
        buttonArray = [one,two,three,four,five,six,seven,eight,nine,ten,eleven,twelve]
        clockface.image = clockface.image?.withRenderingMode(.alwaysTemplate)
        clockface.tintColor = UIColor.gainsboro
        updateTimeButtonStyle()
        addPanGesture()
        updateState()
    }
    
    func updateTimePeriod(){
        amImage.image = amImage.image?.withRenderingMode(.alwaysTemplate)
        pmImage.image = pmImage.image?.withRenderingMode(.alwaysTemplate)
        switch timePeriod {
        case true:
            amImage.tintColor = UIColor.darkGray
            pmImage.tintColor = UIColor.gainsboro
            period = "AM"
        case false:
            amImage.tintColor = UIColor.gainsboro
            pmImage.tintColor = UIColor.darkGray
            period = "PM"
        }
        passClock()
    }
    
    func updateState(){
        switch state {
        case true:
            ViewHandle.alpha = 1
            ViewHandle.sendSubviewToBack(bgButton)
            for view in [amImage,pmImage]{
                view?.isHidden = false
            }
            panGesture.isEnabled = true
        case false:
            ViewHandle.alpha = 0.2
            ViewHandle.bringSubviewToFront(bgButton)
            for view in [amImage,pmImage]{
                view?.isHidden = true
            }
            panGesture.isEnabled = false
        }
        passClock()
        
    }
    
    func updateTimeButtonStyle(){
        for i in 0...11{
            if i == (hour-1) {
                buttonArray[i].alpha = 1
            } else {
                buttonArray[i].alpha = 0.2
            }
        }
        //passClock()
        //Change Hand
    }
    /*
    func updateTimeButtonStyle2(input: Int){
        if (input-1) != (hour-1){
            buttonArray[(input-1)].alpha = 1
            buttonArray[(hour-1)].alpha = 0.2
            hour = input
        }
    } */
    
}

extension ClockViewClass{
    
     func addPanGesture() {
          panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
          self.ViewHandle.addGestureRecognizer(panGesture)
     }
     
     @objc func handlePan(_ sender: UIPanGestureRecognizer) {
          switch sender.state {
          case .began:
            send = false
          case .changed:
            let point = sender.location(in: ViewHandle)
            let angle = getClockDegrees(point: point, origin: centerPoint)
            let distance = distanceToPoint(point: point, origin: centerPoint)
            let inside = insideTheCircle(distance: distance, radius: 150.0)
            if inside == true {
                let radians = atan2(bigHandHolder.transform.b, bigHandHolder.transform.a)
                let degrees = radians * 180 / .pi
                let difference = angle - degrees
                bigHandHolder.transform = bigHandHolder.transform.rotated(by: difference / 180.0 * .pi)
                getMinute(angle: angle)
            } else {
                let radians = atan2(littleHandHolder.transform.b, littleHandHolder.transform.a)
                let degrees = radians * 180 / .pi
                let difference = angle - degrees
                littleHandHolder.transform = littleHandHolder.transform.rotated(by: difference / 180.0 * .pi)
                getHour(angle: angle)
            }
            passClock()
          case .ended:
            //print("ended")
            updateLittleHand()
            updateBigHand()
            send = true
            passClock()
            //Update Degree Accuracy
            //let point = sender.location(in: ViewHandle)
          default: break
            //print("handlePan")
          }
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
    
    func getHour(angle: CGFloat){
        hour = Int((angle * 12.0) / 360.0)
        if hour < 1{
            hour = 12
        }
        updateTimeButtonStyle()
    }
    
    func getMinute(angle: CGFloat){
        minute = Int((angle * 60.0) / 360.0)
        if minute > 59{
            minute = 0
        }
    }
    
    func updateMinuteString()->String{
        if minute < 10 {
            return "0\(minute)"
        } else {
            return "\(minute)"
        }
    }
     
    func updateLabel() -> String {
        let title = "\(hour):\(updateMinuteString()) \(period)"
        return title
    }
    
    func returnCompare() -> Int{
        if timePeriod == true {
            if hour == 12 {
                let compare = ((0-1) * 60) + minute
                return compare
            } else {
                let compare = ((hour-1) * 60) + minute
                return compare
            }
        } else {
            if hour == 12 {
                let compare = (((hour-1)) * 60) + minute
                return compare
            } else {
                let compare = (((hour-1) + 12) * 60) + minute
                return compare
            }
        }
    }
    
    func passClock()
    {
        let military = convertToMilitaryTime(hour: hour, minute: minute, period: timePeriod)
        //combined time for comparison
        let passInfo = ["title":updateLabel(),"state":state,"count":count,"hour":hour,"minute":minute,"compare":returnCompare(),"military":military,"send":send,"input":0] as [String : Any]
        NotificationCenter.default.post(name: .xibToTime, object: nil,userInfo: passInfo)
    }
    
    func resetClock(){
        hour = 12
        minute = 0
        updateLittleHand()
        updateBigHand()
        updateTimeButtonStyle()
    }
    
    func convertToMilitaryTime(hour:Int,minute:Int,period:Bool)->String{
        var holdHour = 0
        if state == true {
            if period == true {
                if hour == 12 {
                    
                } else {
                    holdHour = hour
                }
            } else {
                if hour == 12 {
                    holdHour = hour
                } else {
                    holdHour = hour + 12
                }
            }
            let military = "\(holdHour):\(updateMinuteString())"
            return military
        } else {
            return "24:00"
        }
    }
    
}
