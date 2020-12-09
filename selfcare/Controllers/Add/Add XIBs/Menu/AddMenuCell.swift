//
//  AddMenuCell.swift
//  selfcare
//
//  Created by Michael Brewington on 12/8/20.
//

import Foundation
import UIKit

class AddMenuCell: UITableViewCell,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuBar: UIView!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var tasksButton: UIButton!
    @IBOutlet weak var notesButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupXIB()
        setupSwipe()
        setupTableView()
    }
    
    func setupXIB()
    {
        menuBar.layer.cornerRadius = 3
    }
    
    var addState = 0
    var menuState = 0
    let cellPhotoIdentifier = "addPhoto"
    let cellColorIdentifier = "addColor"
    
    
}

extension AddMenuCell {
    
    func setupSwipe(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeAction))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeAction))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        contentView.addGestureRecognizer(leftSwipe)
        contentView.addGestureRecognizer(rightSwipe)
    }
    
    @objc func leftSwipeAction() {
        menuState = menuState + 1
        animateSwitch()
    }
     
    @objc func rightSwipeAction() {
        menuState = menuState - 1
        animateSwitch()
    }
    
    func animateSwitch()
    {
        UIView.animate(withDuration: 0.2, animations: {
            self.switchMenuState()
            self.tableView.reloadData()
        })
    }
    
    func switchMenuState()
    {
        limitMenuState()
        let buttonArray = [aboutButton,tasksButton,notesButton]
        let updateFrameArray: [CGFloat] = [CGFloat(0),CGFloat(138),CGFloat(276)]
        
        for i in 0...2 {
            if i == menuState {
                changeButtonState(button: buttonArray[i]!, state: true)
                updateFrame(x: updateFrameArray[i])
            } else {
                changeButtonState(button: buttonArray[i]!, state: false)
            }
        }
    }
    
    func changeButtonState(button: UIButton, state: Bool)
    {
        if state == true {
            button.setTitleColor(.gray, for: .normal)
            button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: 20)
        } else {
            button.setTitleColor(.gainsboro, for: .normal)
            button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: 14)
        }
    }
    
    func updateFrame(x:CGFloat){
        menuBar.frame = CGRect(x: x, y: 44, width: 138, height: 8)
    }
    
    func limitMenuState()
    {
        if menuState > 2 {
            menuState = 0
        } else if menuState < 0 {
            menuState = 2
        }
    }
    
    
    
}

extension AddMenuCell {

     func setupTableView()
     {
         // Title
         tableView.register(UINib(nibName: "AddPhotoView", bundle: nil), forCellReuseIdentifier: cellPhotoIdentifier)
         // Color
         tableView.register(UINib(nibName: "AddColorView", bundle: nil), forCellReuseIdentifier: cellColorIdentifier)
         //
         tableView.delegate = self
         tableView.dataSource = self
         //
         tableView.tableFooterView = UIView()
     }
     
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
     }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return switchMenuStateNumberOfRows()
    }
    
    func returnAboutNumberOfRows() -> Int
    {
        switch addState {
        case 0:
            return 2
        default:
            return 0
        }
    }
    
    func switchMenuStateNumberOfRows() -> Int
    {
        switch menuState {
        case 0:
            return returnAboutNumberOfRows()
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch addState {
        case 0:
            return returnFolderCells(indexPath: indexPath)
        default:
            return returnFolderCells(indexPath: indexPath)
        }
    }
    
    //switchMenuCellForRowAt
    
    func returnFolderCells(indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellPhotoIdentifier, for: indexPath) as! AddPhotoCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellColorIdentifier, for: indexPath) as! AddColorCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellPhotoIdentifier, for: indexPath) as! AddPhotoCell
            return cell
        }
    }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch addState {
        case 0:
            return returnFolderCellHeight(indexPath: indexPath)
        default:
            return returnFolderCellHeight(indexPath: indexPath)
        }
     }
    
    //switchMenuHeightForRowAt()
    
    func returnFolderCellHeight(indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.row {
        case 0:
            return CGFloat(300)
        case 1:
            return CGFloat(380)
        default:
            return CGFloat(100)
        }
    }
    
    
}
