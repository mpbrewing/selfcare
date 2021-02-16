//
//  retrieveFromFirebase.swift
//  selfcare
//
//  Created by Michael Brewington on 1/8/21.
//

import Foundation
import UIKit
import Firebase

extension UIView {
    
    func downloadPosts(db: Firestore,completion: @escaping ([Item]) -> Void) {
        let userId = Auth.auth().currentUser?.uid
        var items = [Item]()
        db.collection("users").document("\(userId!)").collection("posts")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    completion([])
                } else {
                    for document in querySnapshot!.documents {
                        //print("\(document.documentID) => \(document.data())")
                        var holdData = document.data()
                        holdData["id"] = "\(document.documentID)"
                        let newItem = Item(snapshot: holdData)
                        items.append(newItem)
                    }
                    completion(items)
                }
        }
    }
    
    func downloadTags(db: Firestore,completion: @escaping ([Tag]) -> Void) {
        let userId = Auth.auth().currentUser?.uid
        var tags = [Tag]()
        db.collection("users").document("\(userId!)").collection("tags")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    completion([])
                } else {
                    for document in querySnapshot!.documents {
                        //print("\(document.documentID) => \(document.data())")
                        var holdData = document.data()
                        holdData["id"] = "\(document.documentID)"
                        let newTag = Tag(snapshot: holdData)
                        tags.append(newTag)
                    }
                    completion(tags)
                }
        }
    }

}

extension UIViewController{
    
    func downloadTags(db: Firestore,completion: @escaping ([Tag]) -> Void) {
        let userId = Auth.auth().currentUser?.uid
        var tags = [Tag]()
        db.collection("users").document("\(userId!)").collection("tags")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    completion([])
                } else {
                    for document in querySnapshot!.documents {
                        //print("\(document.documentID) => \(document.data())")
                        var holdData = document.data()
                        holdData["id"] = "\(document.documentID)"
                        let newTag = Tag(snapshot: holdData)
                        tags.append(newTag)
                    }
                    completion(tags)
                }
        }
    }
    
}
