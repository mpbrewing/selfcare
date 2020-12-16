//
//  uploadToFirebase.swift
//  selfcare
//
//  Created by Michael Brewington on 12/16/20.
//

import Foundation
import Firebase

extension UIViewController {

    func uploadImageToStorage(image: UIImage?,db: Firestore, item: [Item], folder: [Folder]) {
        var photoURL: String = "(No url)"
        let uuid = UUID().uuidString
        let userId = Auth.auth().currentUser?.uid
        let imageRef = Storage.storage().reference().child("gs:/profiles/\(userId!)_\(uuid).jpg")
        guard let imageData = image!.jpegData(compressionQuality: 0.1) else {
                  return
                }
        imageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return
                }
                imageRef.downloadURL(completion: { [self] (url, error) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return
                }
                    photoURL = "\(url!)"
                    self.storageToFirebase(db: db, photoURL: photoURL, item: item, folder: folder)
                }
        )}
    )}
    
    func storageToFirebase(db: Firestore,photoURL: String, item: [Item], folder: [Folder]) {
        folder[0].setPhotoURL(url: photoURL)
        item[0].setDetails(details: folder[0].toAnyObject() as! [String : Any])
        uploadItemToFirestore(db: db, item: item[0].toAnyObject() as! [String : Any])
    }
    
    func uploadItemToFirestore(db: Firestore,item: [String:Any]) {
        var ref: DocumentReference? = nil
        let userId = Auth.auth().currentUser?.uid
        ref = db.collection("users").document("\(userId!)").collection("posts").addDocument(data: item) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                //Return 
            }
        }
    }
    
}
