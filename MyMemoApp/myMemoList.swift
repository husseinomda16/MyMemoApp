//
//  ViewController.swift
//  MyMemoApp
//
//  Created by Husseinomda16 on 11/1/19.
//  Copyright © 2019 Hmo. All rights reserved.
//

import UIKit

class myMemoList: UITableViewController {

    //Declare instance
    var defaults = UserDefaults()
    
    var arrayData = ["eat","drink","meet"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items = defaults.array(forKey: "memoArray") as? [String]{
            arrayData = items
        }
    }

    //MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoItem")
        cell?.textLabel?.text = arrayData[indexPath.row]
        return cell!
    }
    
    //MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK:- add New Item To My Memo List
    
    //TODO: add Item Button
    @IBAction func addBtnPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "add new memo", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
            self.arrayData.append(textField.text!)
            self.defaults.set(self.arrayData , forKey : "memoArray")
            self.tableView.reloadData()
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter Memo Name"
            textField = alertTextField
            
        }
        present(alert, animated: true, completion: nil)
    }
    
}

