//
//  FullViewMenuCell.swift
//  selfcare
//
//  Created by Michael Brewington on 3/10/21.
//

import Foundation
import UIKit

class FullViewMenuCell: UITableViewCell{
    
    @IBOutlet weak var bg: UIImageView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var emoji: UILabel!
    
    var taskLabels = [String]()
    var folderLabels = [String]()
    var taskIcons = [UIImage]()
    var folderIcons = [UIImage]()
    var taskEmojis = [String]()
    var folderEmojis = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }
    
    func setupStyle(){
        taskLabels = ["About","Tasks","Notes"]
        folderLabels = ["Tasks","Projects","Notes","Reflections"]
        taskIcons = [#imageLiteral(resourceName: "about_icon2"),#imageLiteral(resourceName: "task"),#imageLiteral(resourceName: "note")]
        folderIcons = [#imageLiteral(resourceName: "task"),#imageLiteral(resourceName: "project"),#imageLiteral(resourceName: "note"),#imageLiteral(resourceName: "reflection")]
        taskEmojis = ["🔎","🧩","📝"]
        //folderEmojis = ["🧩","📚","📝","👁"] 💌👀🔓📨
        folderEmojis = ["🧩","📚","📝","👁"]
        bg.layer.cornerRadius = 8
        //bg.layer.backgroundColor = UIColor.gainsboro.cgColor
        bg.layer.backgroundColor = UIColor.gainsboro.cgColor
        icon.alpha = 0
    }
    
    func updateTaskStyle(index: Int){
        label.text = taskLabels[index]
        icon.image = taskIcons[index]
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor.black
        emoji.text = taskEmojis[index]
    }
    
    func updateFolderStyle(index: Int){
        label.text = folderLabels[index]
        icon.image = folderIcons[index]
        icon.contentMode = .scaleAspectFill
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor.black
        emoji.text = folderEmojis[index]
    }
    
    func ifSelected(selected: Bool){
        if selected {
            emoji.frame = CGRect(x: 10, y: 12, width: 30, height: 30)
            label.frame = CGRect(x: 50, y: 11, width: 344, height: 40)
            bg.frame = CGRect(x: 5, y: 7, width: 40, height: 40)
            label.font = label.font.withSize(20)
            emoji.font = emoji.font.withSize(20)
            label.alpha = 1
        } else {
            emoji.frame = CGRect(x: 13, y: 15, width: 24, height: 24)
            label.frame = CGRect(x: 50, y: 11, width: 344, height: 40)
            bg.frame = CGRect(x: 10, y: 12, width: 30, height: 30)
            label.font = label.font.withSize(18)
            emoji.font = emoji.font.withSize(16)
            label.alpha = 0.8
        }
    }
    
    
}
