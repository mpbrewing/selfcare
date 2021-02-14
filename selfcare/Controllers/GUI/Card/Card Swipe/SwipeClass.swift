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
    var itemWallet = [Wallet]()
    let db = Firestore.firestore()
    var position: CGPoint = CGPoint(x: 0,y: 0)
    var emptyItem = Item(id: "", index: 0, path: [], details: [:])
    var load = false
    var holdPositions: [Int] = []
    
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
        setupModels()
        setupSwipe()
        setupCardPosition()
        addCards()
    }
    
    func setupModels(){
        wallet = Array(repeating: Wallet(items: []), count: 4)
        itemWallet = Array(repeating: Wallet(items: []), count: 4)
        holdPositions = Array(repeating: 0, count: 4)
    }
    
    func addCards(){
       
        signal.layer.cornerRadius = 4
        downloadPosts(db: db, completion: {item in
            self.items = item
            //print(self.items.count)
            //self.wallet.append(Wallet(items: self.items))
            self.filterItems()
            self.filterNext()
            self.updateCards()
            self.manageAnimation()
        })
    }
    //Structure Four Tier Wallet Class for Cards
    //Add GUI(s) to Card
    //Pull Details from Items and create limits based on size
    func filterItems(){
        print("Items: \(items.count)")
        for i in 0...3 {
            //print("Wallet \(i): \(wallet[i].items.count)")
            let filtered = items.filter({ filter in
                if filter.index == i {
                    return true
                } else {
                    return false
                }
            })
            if filtered.count > 0 {
                itemWallet[i] = Wallet(items: filtered)
            } else {
                itemWallet[i] = Wallet(items: [])
            }
            if i == 0 {
                wallet[i] = Wallet(items: filtered)
            }
        }
    }
    
    func filterNext(){
        let item = wallet[Int(position.y)].items[Int(position.x)]
        let id = item.id
        if position.y < 3 {
            let filtered = itemWallet[Int(position.y+1)].items.filter({ filter in
                if filter.path.contains(id) {
                    return true
                } else {
                    return false
                }
            })
            //print("\(Int(position.y+1)): \(filtered.count)")
            wallet[Int(position.y+1)] = Wallet(items: filtered)
        }
    }
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
            //print("x: \(cardPosition[i].x) ... y:\(cardPosition[i].y)")
            let newCard = SwipeCard(position: cardPosition[i], view: cardArray[i], global: cardPosition[i], item: loadCards(global: cardPosition[i]))
            cards.append(newCard)
        }
    }

    func loadCards(global: CGPoint) -> Item {
        //Wallet
        if global.y < 4 {
            if global.x >= 0 && global.y >= 0 && wallet[Int(global.y)].items.count > Int(global.x) {
                return wallet[Int(global.y)].items[Int(global.x)]
            } else {
                return emptyItem
            }
        } else {
            return emptyItem
        }
    }

    func retrieveItemData(input: SwipeCard) {
        //print("Global: x: \(input.global.x) // y: \(input.global.y)")
        //print("Pos: x: \(input.position.x) // y: \(input.position.y)")
        if input.global.x >= 0 && input.global.y >= 0 && wallet[Int(input.global.y)].items.count > Int(input.global.x) {
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
                    position.x = CGFloat(holdPositions[Int(position.y-1)])
                    position.y = position.y - 1
                    filterNext()
                    updateGlobalPosition(direction: sender.direction)
                }
            case .up:
                //print("up swipe")
                if (Int(position.y) < 3) {
                    if (wallet[Int(position.y+1)].items.count > 0) {
                        holdPositions[Int(position.y)] = Int(position.x)
                        position.x = 0
                        position.y = position.y + 1
                        holdPositions[Int(position.y)] = 0
                        filterNext()
                        updateGlobalPosition(direction: sender.direction)
                    }
                }
            case .left:
                //print("left swipe")
                if Int(position.x) < wallet[Int(position.y)].items.count-1 {
                    position.x = position.x + 1
                    holdPositions[Int(position.y)] = Int(position.x)
                    filterNext()
                    updateGlobalPosition(direction: sender.direction)
                }
            case .right:
                //print("right swipe")
                if Int(position.x) != 0 {
                    position.x = position.x - 1
                    holdPositions[Int(position.y)] = Int(position.x)
                    filterNext()
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
        //print("x: \(position.x) // y:\(position.y)")
    }
    
    func checkGlobalPosition() {
      
    }
    
    func updatePosition(direction: UISwipeGestureRecognizer.Direction){
        if direction == .left || direction == .right {
            updateXPosition(direction: direction)
        } else {
            updateYPosition(direction: direction)
            updateGlobalY(direction: direction)
        }
    }
    
    func updateGlobalY(direction: UISwipeGestureRecognizer.Direction){
        if direction == .up {
            //print("y-1: \(CGFloat(holdPositions[Int(position.y-1)]))")
            for i in 0...cards.count-1{
                let globalX = cards[i].global.x - CGFloat(holdPositions[Int(position.y-1)])
                let globalY = cards[i].global.y
                cards[i].updateGlobal(x: globalX, y: globalY)
                let global = cards[i].global
                cards[i].updateItem(item: loadCards(global: global))
            }
        } else if direction == .down {
            //print("y: \(CGFloat(holdPositions[Int(position.y)]))")
            //print("y+1: \(CGFloat(holdPositions[Int(position.y+1)]))")
            for i in 0...cards.count-1{
                let globalX = cards[i].global.x + CGFloat(holdPositions[Int(position.y)]) - CGFloat(holdPositions[Int(position.y+1)])
                let globalY = cards[i].global.y
                cards[i].updateGlobal(x: globalX, y: globalY)
                let global = cards[i].global
                cards[i].updateItem(item: loadCards(global: global))
            }
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
            //print("\(direction)///")
            //print("Gx: \(cards[i].global.x)... Gy: \(cards[i].global.y)")
            //print("x: \(cards[i].position.x)... y: \(cards[i].position.y)")
            //print("///")
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
        //print(direction)
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
                if Int(cards[i].global.x) >= wallet[Int(cards[i].global.y)].items.count {
                    cards[i].view.alpha = 0
               } else {
                    retrieveItemData(input: cards[i])
                    cards[i].view.alpha = 1
               }
                if cards[i].position == CGPoint(x: 0, y: 0){
                    //print(wallet[Int(position.y+1)].items.count)
                    if position.y < 3 {
                        if (wallet[Int(position.y+1)].items.count > 0) {
                            signal.isHidden = false
                        } else {
                            signal.isHidden = true
                        }
                    } else {
                        signal.isHidden = true
                    }
                }
            } else {
                cards[i].view.alpha = 0
            }
        }
    }
    
    func updateCardArrayItems(card: SwipeCard){
        
    }
    
}

extension SwipeClass {
    
    func passWallet()
    {
        print("pass")
        //Pass Data
        let notif = ["index":7,"wallet":wallet,"items":items] as [String : Any]
        NotificationCenter.default.post(name: .addTaskDetails, object: nil,userInfo: notif)
    }
    
}
