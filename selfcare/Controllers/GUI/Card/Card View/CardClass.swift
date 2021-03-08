//
//  CardClass.swift
//  selfcare
//
//  Created by Michael Brewington on 12/16/20.
//

import Foundation
import UIKit
import SDWebImage


class CardClass: UIView {
    
    @IBOutlet var ViewHandle: UIView!
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var status: UIButton!
    //@IBOutlet weak var gradientView: UIView!
    @IBAction func statusAction(_ sender: Any) {
        //print("status tap")
    }
    
    @IBOutlet weak var bg: UIButton!
    @IBAction func bgAction(_ sender: Any) {
        //
        //print(item.id)
        SegueToFull()
    }
    var item = Item(id: "", index: 0, path: [], details: [:])
    //id
    
    
    var gradientView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        ViewHandle = loadViewFromNib(name: "CardView")
        // use bounds not frame or it'll be offset
        ViewHandle!.frame = bounds
        // Make the view stretch with containing view
        ViewHandle!.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(ViewHandle!)
        handleInit()
    }
     
    func handleInit() {
        ViewHandle.layer.cornerRadius = 20
        cover.layer.cornerRadius = 20
        status.layer.cornerRadius = 8
        handleGradient()
    }
    
    func setDetails(emoji: String,name:String,url: String) {
        status.setTitle(emoji, for: .normal)
        title.text = name
        let placeholderImage = UIImage(named: "placeholder.jpg")
        cover.sd_setImage(with: URL(string: url), placeholderImage: placeholderImage)
    }
    
    let gradient = CAGradientLayer()
    
    func handleGradient() {
        gradientView = UIView(frame: CGRect(x: 0, y: 0, width: 332, height: 638))
        gradientView.backgroundColor = .clear
        ViewHandle.addSubview(gradientView)
        ViewHandle.sendSubviewToBack(gradientView)
        ViewHandle.sendSubviewToBack(cover)
        let gradient = CAGradientLayer()
        gradient.frame = gradientView.bounds
        gradient.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 3.0)
        gradient.cornerRadius = 20
        gradientView.layer.addSublayer(gradient)
        gradientView.alpha = 0.5
    }
    
    func toggleGradient(value: Bool) {
        if value == true {
            gradientView.alpha = 0.5
        } else {
            gradientView.alpha = 0.0
        }
    }
    
    func SegueToFull(){
        modifyBackButton()
        let full = FullGUI()
        full.item = item
        full.modalPresentationStyle = .fullScreen
        let vc = findViewController()
        vc?.navigationController?.pushViewController(full, animated: true)
    }
    
    func modifyBackButton(){
        let vc = findViewController()
        vc?.navigationController?.navigationBar.standardAppearance.setBackIndicatorImage(#imageLiteral(resourceName: "back2"), transitionMaskImage: #imageLiteral(resourceName: "back2"))
    }
    
}
