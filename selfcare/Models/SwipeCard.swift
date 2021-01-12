//
//  SwipeCard.swift
//  selfcare
//
//  Created by Michael Brewington on 1/8/21.
//

import Foundation
import UIKit

class SwipeCard {
    
    var position:  CGPoint
    //var view: UIView
    var view: CardClass
    var global: CGPoint
    var item: Item
  
    //init(position: CGPoint,view: UIView,global:CGPoint,item:Item) {
    init(position: CGPoint,view: CardClass,global:CGPoint,item:Item) {
        self.position = position
        self.view = view
        self.global = global
        self.item = item
    }
    
    func updateGlobal(x: CGFloat, y: CGFloat) {
        self.global.x = x
        self.global.y = y
    }
    
    func updateX(x: Int){
        self.position.x = CGFloat(x)
    }
    
    func updateY(y: Int){
        self.position.y = CGFloat(y)
    }
    
    func updateItem(item: Item){
        self.item = item
    }
    
}

