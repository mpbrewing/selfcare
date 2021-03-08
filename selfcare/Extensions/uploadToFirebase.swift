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
    
    func uploadEventToFirestore(db: Firestore,event: [String:Any]) {
        var ref: DocumentReference? = nil
        let userId = Auth.auth().currentUser?.uid
        ref = db.collection("users").document("\(userId!)").collection("events").addDocument(data: event) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                //Return
            }
        }
    }
    
    func uploadEvents(events:[Event],completion: @escaping ([String]) -> Void){
        let db = Firestore.firestore()
        let batch = db.batch()
        var ref: DocumentReference? = nil
        let userId = Auth.auth().currentUser?.uid
        var taskEvents = [String]()
        for event in events {
            let holdEvent = event.toAnyObject() as! [String:Any]
            ref = db.collection("users").document("\(userId!)").collection("events").document()
            taskEvents.append(ref!.documentID)
            batch.setData(holdEvent, forDocument: ref!)
        }
        batch.commit() { err in
            if let err = err {
                print("Error writing batch \(err)")
                completion(taskEvents)
            } else {
                print("Batch write succeeded.")
                completion(taskEvents)
            }
        }
    }
    
    func uploadItem(item: [String:Any],completion: @escaping (String) -> Void){
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        let userId = Auth.auth().currentUser?.uid
        ref = db.collection("users").document("\(userId!)").collection("posts").addDocument(data: item) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion("")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                completion(ref!.documentID)
                //Return
            }
        }
    }
    //ref = db.collection("users").document("\(userId!)").collection("posts").document("general").setData(<#T##documentData: [String : Any]##[String : Any]#>, completion: <#T##((Error?) -> Void)?##((Error?) -> Void)?##(Error?) -> Void#>)
    func uploadGeneral(completion: @escaping (String) -> Void){
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser?.uid
        let folder = Folder(title: "General", emoji: "🖤", photoURL: "(No url)", color: "#ff0000")
        let holdItem = Item(id: "general", index: 0, path: [], details: [:])
        holdItem.setDetails(details: folder.toAnyObject() as! [String : Any])
        let item = holdItem.toAnyObject() as! [String : Any]
        db.collection("users").document("\(userId!)").collection("posts").document("general").setData(item){ err in
            if let err = err {
                print("Error writing document: \(err)")
                completion("fail")
            } else {
                print("Document successfully written!")
                completion("pass")
            }
        }
    }
    
    func uploadTag(tag: [String:Any],completion: @escaping (String) -> Void){
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        let userId = Auth.auth().currentUser?.uid
        ref = db.collection("users").document("\(userId!)").collection("tags").addDocument(data: tag) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion("")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                completion(ref!.documentID)
                //Return
            }
        }
    }
    
    //If user has existing color saved with the same title do not upload
    //Remove whitespace from end of all titles
    
    func uploadItemToStorage2(image: UIImage?,completion: @escaping (String) -> Void){
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
                    //self.storageToFirebase(db: db, photoURL: photoURL, item: item, folder: folder)
                    completion(photoURL)
                }
        )}
    )}
    
    
    
}
