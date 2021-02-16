//
//  SelectTagsTableViewCell.swift
//  selfcare
//
//  Created by Michael Brewington on 2/15/21.
//

import Foundation
import UIKit

class SelectTagsTableViewCell: UITableViewCell,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var pageCollectionView: UICollectionView!
    
    //var state = Int()
    var page = Int()
    var selectedTags = [Tag]()
    //var remainingTags = [Tag]()
    //var tags = [Tag]()
    var tags: [Tag] = [Tag]() {
       didSet {
        //print("SelectTagsTableViewCell: \(tags.count)")
        updateSize()
        tagCollectionView.reloadData()
        pageCollectionView.reloadData()
       }
    }
    var colors = [UIColor]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
        setupCollectionView()
    }
    
    func setupStyle(){
        colors = [UIColor.gainsboro,UIColor.brown,UIColor.black,UIColor.systemRed,UIColor.systemOrange,UIColor.systemYellow,UIColor.conifer,UIColor.systemGreen,UIColor.systemTeal,UIColor.systemBlue,UIColor.systemPurple,UIColor.yourPink]
    }
    
    func updateSize(){
        if tags.count > 3 {
            tagCollectionView.frame = CGRect(x: 0, y: 0, width: 414, height: 100)
            //pageCollectionView.frame = CGRect(x: 0, y: 100, width: 414, height: 30)
        } else {
            tagCollectionView.frame = CGRect(x: 0, y: 0, width: 414, height: 50)
            //pageCollectionView.frame = CGRect(x: 0, y: 50, width: 414, height: 30)
        }
    }
    
}

extension SelectTagsTableViewCell{
    
    func setupCollectionView(){
        self.tagCollectionView.register(UINib(nibName: "SelectMiniCellView", bundle:nil), forCellWithReuseIdentifier: "selectMini")
        self.pageCollectionView.register(UINib(nibName: "TagsPageNumber", bundle:nil), forCellWithReuseIdentifier: "tagsPageNumber")
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tagCollectionView {
            let compare = roundToClosestMultipleNumber(tags.count, 6)
            let difference = compare - tags.count
            return tags.count + difference
        } else if collectionView == pageCollectionView {
            let pages = ceil(tagCollectionView.contentSize.width/tagCollectionView.frame.size.width)
            //print("pages: \(pages)") 
            return Int(pages)
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tagCollectionView {
            return returnMini(collectionView: collectionView, indexPath: indexPath)
        } else if collectionView == pageCollectionView {
            return returnPageNumber(collectionView: collectionView, indexPath: indexPath)
        } else {
            return returnPageNumber(collectionView: collectionView, indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Transfer based on state
        if collectionView == tagCollectionView {
            if indexPath.row <= (tags.count - 1) {
                passTags(tag: tags[indexPath.row], path: indexPath.row)
            }
        } else if collectionView == pageCollectionView {
            //Move to page
            //tagCollectionView.scrollToItem(at: <#T##IndexPath#>, at: <#T##UICollectionView.ScrollPosition#>, animated: <#T##Bool#>)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tagCollectionView {
            return CGSize(width: 138, height: 50)
        } else if collectionView == pageCollectionView {
            //let pages = ceil(self.collectionView.contentSize.width /
                               //self.collectionView.frame.size.width);
            let pages = ceil(tagCollectionView.contentSize.width/tagCollectionView.frame.size.width)
            let width = (tagCollectionView.frame.size.width/pages)
           // print("pages: \(pages) ... width: \(width)")
            return CGSize(width: width, height: 30)
        } else {
            return CGSize(width: 0, height: 0)
        }
   }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == tagCollectionView {
            guard let visible = tagCollectionView.visibleCells.first else { return }
            guard let index = tagCollectionView.indexPath(for: visible)?.row else { return }
            let compare = CGFloat(index / 6)
            page = Int(compare)
            pageCollectionView.reloadData()
        }
    }
    
    func returnMini(collectionView: UICollectionView,indexPath: IndexPath)->UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectMini", for: indexPath as IndexPath) as! SelectMiniCell
        if indexPath.row > (tags.count - 1) {
            cell.blank()
        } else {
            if indexPath.row > (selectedTags.count-1) {
                cell.state = 1 //Remaining
                //print("\(tags[indexPath.row].title) ... \(indexPath.row)...\(1)")
            } else {
                cell.state = 0 //Selected
                //print("\(tags[indexPath.row].title) ... \(indexPath.row)...\(0)")
            }
            let tag = tags[indexPath.row]
            cell.updateCell(input: tag.title, color: colors[tag.color])
        }
        return cell
    }
    
    func returnPageNumber(collectionView: UICollectionView,indexPath: IndexPath)->UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagsPageNumber", for: indexPath as IndexPath) as! TagsPageNumberCell
        let pages = ceil(tagCollectionView.contentSize.width/tagCollectionView.frame.size.width)
        let width = (tagCollectionView.frame.size.width/pages)
        var selected = false
        if page == indexPath.row {
           selected = true
        }
        cell.setupStyle(selected: selected, width: width)
        return cell
    }
    
    func roundToClosestMultipleNumber(_ numberOne: Int, _ numberTwo: Int) -> Int {

        var result: Int = numberOne

        if numberOne % numberTwo != 0 {

            if numberOne < numberTwo {
                result = numberTwo
            } else {
                result = (numberOne / numberTwo + 1) * numberTwo
            }
        }

        return result
    }
    
}

extension SelectTagsTableViewCell {
    
    //Pass Selected Tag To AddTagsCell
    
    func passTags(tag: Tag,path:Int)
    {
        var row = path
        var state = 0
        if path > (selectedTags.count-1) {
            state = 1 //Remaining
            row = path - selectedTags.count
        } else {
            state = 0 //Selected
        }
        //print("\(tag.title) ... path: \(row) ... count: \(selectedTags.count) ... state: \(state)")
        //Pass Index and Tags
        let notif = ["index":state,"tag":tag,"path":row] as [String : Any]
        NotificationCenter.default.post(name: .selectToAddTags, object: nil,userInfo: notif)
    }
    
}
