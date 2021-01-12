//
//  SwipeClass.swift
//  selfcare
//
//  Created by Michael Brewington on 12/16/20.
//

import Foundation
import UIKit
import Firebase

class SwipeClass: UIView {
    
    @IBOutlet var ViewHandle: UIView!
    @IBOutlet weak var signal: UIView!
    
    var Card00 = CardClass()
    var Card10 = CardClass()
    var Card20 = CardClass()
    var Card30 = CardClass()
    var Card01 = CardClass()
    var Card11 = CardClass()
    var Card21 = CardClass()
    var Card31 = CardClass()
    var Card02 = CardClass()
    var Card12 = CardClass()
    var Card22 = CardClass()
    var Card32 = CardClass()
    
    var cardPosition: [CGPoint] = []
    var cards = [SwipeCard]()
    var items = [Item]()
    var wallet = [Wallet]()
    let db = Firestore.firestore()
    var position: CGPoint = CGPoint(x: 0,y: 0)
    var emptyItem = Item(id: "", index: 0, path: [], details: [:])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        ViewHandle = loadViewFromNib(name: "SwipeView")
        // use bounds not frame or it'll be offset
        ViewHandle!.frame = bounds
        // Make the view stretch with containing view
        ViewHandle!.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(ViewHandle!)
        handleInit()
    }
     
    func handleInit() {
        setupSwipe()
        setupCardPosition()
        addCards()
    }
    
    func addCards(){
       
        signal.layer.cornerRadius = 4
        downloadPosts(db: db, completion: {item in
            self.items = item
            print(self.items.count)
            //Sort index 0 and 1
            self.wallet.append(Wallet(items: self.items))
            self.updateCards()
            self.manageAnimation()
        })
    }
    //Structure Four Tier Wallet Class for Cards
    //Add GUI(s) to Card
    //Pull Details from Items and create limits based on size
}

extension SwipeClass {

    func setupCardPosition() {
        var x = -1
        var y = -1
        for _ in 0...11{
            if x > 2{
                x = -1
                y = y + 1
            }
            let position = CGPoint(x: x, y: y)
            cardPosition.append(position)
            x = x + 1
        }
    }
    
    func setupCardFrame(position: CGPoint) -> CGRect {
        var x = 0
        var y = 0
        var width = 0
        var height = 0
        switch position.x {
        case -1:
            x = -332
        case 0:
            x = 10
        case 1:
            x = 352
        case 2:
            x = 528
        default:
            break
        }
        switch position.y {
        case -1:
            y = -660
        case 0:
            y = 0
        case 1:
            y = 680
        default:
            break
        }
        switch position.x {
        case 1,2:
            width = 166
            height = 319
        default:
            width = 332
            height = 638
        }
        let returnRect = CGRect(x: x, y: y, width: width, height: height)
        return returnRect
    }

    func updateCards() {
        var cardArray = [Card00,Card10,Card20,Card30,Card01,Card11,Card21,Card31,Card02,Card12,Card22,Card32]
        for i in 0...cardArray.count-1{
            cardArray[i].layer.cornerRadius = 20
            let frame = setupCardFrame(position: cardPosition[i])
            cardArray[i] = CardClass(frame: frame)
            self.ViewHandle.addSubview(cardArray[i])
            //Items -> Wallet
            let newCard = SwipeCard(position: cardPosition[i], view: cardArray[i], global: cardPosition[i], item: loadCards(global: cardPosition[i]))
            cards.append(newCard)
        }
    }
    
    func loadCards(global: CGPoint) -> Item {
        //Wallet
        if global.x >= 0 && global.y >= 0 && items.count > Int(global.x) {
            return items[Int(global.x)]
        } else {
            return emptyItem
        }
    }
    
    func retrieveItemData(input: SwipeCard) {
        //print("Global: x: \(input.global.x) // y: \(input.global.y)")
        //print("Pos: x: \(input.position.x) // y: \(input.position.y)")
        if input.global.x >= 0 && input.global.y >= 0 && items.count > Int(input.global.x) {
        let details = input.item.details
        let emoji = details["emoji"] as! String
        let title = details["title"] as! String
        let photoURL = details["photoURL"] as! String
        input.view.setDetails(emoji: emoji, name: title, url: photoURL)
        }
        //print("//")
    }
    
     
}

extension SwipeClass {
    
