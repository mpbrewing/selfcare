//
//  AddPhotoCell.swift
//  selfcare
//
//  Created by Michael Brewington on 12/8/20.
//

import Foundation
import UIKit

class AddPhotoCell: UITableViewCell,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var photoIcon: UIImageView!
    @IBOutlet weak var photoButton: UIButton!
    
    var currentImageView: UIImageView?
    let imagePicker = UIImagePickerController()
    
    func imagePickerController(_ picker: UIImagePickerController,
                                 didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let PickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //UIImagePickerController.InfoKey.editedImage
        self.currentImageView?.image = PickedImage
        self.currentImageView?.clipsToBounds = true
            }
        passSegue()
        let vc = findViewController()
        vc?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        let vc = findViewController()
        vc?.dismiss(animated: true, completion: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupXIB()
    }
    
    func setupXIB() {
        cellImage.layer.cornerRadius = 10
        cellImage.layer.backgroundColor = UIColor.gainsboro.cgColor
        photoIcon.image = photoIcon.image?.withRenderingMode(.alwaysTemplate)
        photoIcon.tintColor = UIColor.gainsboro
        var buttonImage = #imageLiteral(resourceName: "addPhotoButtonIcon")
        buttonImage = buttonImage.withRenderingMode(.alwaysTemplate)
        buttonImage = buttonImage.withTintColor(UIColor.white)
        photoButton.setImage(buttonImage, for: .normal)
        imagePicker.delegate = self
    }
    
    @IBAction func photoButtonAction(_ sender: Any) {
        self.currentImageView = self.cellImage
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        let vc = findViewController()
        vc?.present(imagePicker, animated: true, completion: nil)
    }
    
    
    func returnInput() -> [String:Any] {
        let holdInput: [String:Any] = ["index":1,"photo":currentImageView?.image ?? UIImage()]
        return holdInput
    }
     
    func passSegue() {
        NotificationCenter.default.post(name: .addFolderDetails, object: nil,userInfo: returnInput())
    }
     
    
}

//Add Clear Photo Button?
