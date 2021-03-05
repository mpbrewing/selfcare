//
//  SwipeBarClass.swift
//  selfcare
//
//  Created by Michael Brewington on 12/16/20.
//

import Foundation
import UIKit

class SwipeBarClass: UIView,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var ViewHandle: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
     override init(frame: CGRect) {
         super.init(frame: frame)
         xibSetup()
     }

     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         xibSetup()
     }
     
     func xibSetup() {
         ViewHandle = loadViewFromNib(name: "SwipeBarView")
         // use bounds not frame or it'll be offset
         ViewHandle!.frame = bounds
         // Make the view stretch with containing view
         ViewHandle!.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
         // Adding custom subview on top of our view (over any custom drawing > see note below)
         addSubview(ViewHandle!)
         handleInit()
         setupCollectionView()
         addPanGesture()
     }
    
    var items = [Item]()
    var position = Int()
    var gesture = UIPanGestureRecognizer()
      
     func handleInit() {
        //setupStyle()
        NotificationCenter.default.addObserver(self, selector: #selector(toSwipeBarClass(notification:)), name: .toSwipeBarClass, object: nil)
     }
    
    func setupStyle(){
        ViewHandle.layer.cornerRadius = 20
        ViewHandle.layer.backgroundColor = UIColor.gainsboro.cgColor
    }
  
    
}

extension SwipeBarClass {
    
    func setupCollectionView(){
        self.collectionView.register(UINib(nibName: "SwipeBarCell", bundle:nil), forCellWithReuseIdentifier: "swipeBarMini")
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
        //return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "swipeBarMini", for: indexPath as IndexPath) as! SwipeBarMini
        if indexPath.row == position { //true
            //cell.isSelected(bool: true)
            cell.isSelected(bool: true, count: items.count)
        } else { //false
            //cell.isSelected(bool: false)
            cell.isSelected(bool: false, count: items.count)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        position = indexPath.row
        toSwipeClass()
        //collectionView.reloadData()
        collectionView.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: 20, height: 100)
        var width = (collectionView.frame.width / CGFloat(items.count))
        if width == 0 {
            width = 1
        }
        return CGSize(width: width, height: 100)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    
}

extension SwipeBarClass {
    
    func addPanGesture() {
         //let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        gesture.cancelsTouchesInView = false
        ViewHandle.addGestureRecognizer(gesture)
    }
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {

         switch sender.state {
         case .changed:
            let point = sender.location(in: ViewHandle)
            let new = getPosition(point: point)
            if new != position {
                position = new
                toSwipeClass()
            }
         default: break
             //print("handlePan")
         }
    }
    
    func getPosition(point: CGPoint)->Int{
        let x = point.x
        let div = x / CGFloat(315)
        let convert = div * CGFloat(items.count)
        var hold = Int(convert)
        if x > 315 {
            hold = items.count-1
            //print(hold)
        } else if x < 0 {
            hold = 0
        }
        return hold
    }
    
    
}

extension SwipeBarClass {
    
    @objc func toSwipeBarClass(notification: NSNotification) {
        //if let state = notification.userInfo?["state"] as? Bool {
        position = notification.userInfo?["position"] as? Int ?? 0
        items = notification.userInfo?["items"] as? [Item] ?? items
        //print("toSwipeBarClass: \(items.count)")
        collectionView.reloadData()
        //}
    }
    
    func toSwipeClass()
    {
        let notif = ["position":position]
        NotificationCenter.default.post(name: .toSwipeClass, object: nil,userInfo: notif)
    }
    
}
