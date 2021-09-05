//
//  ViewController.swift
//  TodoeyApp
//
//  Created by Jasur Salimov on 8/30/21.
//

import UIKit
import RealmSwift

class TodolistViewController: UITableViewController {
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
//        self.searchBarOutlet.delegate = self
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//        loadItems(with: request)
    }
    
  
}
    
    
    //MARK: - TableView datasource methods
extension TodolistViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        
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
        let item = todoItems?[indexPath.row]
        do{
            try! realm.write {
                if (item?.done == true){
                    item?.done = false
                }
                else{
                    item?.done = true
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
//    func deleteItem(index: Int){
//        context.delete(todoItems[index])
//        itemArray.remove(at: index)
//        saveItems()
//
//    }
   
//}
//MARK: - SearchBar methods
//Splitting up for searchbar method declarations
//extension TodolistViewController: UISearchBarDelegate{
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.predicate = predicate
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        loadItems(with: request,with: predicate)
//        tableView.reloadData()
//    }
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0{
//            loadItems()
//            DispatchQueue.main.async {
//            searchBar.resignFirstResponder()
//            }
//
//
//        }
//    }
//
//}
 
