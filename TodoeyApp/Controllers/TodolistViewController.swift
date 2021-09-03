//
//  ViewController.swift
//  TodoeyApp
//
//  Created by Jasur Salimov on 8/30/21.
//

import UIKit
import CoreData
class TodolistViewController: UITableViewController {
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedCategory: Category?{
        didSet{
//            loadItems()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.searchBarOutlet.delegate = self
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//        loadItems(with: request)
    }
    
    
    //MARK: - TableView datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        if(itemArray[indexPath.row].done == true){
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
            itemArray[indexPath.row].done = true
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            itemArray[indexPath.row].done = false
        }
//        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    
    }

    //MARK: - Bar item
    
//    @IBAction func addItem(_ sender: UIBarButtonItem) {
//        var addTextField = UITextField()
//        let alert = UIAlertController(title: "Add new Todolist item", message: "", preferredStyle: .alert)
//        alert.addTextField { textField in
//            textField.placeholder = "Write new item to the list"
//            addTextField = textField
//        }
//
//        let action = UIAlertAction(title: "Add Item", style: .default) { action in
//           //Initializing context in order to save data to CoreData
//            //Then initializing the object of the attribute(class) of CoreData
//            //Saving items that user entered
//            let newItem = Item(context: self.context)
//            newItem.title = addTextField.text!
//            newItem.done = false
//            newItem.parentCategory = self.selectedCategory
//            //Reloading data
//            self.itemArray.append(newItem)
//            self.saveItems()
//            self.tableView.reloadData()
//        }
//        alert.addAction(action)
//        present(alert, animated: true, completion: nil)
//    }
    
//    func saveItems(){
//        do{
//            try self.context.save()
//
//        }
//        catch{
//            print(error)
//        }
//}
//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(),with predicate: NSPredicate? = nil){
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//        if let additionalPredicate = predicate{
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates:[categoryPredicate, additionalPredicate])
//        }else{
//            request.predicate = categoryPredicate
//        }
//
//        do{
//        itemArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from core")
//        }
//
//    }
//    func deleteItem(index: Int){
//        context.delete(itemArray[index])
//        itemArray.remove(at: index)
//        saveItems()
//
//    }
   
}
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
 