    func setupSwipe() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.right, .left, .up, .down]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
            gesture.direction = direction
            self.addGestureRecognizer(gesture)
        }
    }

    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        //print(sender.direction)
        
        switch sender.direction {
            case .down:
                //print("down swipe")
                if Int(position.y) != 0 {
                    position.y = position.y - 1
                    updateGlobalPosition(direction: sender.direction)
                }
            case .up:
                //print("up swipe")
                if Int(position.y) < 3 {
                    position.y = position.y + 1
                    updateGlobalPosition(direction: sender.direction)
                }
            case .left:
                //print("left swipe")
                if Int(position.x) < items.count-1 {
                    position.x = position.x + 1
                    updateGlobalPosition(direction: sender.direction)
                }
            case .right:
                //print("right swipe")
                if Int(position.x) != 0 {
                    position.x = position.x - 1
                    updateGlobalPosition(direction: sender.direction)
                }
            default:
                print("other swipe")
        }
    }
    
    func manageAnimation() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
            self.updateCardRect()
        }, completion: { finished in
          //print("animation complete!")
        })
    }
    
    func updateGlobalPosition(direction: UISwipeGestureRecognizer.Direction) {
        updatePosition(direction: direction)
        manageAnimation()
    }
    
    func checkGlobalPosition() {
      
    }
    
    func updatePosition(direction: UISwipeGestureRecognizer.Direction){
        if direction == .left || direction == .right {
            updateXPosition(direction: direction)
        } else {
            updateYPosition(direction: direction)
        }
    }
    
    func updateXPosition(direction: UISwipeGestureRecognizer.Direction){
        var value = 0
        if direction == .left {
            value = -1
        } else {
            value = 1
        }
        for i in 0...cards.count-1{
            let x = iterateCardPosition(direction: direction, input: (Int(cards[i].position.x) + value))
            cards[i].updateX(x: x)
            if direction == .left {
                if x == 2 {
                    let globalX = position.x + 2
                    let globalY = cards[i].global.y
                    cards[i].updateGlobal(x: globalX, y: globalY)
                    let global = cards[i].global
                    cards[i].updateItem(item: loadCards(global: global))
                }
            } else {
                if x == -1 {
                    let globalX = position.x - 1
                    let globalY = cards[i].global.y
                    cards[i].updateGlobal(x: CGFloat(globalX), y: globalY)
                    let global = cards[i].global
                    cards[i].updateItem(item: loadCards(global: global))
                }
            }
        }
    }
    
    func updateYPosition(direction: UISwipeGestureRecognizer.Direction){
        var value = 0
        if direction == .up {
            value = -1
        } else {
            value = 1
        }
        for i in 0...cards.count-1{
            let y = iterateCardPosition(direction: direction, input: (Int(cards[i].position.y) + value))
            cards[i].updateY(y: y)
            if direction == .up {
                if y == 1 {
                    let globalX =  cards[i].global.x
                    let globalY = position.y + 1
                    cards[i].updateGlobal(x: globalX, y: globalY)
                    let global = cards[i].global
                    cards[i].updateItem(item: loadCards(global: global))
                }
            } else {
                if y == -1 {
                    let globalX =  cards[i].global.x
                    let globalY = position.y - 1
                    cards[i].updateGlobal(x: globalX, y: globalY)
                    let global = cards[i].global
                    cards[i].updateItem(item: loadCards(global: global))
                }
            }
        }
    }
    
    func iterateCardPosition(direction: UISwipeGestureRecognizer.Direction,input: Int)->Int{
        switch direction {
        case .down,.up:
            if input > 1 {
                return -1
            } else if input < -1 {
                return 1
            } else {
                return input
            }
        case .left,.right:
            if input > 2 {
                return -1
            } else if input < -1 {
                return 2
            } else {
                return input
            }
        default:
            return input
        }
    }
    
    func updateCardRect() {
        for i in 0...cards.count-1 {
            cards[i].view.frame = setupCardFrame(position:  cards[i].position)
            if cards[i].position == CGPoint(x: 0, y: 0) || cards[i].position == CGPoint(x: 1, y: 0) {
               if Int(cards[i].global.x) >= items.count {
                    cards[i].view.alpha = 0
               } else {
                    retrieveItemData(input: cards[i])
                    cards[i].view.alpha = 1
               }
            } else {
                cards[i].view.alpha = 0
            }
        }
    }
    
}
