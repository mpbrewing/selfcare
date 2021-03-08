//
//  FullGUI.swift
//  selfcare
//
//  Created by Michael Brewington on 3/5/21.
//

import Foundation
import UIKit

class FullGUI: UIViewController {
    
    var item = Item(id: "", index: 0, path: [], details: [:])
    
    var favorited = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "FullGUIView")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.standardAppearance.setBackIndicatorImage(#imageLiteral(resourceName: "backIcon"), transitionMaskImage: #imageLiteral(resourceName: "backIcon"))
    }
    
}

extension FullGUI {
    
    func setupNavigationBar() {
        //
        let details = item.details
        //let emoji = details["emoji"] as? String ?? "🖤"
        let title = details["title"] as? String ?? "(no title)"
        //
        navigationItem.title = "\(title)"
        //Tint Color
        navigationController?.navigationBar.tintColor = UIColor.black
        //Font
        navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont(name: "Nexa-Bold", size: 22)!]
        //Remove Back Bar Button Text
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //Style Navigation Bar
        navigationController?.navigationBar.standardAppearance.backgroundColor = .clear
        navigationController?.navigationBar.standardAppearance.backgroundEffect = .none
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        //
        updateButtons()
    }
    
    @objc func favoriteAction() {
        favorited = !favorited
        updateButtons()
        //Pass To Firebase
    }
    
    func returnFavorited()->UIImage {
        switch favorited {
        case true:
            let image = #imageLiteral(resourceName: "star_fill")
            return image
        case false:
            let image = #imageLiteral(resourceName: "star")
            return image
        }
    }
    
    func updateButtons(){
        let favoriteButton = UIBarButtonItem(image: returnFavorited(), style: .plain, target: self, action: #selector(favoriteAction))
        let editButton = UIBarButtonItem(image: #imageLiteral(resourceName: "pen"), style: .plain, target: self, action: #selector(editAction))
        let settingsButton = UIBarButtonItem(image: #imageLiteral(resourceName: "threedots"), style: .plain, target: self, action: #selector(settingsAction))
        navigationItem.rightBarButtonItems = [settingsButton,editButton,favoriteButton]
    }
    
    @objc func editAction() {
        //Segue To Edit
    }
    
    @objc func settingsAction() {
        //Open Model
    }
    
    
    
}
