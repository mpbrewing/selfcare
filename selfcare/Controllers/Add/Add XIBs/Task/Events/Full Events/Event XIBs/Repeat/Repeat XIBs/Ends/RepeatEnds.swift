//
//  RepeatEnds.swift
//  selfcare
//
//  Created by Michael Brewington on 1/26/21.
//

import Foundation
import UIKit

class RepeatEnds: UIViewController {
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        //Pass data
        passEndsSegue()
    }
    
    var state = 0
    var occurrencesView = OccurrencesCell()
    var dateView = OnADateCell()
    var occur = Int()
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "RepeatEndsView")
        switchState()
        setupStyle()
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(setEnds(notification:)), name: .xibToEnds, object: nil)
    }
    
    func setupNavigationBar(title: String){
        navigationItem.title = "\(title)"
    }
    
    func switchState(){
        if state == 1 {
            setupNavigationBar(title: "Ends on a date")
            dateView = OnADateCell(frame: CGRect(x: 0, y: 92, width: 414, height: 634))
            view.addSubview(dateView)
        } else {
            //setupNavigationBar(title: "Ends after #")
            occurrencesView = OccurrencesCell(frame: CGRect(x: 0, y: 92, width: 414, height: 414))
            view.addSubview(occurrencesView)
        }
    }
    
    func setupStyle(){
        view.layer.cornerRadius = 40
        view.layer.borderWidth = 8
        view.layer.borderColor = UIColor.appleRed.cgColor
        saveButton.layer.cornerRadius = 20
        saveButton.layer.backgroundColor = UIColor.appleRed.cgColor
    }
    
}

extension RepeatEnds{
    
    //Recieve Data
    @objc func setEnds(notification: NSNotification) {
        if let index = notification.userInfo?["index"] as? Int {
            if index == 1 {
                //default date
                date = notification.userInfo?["date"] as? Date ?? Date()
            } else {
                occur = notification.userInfo?["occur"] as? Int ?? 1
            }
        }
    }
    
    //Pass Data
    func passEndsSegue()
    {
        let passState = ["index":state,"date":date,"occur":occur] as [String : Any]
        NotificationCenter.default.post(name: .endsToSelection, object: nil,userInfo: passState)
    }
    
}
