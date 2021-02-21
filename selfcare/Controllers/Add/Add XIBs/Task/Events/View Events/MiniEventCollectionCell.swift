//
//  MiniEventCollectionCell.swift
//  selfcare
//
//  Created by Michael Brewington on 2/21/21.
//

import Foundation
import UIKit

class MiniEventCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var divider2: UIView!
    @IBOutlet weak var divider3: UIView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    
    var images = [UIImage]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupXIB()
    }
    
    func setupXIB() {
        bg.layer.cornerRadius = 10
        bg.layer.borderColor = UIColor.gainsboro.cgColor
        bg.layer.borderWidth = 3
        for view in [divider,divider2,divider3] {
            view?.layer.cornerRadius = 2
            view?.backgroundColor = UIColor.gainsboro
        }
        images = [#imageLiteral(resourceName: "eventCalendar"),#imageLiteral(resourceName: "event_icon"),#imageLiteral(resourceName: "eventRepeat"),#imageLiteral(resourceName: "eventNotify"),#imageLiteral(resourceName: "eventLocation")]
        //let colorArray = [UIColor.appleBlue,UIColor.applePurple,UIColor.appleRed,UIColor.appleOrange,UIColor.appleYellow]
        for i in 0...images.count-1 {
            let imageArray = [image1,image2,image3,image4,image5]
            imageArray[i]?.image = images[i]
            imageArray[i]?.image = imageArray[i]?.image?.withRenderingMode(.alwaysTemplate)
            //imageArray[i]?.tintColor = colorArray[i]
            //imageArray[i]?.tintColor = UIColor.gainsboro
            imageArray[i]?.tintColor = UIColor.lightGray
        }

    }
    
}
