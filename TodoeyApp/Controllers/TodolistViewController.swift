//
//  ViewController.swift
//  TodoeyApp
//
//  Created by Jasur Salimov on 8/30/21.
//

import UIKit

class TodolistViewController: UITableViewController {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    var itemArray = [Item]()
    override func viewDidLoad() {
        super.viewDidLoad()
     loadItems()
        
       
    }
    
    
    //MARK: - TableView datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        if(itemArray[indexPath.row].done == "true"){
            cell.textLabel?.text = itemArray[indexPath.row].title
            cell.accessoryType = .checkmark
        }
        else{
            cell.textLabel?.text = itemArray[indexPath.row].title
            cell.accessoryType = .none
        }
        
        return cell
    }
   
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        if(tableView.cellForRow(at: indexPath)?.accessoryType != .checkmark){
            itemArray[indexPath.row].done = "true"
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            itemArray[indexPath.row].done = "false"
        }
        saveItems()
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
            self.itemArray.append(Item(title: addTextField.text!))
            
            self.tableView.reloadData()
            print(self.itemArray.last?.title ?? "")
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode( itemArray)
            try data.write(to: dataFilePath!)
        }
        catch{
            print(error)
        }
}
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data )
            } catch {
                print(error)
            }
        }
        
        
    }
}


 
