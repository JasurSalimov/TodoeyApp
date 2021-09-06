//
//  ViewController.swift
//  TodoeyApp
//
//  Created by Jasur Salimov on 8/30/21.
//
import UIKit
import RealmSwift
import SwipeCellKit

class TodolistViewController: SwipeTableViewController {
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    var todoItems: Results<Item>?
    let realm = try! Realm()
    var selectedCategory: Category?{
        didSet{
            loadItems()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        self.searchBarOutlet.delegate = self
    }
    //Delete Data From Swipe
    override func updateModel(at indexPath: IndexPath){
        if let item = self.todoItems?[indexPath.row]{
        do{
            try! self.realm.write {
                self.realm.delete(item)
            }
        }
        }
    }
}
//MARK: - TableView datasource methods
extension TodolistViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let item = todoItems?[indexPath.row]{
            cell.textLabel?.text = item.title

            if(item.done == true){
                cell.accessoryType = .checkmark
            }
            else{
                cell.accessoryType = .none
            }
        }else{
            cell.textLabel?.text = "No items added"
        }
        return cell
    }
}
//MARK: - TableView Delegate Methods
extension TodolistViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row]{
        do{
            try! realm.write {
                //deleting data from realm
                //realm.delete(item)
                if (item.done == true){
                    item.done = false
                }
                else{
                    item.done = true
                }
            }
        }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
//MARK: - Loading data
extension TodolistViewController{
    func loadItems(){
        self.todoItems = self.selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
        
    }
}
// MARK: - Bar item
extension TodolistViewController{
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        var addTextField = UITextField()
        let alert = UIAlertController(title: "Add new Todolist item", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Write new item to the list"
            addTextField = textField
        }
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write{
                        let newItem = Item()
                        newItem.title = addTextField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                }catch{
                    print("Error saving items: \(error)")
                }
                self.tableView.reloadData()
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
}
// MARK: - SearchBar methods
//Search methods and delegates
extension TodolistViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        // todoItems = todoItems?.filter(Date.self).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
       
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            DispatchQueue.main.async {
            searchBar.resignFirstResponder()
            }
        }
    }

}

