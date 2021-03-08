//
//  AddFolderViewController.swift
//  selfcare
//
//  Created by Michael Brewington on 12/3/20.
//

import Foundation
import UIKit
import Firebase
//UITableViewDelegate, UITableViewDataSource
class AddFolderViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "AddFolderView")
        setupTableView()
        hideKeyboardWhenTappedAround()
    
         NotificationCenter.default.addObserver(self, selector: #selector(setFolderDetails(notification:)), name: .addFolderDetails, object: nil)
        folder.append(Folder(title: "(No title)", emoji: "🖤", photoURL: "(No url)", color: "#ff0000"))
        item.append(Item(id: "", index: 0, path: [], details: [:]))
    }
    var folder = [Folder]()
    var item = [Item]()
    var folderPhoto: UIImage?
    let db = Firestore.firestore()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        modifyAddNavBar()
        setupNavigationBar()
    }
    
    let cellTitleIdentifier = "addTitle"
    let cellMenuIdentifier = "addMenu"
    
}

//Notification Bar
extension AddFolderViewController {
    func setupNavigationBar() {
        navigationItem.title = "Folder"
        let btn1 = UIButton(type: .custom)
        btn1.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        btn1.titleLabel?.font =  UIFont(name: "Nexa-Normal", size: 10)
        let attributedTitle = NSAttributedString(string: "Save", attributes: [.foregroundColor: UIColor.white, .font: UIFont(name: "Nexa-Bold", size: 14)!])
        btn1.setAttributedTitle(attributedTitle, for: .normal)
        btn1.layer.cornerRadius = 8
        btn1.backgroundColor = UIColor.systemGreen
        btn1.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        let saveButton = UIBarButtonItem(customView: btn1)
        navigationItem.rightBarButtonItem = saveButton
        navigationController?.navigationBar.standardAppearance.backgroundColor = .clear
        navigationController?.navigationBar.standardAppearance.backgroundEffect = .none
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
     @objc func saveButtonAction() {
        print("AddFolderViewController: SaveButtonAction")
        //navigationController?.popViewController(animated: true)
        let vc = navigationController!.viewControllers[0] as! HomeViewController
        //uploadImageToStorage(image: folderPhoto, db: db, item: item, folder: folder)
        uploadItemToStorage2(image: folderPhoto, completion: { [self] photoURL in
            //print(item)
            self.folder[0].setPhotoURL(url: photoURL)
            self.item[0].setDetails(details: self.folder[0].toAnyObject() as! [String : Any])
            self.uploadItem(item: item[0].toAnyObject() as! [String : Any], completion: { saveItem in
                vc.swipeClassView.holdFilePath = item[0].path
                vc.swipeClassView.holdID = saveItem
                vc.swipeClassView.reloadFolder()
                //print("task: false")
            })
        })
        //print("task: true")
        //loading screen
        //vc.swipeClassView.toggleGif(toggle: true)
        //self.navigationController?.popToViewController(vc, animated: true)
        navigationController?.popViewController(animated: true)
     }
}

//Table View
extension AddFolderViewController {

     func setupTableView() {
         // Title
         tableView.register(UINib(nibName: "AddTitleView", bundle: nil), forCellReuseIdentifier: cellTitleIdentifier)
         // Menu
         tableView.register(UINib(nibName: "AddMenuView", bundle: nil), forCellReuseIdentifier: cellMenuIdentifier)
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellTitleIdentifier, for: indexPath) as! AddTitleCell
            cell.state = 0
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellMenuIdentifier, for: indexPath) as! AddMenuCell
            cell.addState = 0
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellTitleIdentifier, for: indexPath) as! AddTitleCell
            return cell
        }
    }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         switch indexPath.row {
         case 0:
             return 60
         case 1:
             return 743
         default:
             return 50
         }
     }
    
    
}

//Save
extension AddFolderViewController {
    @objc func setFolderDetails(notification: NSNotification) {
        if let segueDetails = notification.userInfo?["index"] as? Int {
            switch segueDetails {
            case 0:
                setFolderTitle(info: notification.userInfo!)
            case 1:
                setFolderPhoto(info: notification.userInfo!)
            case 2:
                setFolderColor(info: notification.userInfo!)
            default:
                print("setFolderDetails: default")
            }
        }
    }
    
    func setFolderTitle(info: [AnyHashable: Any]){
        let title = info["title"] as! String
        let emoji = info["emoji"] as! String
        folder[0].setTitle(title: title, emoji: emoji)
    }
    
    func setFolderPhoto(info: [AnyHashable: Any]){
        let photo =  info["photo"] as! UIImage
        folderPhoto = photo
    }
    
    func setFolderColor(info: [AnyHashable: Any]){
        let color = info["color"] as! String
        folder[0].setColor(color: color)
    }
    
}
