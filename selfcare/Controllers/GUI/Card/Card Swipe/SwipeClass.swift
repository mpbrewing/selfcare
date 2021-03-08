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
    
    var holdID: String = String() {
        didSet {
           // if holdFilePath.count > 0 {
                //self.scrollTo()
                //self.passItemsInRow()
            //}
            //toggleGif(toggle: false)
        }
    }
    var holdFilePath = [String]()
    
    //var gif = LoadingView()
    
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
        //gif.frame = CGRect(x: 0, y: 0, width: 414, height: 660)
        //toggleGif(toggle: true)
        //gif.updateView()
        NotificationCenter.default.addObserver(self, selector: #selector(toSwipeClass(notification:)), name: .toSwipeClass, object: nil)
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
            self.passItemsInRow()
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
        if wallet[Int(position.y)].items.count > 0 {
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
    
    func reloadCards(){
        /*
        downloadPosts(db: db, completion: {item in
            self.items = item
            self.filterItems()
            self.filterNext()
            self.updateCards()
            self.manageAnimation()
            self.passItemsInRow()
        }) */
        downloadPosts(db: db, completion: {item in
            self.items = item
            self.updateY()
            self.filterItems()
            self.filterNext()
            self.reUpdateCards()
            self.manageAnimation()
            self.scrollTo()
            self.passItemsInRow()
        })
    }
    
    func reloadFolder(){
        downloadPosts(db: db, completion: {item in
            self.items = item
            self.updateY()
            self.filterItems()
            self.reUpdateCards()
            self.manageAnimation()
            self.scrollTo()
            self.passItemsInRow()
        })
    }
    
    func updateY(){
        if Int(position.y) > 0 {
            for _ in 0...(Int(position.y)-1){
                down()
            }
        }
    }
    
    /*
    func toggleGif(toggle: Bool){
        gif.updateBG(color: UIColor.white)
        if toggle == true {
            gif.isHidden = false
            ViewHandle.bringSubviewToFront(gif)
        } else {
            gif.isHidden = true
            ViewHandle.sendSubviewToBack(gif)
        }
        
    }*/
    
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
        let cardArray = [Card00,Card10,Card20,Card30,Card01,Card11,Card21,Card31,Card02,Card12,Card22,Card32]
        for i in 0...cardArray.count-1{
            cardArray[i].layer.cornerRadius = 20
            let frame = setupCardFrame(position: cardPosition[i])
            //cardArray[i] = CardClass(frame: frame)
            cardArray[i].frame = frame
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
            let emoji = details["emoji"] as? String ?? "🖤"
            let title = details["title"] as? String ?? "(no title)"
            let photoURL = details["photoURL"] as? String ?? ""
            //let emoji = details["emoji"] as! String
            //let title = details["title"] as! String
            //let photoURL = details["photoURL"] as! String
            input.view.item = input.item
            input.view.setDetails(emoji: emoji, name: title, url: photoURL)
        }
        //print("//")
    }
    
    func reUpdateCards() {
        let cardArray = [Card00,Card10,Card20,Card30,Card01,Card11,Card21,Card31,Card02,Card12,Card22,Card32]
        for i in 0...cardArray.count-1{
            cardArray[i].layer.cornerRadius = 20
            let frame = setupCardFrame(position: cardPosition[i])
            //cardArray[i] = CardClass(frame: frame)
            cardArray[i].frame = frame
            self.ViewHandle.addSubview(cardArray[i])
            //Items -> Wallet
            //print("x: \(cardPosition[i].x) ... y:\(cardPosition[i].y)")
            let newCard = SwipeCard(position: cardPosition[i], view: cardArray[i], global: cardPosition[i], item: loadCards(global: cardPosition[i]))
            cards[i] = newCard
            //cards.append(newCard)
        }
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
                    passItemsInRow()
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
                        passItemsInRow()
                    }
                }
            case .left:
                if Int(position.x) < wallet[Int(position.y)].items.count-1 {
                    position.x = position.x + 1
                    //passItemsInRow()
                    holdPositions[Int(position.y)] = Int(position.x)
                    filterNext()
                    updateGlobalPosition(direction: sender.direction)
                    passItemsInRow()
                }
            case .right:
                if Int(position.x) != 0 {
                    position.x = position.x - 1
                    holdPositions[Int(position.y)] = Int(position.x)
                    filterNext()
                    updateGlobalPosition(direction: sender.direction)
                    passItemsInRow()
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
                //print("wallet: \(wallet[Int(cards[i].global.y)].items.count)")
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
    
}

extension SwipeClass {
    
    func passWallet()
    {
        print("pass Wallet")
        //Pass Data
        let notif = ["index":7,"wallet":wallet,"items":items] as [String : Any]
        NotificationCenter.default.post(name: .addTaskDetails, object: nil,userInfo: notif)
    }
    
