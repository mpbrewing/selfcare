//
//  AddButtonViewClass.swift
//  selfcare
//
//  Created by Michael Brewington on 11/30/20.
//

import Foundation
import UIKit

class AddButtonViewClass: UIView,UITableViewDelegate, UITableViewDataSource {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    func xibSetup() {
        ViewHandle = loadViewFromNib(name: "AddButtonView")
        // use bounds not frame or it'll be offset
        ViewHandle!.frame = bounds
        // Make the view stretch with containing view
        ViewHandle!.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(ViewHandle!)
        handleInit()
    }
   
    @IBOutlet var ViewHandle: UIView!
    
    func handleInit() {
        setupTableView()
        setupButton()
    }
    
    let cellIdentifier = "addButton"
    let buttonCellModel = [["Folder": #imageLiteral(resourceName: "folder")],["Task": #imageLiteral(resourceName: "task")],["Project": #imageLiteral(resourceName: "project")],["Note": #imageLiteral(resourceName: "note")],["Reflection": #imageLiteral(resourceName: "reflection")]]
    
    @IBOutlet weak var tableView: UITableView!
    
    func setupTableView()
    {
        tableView.register(UINib(nibName: "AddButtonCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

    var state = false
    
    @IBOutlet weak var addButton: UIButton!
    @IBAction func addButtonAction(_ sender: UIButton) {
        state = !state
        toggleButton()
        tableView.reloadData()
    }
    
}

extension AddButtonViewClass {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case true:
            return buttonCellModel.count
        case false:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! AddButtonCellClass
        let image = buttonCellModel[indexPath.row].values.first
        let text = buttonCellModel[indexPath.row].keys.first
        cell.setData(image: image!, text: text!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        passButtonSelectionSegue(row: indexPath.row)
    }
    
    func passButtonSelectionSegue(row: Int)
    {
        let passState = ["switchSegue":row]
        NotificationCenter.default.post(name: .addItemSegue, object: nil,userInfo: passState)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func switchHeight()
    {
        switch state {
        case true:
            modifyHeight(height: 420, width: 160)
            addButton.frame = CGRect(x: 89, y: 350, width: 70, height: 70)
        case false:
            modifyHeight(height: 72, width: 70)
            addButton.frame = CGRect(x: 1, y: 0, width: 70, height: 70)
        }
        let passState = ["state":state]
        NotificationCenter.default.post(name: .addButton, object: nil,userInfo: passState)
    }
    
    func modifyHeight(height: CGFloat,width: CGFloat)
    {
        var frame = self.tableView.frame
        frame.size.height = height
        frame.size.width = width
        self.tableView.frame = frame
        bounds = frame
    }
    
}

extension AddButtonViewClass {
    
    func setupButton() {
        addButton.layer.cornerRadius = addButton.frame.width/2
        addButton.backgroundColor = UIColor.black
        toggleButton()
    }
    
    func changeButtonImage(image: UIImage) {
        let tintedImage = image.withTintColor(UIColor.white, renderingMode: .alwaysTemplate)
        addButton.tintColor = UIColor.white
        addButton.setImage(tintedImage, for: .normal)
    }
    
    func toggleButton() {
        switchHeight()
        switch state {
        case true:
            changeButtonImage(image: #imageLiteral(resourceName: "cancel"))
        case false:
            changeButtonImage(image: #imageLiteral(resourceName: "plus"))
        }
    }
    
}
