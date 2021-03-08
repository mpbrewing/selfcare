//
//  AddColorCell.swift
//  selfcare
//
//  Created by Michael Brewington on 12/8/20.
//

import Foundation
import UIKit

class AddColorCell: UITableViewCell {
    
    @IBOutlet weak var colorIcon: UIImageView!
    @IBOutlet weak var Shade: UIView!
    @IBOutlet weak var colorScale: UIView!
    @IBOutlet weak var arrowIcon: UIImageView!
    @IBOutlet weak var Tint: UIView!
    @IBOutlet weak var shadeIcon: UIImageView!
    @IBOutlet weak var hex: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupXIB()
    }
    
    func setupXIB() {
        Shade.layer.cornerRadius = 10
        //Shade.layer.backgroundColor = UIColor.gainsboro.cgColor
        Tint.layer.cornerRadius = 10
        //Tint.layer.backgroundColor = UIColor.gainsboro.cgColor
        colorIcon.image = colorIcon.image?.withRenderingMode(.alwaysTemplate)
        colorIcon.tintColor = UIColor.gainsboro
        colorScale.layer.cornerRadius = 10
        arrowIcon.image = arrowIcon.image?.withRenderingMode(.alwaysTemplate)
        arrowIcon.tintColor = UIColor.gainsboro
        shadeIcon.image = shadeIcon.image?.withRenderingMode(.alwaysTemplate)
        shadeIcon.tintColor = UIColor.white
        addTintGradient(tintColor: UIColor.init(red: 1, green: 0, blue: 0, alpha: 1))
        addShadeGradient()
        addColorScaleGradient()
        addPanGesture()
    }
    
    let shadeGradient = CAGradientLayer()
    let tintGradient = CAGradientLayer()
    let hueGradient = CAGradientLayer()
    
    var hue = CGFloat(0)
    var brightness = CGFloat(1)
    var saturation = CGFloat(1)
    
    func addShadeGradient() {
        //let gradient = CAGradientLayer()
        shadeGradient.frame = Shade.bounds
        shadeGradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        shadeGradient.startPoint = CGPoint(x: 0, y: 0)
        shadeGradient.endPoint = CGPoint(x: 0, y: 1.0)
        shadeGradient.cornerRadius = 10
        Shade.layer.addSublayer(shadeGradient)
    }
    
    func addTintGradient(tintColor: UIColor) {
        //let gradient = CAGradientLayer()
        tintGradient.frame = Shade.bounds
        tintGradient.colors = [UIColor.white.cgColor, tintColor.cgColor]
        tintGradient.startPoint = CGPoint(x: 0, y: 1.0)
        tintGradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        tintGradient.cornerRadius = 10
        Shade.layer.addSublayer(tintGradient)
    }
    
    func addColorScaleGradient() {
        //let hueGradient = CAGradientLayer()
        hueGradient.frame = colorScale.bounds
        let red = UIColor.init(red: 1, green: 0, blue: 0,alpha: 1).cgColor
        let pink = UIColor.init(red: 1, green: 0, blue: 1,alpha: 1).cgColor
        let blue = UIColor.init(red: 0, green: 0, blue: 1,alpha: 1).cgColor
        let cyan = UIColor.init(red: 0, green: 1, blue: 1,alpha: 1).cgColor
        let green = UIColor.init(red: 0, green: 1, blue: 0,alpha: 1).cgColor
        let yellow = UIColor.init(red: 1,green: 1, blue: 0,alpha: 1).cgColor
        hueGradient.colors = [red,pink,blue,cyan,green,yellow,red]
        hueGradient.startPoint = CGPoint(x: 0, y: 0)
        hueGradient.endPoint = CGPoint(x: 0, y: 1.0)
        hueGradient.cornerRadius = 10
        colorScale.layer.addSublayer(hueGradient)
    }
    
    func addPanGesture() {
        let colorRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleColorPan))
        self.colorScale.addGestureRecognizer(colorRecognizer)
        
        let shadeRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleShadePan))
        self.Shade.addGestureRecognizer(shadeRecognizer)
    }
    
    @objc func handleColorPan(_ sender: UIPanGestureRecognizer) {

        switch sender.state {
        case .changed:
            let point = sender.location(in: contentView)
            moveColorScale(y: point.y)
            updateColorScale(y: point.y)
        case .ended:
            passSegue()
        default: break
            //print("handleColorPan")
        }
    }
    
    func moveColorScale(y: CGFloat)
    {
        if y >= (colorScale.frame.minY-8) && y <= (colorScale.frame.maxY-8) {
            arrowIcon.frame = CGRect(x: 338, y: y, width: 15, height: 15)
        }
        
    }
    
    func updateColorScale(y: CGFloat)
    {
        if y >= (colorScale.frame.minY) && y <= (colorScale.frame.maxY) {
            let holdHue = (y - colorScale.frame.minY) / 300
            hue = abs(holdHue-1)
            let color = UIColor.init(hue: hue, saturation: 1, brightness: 1, alpha: 1)
            updateTintGradient(tintColor: color)
            let updateColor = UIColor.init(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
            hex.textColor = updateColor
            hex.text = updateColor.toHexString()
        }
    }
    
    func updateTintGradient(tintColor: UIColor) {
        tintGradient.colors = [UIColor.white.cgColor, tintColor.cgColor]
    }
    
    @objc func handleShadePan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            let point = sender.location(in: contentView)
            moveShadeIcon(x: point.x, y: point.y)
            updateHSL(x: point.x, y: point.y)
        case .ended:
            passSegue()
        default: break
            //print("handleShadePan")
        }
    }
    
    func moveShadeIcon(x: CGFloat, y: CGFloat) {
        if y >= (Shade.frame.minY-11) && y <= (Shade.frame.maxY-11) && x >= (Shade.frame.minX-11) && x <= (Shade.frame.maxX-11) {
            shadeIcon.frame = CGRect(x: x, y: y, width: 22, height: 22)
        }
    }
    
    func updateHSL(x: CGFloat, y: CGFloat){
        if y >= (Shade.frame.minY) && y <= (Shade.frame.maxY) && x >= (Shade.frame.minX) && x <= (Shade.frame.maxX) {
            saturation = (x - Shade.frame.minX) / Shade.frame.width
            let holdBrightness = (y - Shade.frame.minY) / Shade.frame.height
            brightness = abs(holdBrightness-1)
            let color = UIColor.init(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
            hex.textColor = color
            hex.text = color.toHexString()
        }
    }
    
    func returnInput() -> [String:Any] {
        let holdInput: [String:Any] = ["index":2,"color":hex?.text ?? "#ff0000"]
        return holdInput
    }
     
    func passSegue() {
        NotificationCenter.default.post(name: .addFolderDetails, object: nil,userInfo: returnInput())
    }
    
}
//000000
//ffffff
