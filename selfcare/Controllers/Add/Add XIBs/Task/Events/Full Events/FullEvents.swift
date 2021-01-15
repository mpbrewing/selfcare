//
//  FullEvents.swift
//  selfcare
//
//  Created by Michael Brewington on 1/14/21.
//

import Foundation
import UIKit

class FullEvents: UIViewController {
    
    @IBOutlet weak var cursor: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "EventsView")
        setupNavigationBar()
        setupStyle()
        setupSwipe()
    }
    
    var state = 0
    
    func setupNavigationBar() {
        navigationItem.title = "Events"
        navigationController?.navigationBar.standardAppearance.backgroundColor = .clear
        navigationController?.navigationBar.standardAppearance.backgroundEffect = .none
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func setupStyle(){
        view.layer.cornerRadius = 40
        view.layer.borderWidth = 8
        view.layer.borderColor = UIColor.appleBlue.cgColor
        cursor.layer.cornerRadius = 3
        cursor.layer.backgroundColor = UIColor.appleBlue.cgColor
    }

    func setupSwipe(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeAction))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeAction))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
    }
    
     @objc func leftSwipeAction() {
         state = switchValue(input: state + 1)
         animateSwitch()
     }
      
     @objc func rightSwipeAction() {
         state = switchValue(input: state - 1)
         animateSwitch()
     }
     
     func animateSwitch()
     {
         UIView.animate(withDuration: 0.2, animations: {
            self.switchStyle()
         })
     }
    
    func switchValue(input: Int) -> Int {
        if input < 0 {
            return 0
        } else if input > 4 {
            return 4
        } else {
            return input
        }
    }
    
    func switchStyle(){
        let colorArray = [UIColor.appleBlue,UIColor.applePurple,UIColor.appleRed,UIColor.appleOrange,UIColor.appleYellow]
        let cursoryArray = [21,103,186,269,352]
        view.layer.borderColor = colorArray[state].cgColor
        cursor.frame = CGRect(x: CGFloat(cursoryArray[state]), y: 147, width: 40, height: 7)
        cursor.backgroundColor = colorArray[state]
    }
}
