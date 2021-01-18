//
//  FullEvents.swift
//  selfcare
//
//  Created by Michael Brewington on 1/14/21.
//

import Foundation
import UIKit

class FullEvents: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var cursor: UIView!
    @IBOutlet weak var tabCollection: UICollectionView!
    @IBOutlet weak var eventCollection: UICollectionView!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "EventsView")
        setupCollectionView()
        setupNavigationBar()
        setupStyle()
        setupSwipe()
    }
    
    var state = 0
    let tabReuseID = "eventTab"
    let dateReuseId = "dateTab"
    let timeReuseId = "timeTab"
    let repeatReuseId = "repeatTab"
    let notifyReuseId = "notifyTab"
    let locationReuseId = "locationTab"
    
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
        saveButton.layer.cornerRadius = 20
        saveButton.layer.backgroundColor = UIColor.appleBlue.cgColor
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
            self.tabCollection.reloadData()
            self.eventCollection.reloadData()
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
        saveButton.backgroundColor = colorArray[state]
    }
}

extension FullEvents {
    
    func setupCollectionView(){
        self.tabCollection.register(UINib(nibName: "EventTab", bundle:nil), forCellWithReuseIdentifier: tabReuseID)
        self.eventCollection.register(UINib(nibName: "EventDateTab", bundle:nil), forCellWithReuseIdentifier: dateReuseId)
        self.eventCollection.register(UINib(nibName: "EventTimeTab", bundle:nil), forCellWithReuseIdentifier: timeReuseId)
        self.eventCollection.register(UINib(nibName: "EventRepeatTab", bundle:nil), forCellWithReuseIdentifier: repeatReuseId)
        self.eventCollection.register(UINib(nibName: "EventNotifyTab", bundle:nil), forCellWithReuseIdentifier: notifyReuseId)
        self.eventCollection.register(UINib(nibName: "EventLocationTab", bundle:nil), forCellWithReuseIdentifier: locationReuseId)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case tabCollection:
            return 5
        case eventCollection:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case tabCollection:
            return switchTabCollection(collectionView: collectionView, indexPath: indexPath)
        case eventCollection:
            return switchEventCollection(collectionView: collectionView, indexPath: indexPath)
        default:
            return switchTabCollection(collectionView: collectionView, indexPath: indexPath)
        }
    }
    
    func switchTabCollection(collectionView: UICollectionView ,indexPath: IndexPath) -> UICollectionViewCell {
        let imageArray = [#imageLiteral(resourceName: "eventCalendar"),#imageLiteral(resourceName: "eventClock"),#imageLiteral(resourceName: "eventRepeat"),#imageLiteral(resourceName: "eventNotify"),#imageLiteral(resourceName: "eventLocation")]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.tabReuseID, for: indexPath as IndexPath) as! EventTabCell
        cell.tab.image = imageArray[indexPath.row]
        cell.updateStyle(row: indexPath.row, state: state)
        return cell
    }
    
    func switchEventCollection(collectionView: UICollectionView ,indexPath: IndexPath) -> UICollectionViewCell {
        switch state {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dateReuseId, for: indexPath as IndexPath) as! EventDateCell
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: timeReuseId, for: indexPath as IndexPath) as! EventTimeCell
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: repeatReuseId, for: indexPath as IndexPath) as! EventRepeatCell
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: notifyReuseId, for: indexPath as IndexPath) as! EventNotifyCell
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: locationReuseId, for: indexPath as IndexPath) as! EventLocationCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dateReuseId, for: indexPath as IndexPath) as! EventDateCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        //print("You selected cell #\(indexPath.item)!")
        switch collectionView {
        case tabCollection:
            state = indexPath.row
            animateSwitch()
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case tabCollection:
            let width = (collectionView.frame.width / 5)
            return CGSize(width: width, height: 50)
        case eventCollection:
            return CGSize(width: 414, height: 634)
        default:
            return CGSize(width: 50, height: 50)
        }
   }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    
    
}
