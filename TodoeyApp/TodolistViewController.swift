//
//  ViewController.swift
//  TodoeyApp
//
//  Created by Jasur Salimov on 8/30/21.
//

import UIKit

class TodolistViewController: UITableViewController {
    @IBOutlet weak var customLabel: UILabel!
    
    let customData = ["Cell 1", "Cell 2", "Cell 3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    
    }

    

}

