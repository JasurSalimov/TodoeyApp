//
//  CategoryViewController.swift
//  TodoeyApp
//
//  Created by Jasur Salimov on 9/3/21.
//

import Foundation
import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    let realm = try! Realm()
    var categories: Results<Category>!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
            
        }
  
}
//MARK: - TableView Delegate methods
extension CategoryViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SegueToList", sender: self )
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodolistViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
}



//MARK: - Add button pressed
extension CategoryViewController{
    
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        var addTextField = UITextField()
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Write new category .."
            addTextField = textField
        }
        
        let action = UIAlertAction(title: "Add category", style: .default) { action in
            let newCategory = Category()
            newCategory.name = addTextField.text!
            self.saveCategories(with: newCategory)
            self.tableView.reloadData()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
        
    }
    
}




//MARK: - Data Source for tableview
extension CategoryViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Cattegories added here"
        return cell
    }
    
    
}

//MARK: - Core Data actions
extension CategoryViewController{
    func loadCategories(){
        self.categories = realm.objects(Category.self)
        tableView.reloadData()
    }
   
    
    func saveCategories(with category: Category){
        do{
            try realm.write{
                realm.add(category)
            }
            
        }
        catch{
            print(error)
        }
    }
    
}
