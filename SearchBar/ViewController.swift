//
//  ViewController.swift
//  SearchBar
//
//  Created by Apple MacBook Pro  on 2/4/20.
//  Copyright © 2020 Apple MacBook Pro . All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var searchArr = ["Top news", "A to Z", "Play News", "Home", "City", "Man", "Weman","Top news", "A to Z", "Play News", "Home", "City", "Man", "Weman","Top news", "A to Z", "Play News", "Home", "City", "Man", "Weman"]
    
    @IBOutlet weak var searchTAble: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searching = false
    var mysearch = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchEdit()
         
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound]){
            (grantp, error) in
        }
       
        let content = UNMutableNotificationContent()
        content.title = "Hey, I am the boss!"
        content.body = "Go To Hell"
        
        let date = Date().addingTimeInterval(5)
        
        let dateComponemts = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponemts, repeats: false)
        
        let uuidString = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        center.add(request) {(error) in
            
        }
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return mysearch.count
        } else{
            return searchArr.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "search")
        
        if searching{
            cell?.textLabel?.text = mysearch[indexPath.row]
        } else{
            cell?.textLabel?.text = searchArr[indexPath.row]
        }
        return cell!
        
    }
    
    
    func searchEdit() {
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.searchTextField.layer.borderColor = UIColor.black.cgColor
        searchBar.searchTextField.layer.cornerRadius = 10
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
    }

}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        mysearch = searchArr.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        
        searching = true
        searchTAble.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        searchTAble.reloadData()
    }
}


