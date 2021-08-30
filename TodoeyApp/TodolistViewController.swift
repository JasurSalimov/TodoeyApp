//
//  ViewController.swift
//  TodoeyApp
//
//  Created by Jasur Salimov on 8/30/21.
//

import UIKit

class TodolistViewController: UITableViewController {
    
    var customData: [String] = []
    let defaults = UserDefaults.standard
    var boolArray: [Bool] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        customData = defaults.stringArray(forKey: "ArrayOfItems") ?? [""]
        print(defaults.stringArray(forKey: "ArrayOfItems")!)
    }
    
    
    //MARK: - TableView datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        customData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        cell.textLabel?.text = customData[indexPath.row]
        return cell
    }
   
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(customData[indexPath.row])
        
        if(tableView.cellForRow(at: indexPath)?.accessoryType != .checkmark){
            boolArray[indexPath.row] = true
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            boolArray[indexPath.row] = false
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    
    }

    //MARK: - Bar item
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        var addTextField = UITextField()
        let alert = UIAlertController(title: "Add new Todolist item", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Write new item to the list"
            addTextField = textField
        }
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            print(addTextField.text ?? "" )
            self.customData.append(addTextField.text ?? "")
            self.defaults.set(self.customData, forKey: "ArrayOfItems")
            self.tableView.reloadData()
            print(self.customData)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
   
}