    func passItemsInRow(){
        //print("pass Items: \(wallet[Int(position.y)].items.count)")
        let notif = ["items":wallet[Int(position.y)].items,"position":Int(position.x)] as [String : Any]
        NotificationCenter.default.post(name: .toSwipeBarClass, object: nil,userInfo: notif)
    }
    
    @objc func toSwipeClass(notification: NSNotification) {
        //if let state = notification.userInfo?["state"] as? Bool {
        let x = notification.userInfo?["position"] as? Int ?? Int(position.x)
        //print("toSwipeClass: \(x)")
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
            self.checkPosition(hold: x)
        }, completion: { finished in
          //print("animation complete!")
        })
        position.x = CGFloat(x)
        //checkPosition(hold: x)
        //}
    }
    
    func passButtonSelectionSegue(row: Int)
    {
        let passState = ["switchSegue":row]
        NotificationCenter.default.post(name: .addItemSegue, object: nil,userInfo: passState)
    }
    
    func checkPosition(hold: Int){
        //print(hold)
        //print(Int(position.x))
        let convert = hold-Int(position.x)
        //print(convert)
        if checkSteps(convert: convert) {
            if convert > 0 { //left
                let steps = abs(convert)-1
                for _ in 0...steps{
                    moveRight()
                }
            } else { //right
                let steps = abs(convert)-1
                for _ in 0...steps{
                    moveLeft()
                }
            }
        }
    }
    
    func checkSteps(convert: Int)->Bool{
        let steps = abs(convert)-1
        if steps < 0 {
            return false
        } else {
            return true
        }
    }
    
    func moveLeft(){
        //print("left")
        if Int(position.x) != 0 {
            position.x = position.x - 1
            holdPositions[Int(position.y)] = Int(position.x)
            filterNext()
            updateGlobalPosition(direction: .right)
            passItemsInRow()
        }
    }
    
    func moveRight(){
        //print("right")
        if Int(position.x) < wallet[Int(position.y)].items.count-1 {
            position.x = position.x + 1
            //passItemsInRow()
            holdPositions[Int(position.y)] = Int(position.x)
            filterNext()
            updateGlobalPosition(direction: .left)
            passItemsInRow()
        }
    }
    
    func down(){
        //print("down swipe")
        if Int(position.y) != 0 {
            position.x = CGFloat(holdPositions[Int(position.y-1)])
            position.y = position.y - 1
            filterNext()
            updateGlobalPosition(direction: .down)
            passItemsInRow()
        }
    }
    func up(){
        //print("up swipe")
        if (Int(position.y) < 3) {
            if (wallet[Int(position.y+1)].items.count > 0) {
                holdPositions[Int(position.y)] = Int(position.x)
                position.x = 0
                position.y = position.y + 1
                holdPositions[Int(position.y)] = 0
                filterNext()
                updateGlobalPosition(direction: .up)
                passItemsInRow()
            }
        }
    }
    //Search Path
    //Scroll To Location
    //
    /*
     self.filterItems()
     self.filterNext()
     self.updateCards()
     self.manageAnimation()
     */
    
    
    func scrollTo(){
        
        //Get X of First Path - Y is the index of path
        //
        //var x = CGFloat()
        if holdFilePath.count > 0{
            for i in 0...holdFilePath.count-1 {
                let index = findIndex(y: i, id: holdFilePath[i])
                filterSteps(x: index, y: i)
                //x = CGFloat(index)
                UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
                    self.checkPosition(hold: index)
                }, completion: { finished in
                  //print("animation complete!")
                })
                up()
            }
            print("holdID: \(holdID)")
            let index = findIndex(y: holdFilePath.count, id: holdID)
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
                self.checkPosition(hold: index)
            }, completion: { finished in
              //print("animation complete!")
            })
            //position.x = CGFloat(index)
            position.y = CGFloat(holdFilePath.count)
            //print("x: \(position.x)")
            //print("y: \(position.y)")
            
        } else {
            let index = findIndex(y: 0, id: holdID)
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
                self.checkPosition(hold: index)
            }, completion: { finished in
              //print("animation complete!")
            })
            //position.x = CGFloat(index)
            position.y = 0
            // print("---\(holdID)")
            //print("x: \(position.x)")
            //print("y: \(position.y)")
        }
        
    }
    
    func findIndex(y: Int,id:String)->Int{
        let indexItems = wallet[y].items
        if indexItems.count > 0 {
            for i in 0...(indexItems.count-1) {
                //print(indexItems[i].id)
                if indexItems[i].id == id {
                    return i
                }
            }
        }
        return 0
    }
    
    func filterSteps(x: Int, y: Int){
        let item = wallet[y].items[x]
        let id = item.id
        if y < 3 {
            let filtered = itemWallet[Int(y+1)].items.filter({ filter in
                if filter.path.contains(id) {
                    return true
                } else {
                    return false
                }
            })
            //print("\(Int(y+1)): \(filtered.count)")
            wallet[y+1] = Wallet(items: filtered)
        }
    }
    
    
}
