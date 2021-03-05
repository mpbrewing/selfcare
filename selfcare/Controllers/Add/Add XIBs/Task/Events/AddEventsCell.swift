//
//  AddEventsCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/12/21.
//

import Foundation
import UIKit

class AddEventsCell: UITableViewCell,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var eventsLabel: UILabel!
    @IBOutlet weak var bgLabel: UILabel!
    @IBOutlet weak var bgButton: UIButton!
    @IBAction func bgButtonAction(_ sender: Any) {
        SegueToEvents()
    }
    @IBOutlet weak var eventCollection: UICollectionView!
    
    var events: [Event] = [Event]() {
        didSet {
            //print("events: \(events.count)")
            eventCollection.reloadData()
            updateIcon()
        }
    }
    
    var status = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupXIB()
        setupCollectionView()
    }
    
    func setupXIB() {
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor.gainsboro
        //
        bgLabel.text = "+"
        bgLabel.textColor = UIColor.gainsboro
        bgButton.layer.cornerRadius = 10
        bgButton.layer.borderColor = UIColor.gainsboro.cgColor
        bgButton.layer.borderWidth = 3
    }
    
    func updateLabel(events:[Event]){
        if events.count > 0 {
            if events.count == 1 {
                eventsLabel.text = "\(events.count) Event"
            } else {
                eventsLabel.text = "\(events.count) Events"
            }
            eventsLabel.textColor = UIColor.black
        } else {
            eventsLabel.text = "Events"
            eventsLabel.textColor = UIColor.lightGray
        }
    }
    
    func SegueToEvents(){
        modifyBackButton()
        let events = FullEvents()
        events.modalPresentationStyle = .fullScreen
        let vc = findViewController()
        vc?.navigationController?.pushViewController(events, animated: true)
    }
    
    func modifyBackButton(){
        let vc = findViewController()
        vc?.navigationController?.navigationBar.standardAppearance.setBackIndicatorImage(#imageLiteral(resourceName: "back2"), transitionMaskImage: #imageLiteral(resourceName: "back2"))
    }
    
    func updateIcon(){
        //let colors = [UIColor.gainsboro,UIColor.systemRed,UIColor.systemYellow,UIColor.systemGreen]
        if events.count > 0 {
            icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
            //icon.tintColor = UIColor.lightGray
            //icon.tintColor = UIColor.silver
            //con.tintColor = UIColor.systemGreen
            //icon.tintColor = colors[status]
        } else {
            icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
            //icon.tintColor = UIColor.gainsboro
        }
    }
    
}

extension AddEventsCell {
    
    func setupCollectionView(){
        self.eventCollection.register(UINib(nibName: "MiniEventCell", bundle:nil), forCellWithReuseIdentifier: "miniEvent")
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "miniEvent", for: indexPath as IndexPath) as! MiniEventCollectionCell
        if events.count > 0 {
            cell.event = events[indexPath.row]
            cell.status = status
            cell.updateLabels()
        } 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Segue to modify event
        //SegueToEvents()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 356, height: 112)
    }
    
}
