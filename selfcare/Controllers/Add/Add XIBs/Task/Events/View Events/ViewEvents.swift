//
//  ViewEvents.swift
//  selfcare
//
//  Created by Michael Brewington on 2/24/21.
//

import Foundation
import UIKit

class ViewEvents: UIViewController,UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
    
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadXIB(name: "ViewEventsView")
        setupNavigationBar()
        setupStyle()
        setupTableView()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Events"
        navigationController?.navigationBar.standardAppearance.backgroundColor = .clear
        navigationController?.navigationBar.standardAppearance.backgroundEffect = .none
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setupStyle(){
        view.layer.cornerRadius = 40
        view.layer.borderWidth = 8
        //view.layer.borderColor = UIColor.systemTeal.cgColor
        view.layer.borderColor = UIColor.appleBlue.cgColor
    }
    
}

extension ViewEvents {
    
    func setupTableView()
    {
        // Select Tags
        tableView.register(UINib(nibName: "MiniViewEvents", bundle: nil), forCellReuseIdentifier: "miniViewEvent")
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
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "miniViewEvent", for: indexPath as IndexPath) as! ViewEventsCell
        if events.count > 0 {
            cell.event = events[indexPath.row]
            cell.updateLabels()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 112
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //SegueToEvents()
    }
    
    func SegueToEvents(){
        modifyBackButton()
        let events = FullEvents()
        events.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(events, animated: true)
    }
    
    func modifyBackButton(){
        navigationController?.navigationBar.standardAppearance.setBackIndicatorImage(#imageLiteral(resourceName: "back2"), transitionMaskImage: #imageLiteral(resourceName: "back2"))
    }
    
    
}


