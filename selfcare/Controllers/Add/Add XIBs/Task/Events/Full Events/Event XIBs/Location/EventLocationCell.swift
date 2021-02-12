//
//  EventLocationCell.swift
//  selfcare
//
//  Created by Michael Brewington on 1/15/21.
//

import Foundation
import UIKit
import MapKit

class EventLocationCell: UICollectionViewCell, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource,MKLocalSearchCompleterDelegate {
    
    @IBOutlet weak var textBox: UIView!
    @IBOutlet weak var tabLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        toggleStyle(state: false)
        tabLabel.text = "Add location"
        //updateDefaultString()
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    var locations = [LocationClass]()
    var searchResults = [MKLocalSearchCompletion]()
    //create a completer
    lazy var searchCompleter: MKLocalSearchCompleter = {
        let sC = MKLocalSearchCompleter()
    sC.delegate = (self as MKLocalSearchCompleterDelegate)
        return sC
    }()
    var searchSource: [String]?
    var searchArray: [String]?
    var eventLocation = [String]()
    var title = String()
    var subtitle = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
        setupSearch()
        tabLabel.text = "Add location"
        setupTableView()
    }
    
    func setupStyle(){
        textBox.layer.cornerRadius = 8
        cancelButton.layer.cornerRadius = 8
        textBox.layer.backgroundColor = UIColor.lightGains.cgColor
        cancelButton.backgroundColor = UIColor.gainsboro
        let cancelButtonImage = #imageLiteral(resourceName: "cancel")
        cancelButton.setImage(cancelButtonImage.withTintColor(.darkGray, renderingMode: .alwaysOriginal), for: .normal)
        toggleStyle(state: false)
       //updateDefaultString()
    }
    
    func setupSearch(){
        searchbar.searchTextField.backgroundColor = UIColor.white
        searchbar.searchTextField.leftView?.tintColor = .darkGray
        searchbar.sizeToFit()
        searchbar.returnKeyType = .done
        searchbar.backgroundImage = UIImage()
        searchbar.searchTextField.textColor = UIColor.darkGray
        searchbar.searchTextField.font = UIFont(name: "Nexa-Normal", size: 12)
        searchbar.delegate = self
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "LocationCell", bundle: nil), forCellReuseIdentifier: "locationCell")
    }
    
    func toggleStyle(state: Bool){
        switch state {
        case true:
            tabLabel.frame = CGRect(x: 20, y: 6, width: 328, height: 46)
            cancelButton.isHidden = false
            textBox.isHidden = false
            tabLabel.textColor = UIColor.darkGray
        case false:
            tabLabel.frame = CGRect(x: 12, y: 6, width: 390, height: 46)
            cancelButton.isHidden = true
            textBox.isHidden = true
            tabLabel.textColor = UIColor.gainsboro
        }
        updateEventLocation(state: state)
    }
    
}

extension EventLocationCell {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationCellClass
        let searchResult = searchResults[indexPath.row]
        //print(searchResult)
        cell.label.text = self.searchSource?[indexPath.row]
        cell.location.text = searchResult.subtitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationCellClass
        let searchResult = searchResults[indexPath.row]
        tabLabel.text = self.searchSource?[indexPath.row]
        //
        title = searchResult.title
        subtitle = searchResult.subtitle
        //
        searchbar.text = ""
        searchResults.removeAll()
        searchSource?.removeAll()
        tableView.reloadData()
        toggleStyle(state: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = .clear
    }
    
}

extension EventLocationCell {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            self.tableView.reloadData()
            //Segue and Pass Location Text Input
        }
            return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print(searchText)
        //change searchCompleter depends on searchBar's text
        if !searchText.isEmpty {
            searchCompleter.queryFragment = searchText
        } else {
            searchResults.removeAll()
            searchSource?.removeAll()
            tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        tabLabel.text = searchbar.text
        //
        title = searchbar.text!
        subtitle = String()
        //
        toggleStyle(state: true)
        searchbar.text = ""
        searchResults.removeAll()
        searchSource?.removeAll()
        tableView.reloadData()
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        //get result, transform it to our needs and fill our dataSource
        searchResults = completer.results
        self.searchSource = completer.results.map { $0.title }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        //handle the error
        print(error.localizedDescription)
    }
    
}

//Handle and Pass Event Location
extension EventLocationCell {
    
    //Determine full address and remove general searches (search nearby, here)
    func updateEventLocation(state: Bool){
        if state == true {
            eventLocation = [title,subtitle]
        } else {
            eventLocation = [String]()
        }
        passEventLocation()
    }
    
    func passEventLocation(){
        let notif = ["index":4,"location":eventLocation] as [String : Any]
        NotificationCenter.default.post(name: .addEventXib, object: nil,userInfo: notif)
    }
    
}
