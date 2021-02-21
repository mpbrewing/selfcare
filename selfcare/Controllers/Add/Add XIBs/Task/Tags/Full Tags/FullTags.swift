//
//  FullTags.swift
//  selfcare
//
//  Created by Michael Brewington on 1/14/21.
//

import Foundation
import UIKit

class FullTags: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var TitleIndicator: UIView!
    @IBOutlet weak var ColorIndicator: UIView!
    @IBOutlet weak var ColorLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func saveButtonAction(_ sender: Any) {
        createTag()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func TitleEditingChanged(_ sender: Any) {
        if titleTextField.text!.count > 0 {
            TitleIndicator.layer.backgroundColor = colors[selected].cgColor
        } else {
            TitleIndicator.layer.backgroundColor = UIColor.gainsboro.cgColor
        }
    }
    
    var selected = 0
    var selectedArray = [Bool]()
    var colors = [UIColor]()
    var tag = [Tag]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "TagsView")
        setupNavigationBar()
        setupStyle()
        setupCollectionView()
        hideKeyboardWhenTappedAround()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Tags"
    }
    
    func setupStyle(){
        titleTextField.attributedPlaceholder = NSAttributedString(string: "Enter title",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        //
        view.layer.cornerRadius = 40
        view.layer.borderWidth = 8
        //view.layer.borderColor = UIColor.hippiePink.cgColor
        //
        saveButton.layer.cornerRadius = 20
        //saveButton.layer.backgroundColor = UIColor.hippiePink.cgColor
        //
        TitleIndicator.layer.cornerRadius = 6
        TitleIndicator.layer.backgroundColor = UIColor.gainsboro.cgColor
        //
        ColorIndicator.layer.cornerRadius = 6
        ColorIndicator.layer.backgroundColor = UIColor.gainsboro.cgColor
        //
        //ColorLabel.textColor = UIColor.gainsboro
        //
        colors = [UIColor.gainsboro,UIColor.brown,UIColor.black,UIColor.systemRed,UIColor.yourPink,UIColor.systemPurple,UIColor.systemBlue,UIColor.systemTeal,UIColor.systemGreen,UIColor.conifer,UIColor.systemYellow,UIColor.systemOrange]
        //colors = [UIColor.gainsboro,UIColor.brown,UIColor.black,UIColor.systemRed,UIColor.systemOrange,UIColor.systemYellow,UIColor.conifer,UIColor.systemGreen,UIColor.systemTeal,UIColor.systemBlue,UIColor.systemPurple,UIColor.yourPink]
        selectedArray = Array(repeating: false, count: colors.count)
        selectedArray[selected] = true
        //
        updateColors()
    }
    
}
//CollectionView
extension FullTags {
    
    func setupCollectionView(){
        self.colorCollectionView.register(UINib(nibName: "MiniTagsCell", bundle:nil), forCellWithReuseIdentifier: "miniTags")
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "miniTags", for: indexPath as IndexPath) as! MiniTags
        cell.setupColor(input: colors[indexPath.row], check: selectedArray[indexPath.row], index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedArray[indexPath.row] == true {
            
        } else {
            selectedArray = Array(repeating: false, count: colors.count)
            selectedArray[indexPath.row] = true
            selected = indexPath.row
            updateColors()
            colorCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 130)
   }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func updateColors(){
        view.layer.borderColor = colors[selected].cgColor
        saveButton.layer.backgroundColor = colors[selected].cgColor
        ColorIndicator.layer.backgroundColor = colors[selected].cgColor
        ColorLabel.textColor = colors[selected]
        if titleTextField.text!.count > 0 {
            TitleIndicator.layer.backgroundColor = colors[selected].cgColor
        } else {
            TitleIndicator.layer.backgroundColor = UIColor.gainsboro.cgColor
        }
    }
    
}

//Handle and Pass Tags
extension FullTags {
    
    func passTag()
    {
        //Pass Index and Tag
        //let title = titleTextField.text!
        //let notif = ["selection":selected,"title":title] as [String : Any]
        let notif = ["index":6,"input":0,"tag":tag[0]] as [String : Any]
        NotificationCenter.default.post(name: .addTaskDetails, object: nil,userInfo: notif)
    }
    
    func createTag(){
        let title = titleTextField.text!
        tag.append(Tag(id: "", color: selected, title: title))
        let item = tag[0].toAnyObject() as! [String:Any]
        uploadTag(tag: item, completion: { item in
            print("\(item)")
            self.passTag()
        })
    }
    
}
