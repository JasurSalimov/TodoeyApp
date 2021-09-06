//
//  SwipeTableViewController.swift
//  TodoeyApp
//
//  Created by Jasur Salimov on 9/6/21.
//

import Foundation
import SwipeCellKit


class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate{
    
    override func viewDidLoad(){
        super.viewDidLoad()
        tableView.rowHeight = 80.0
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
          let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
              // handle action by updating model with deletion
          // customize the action appearance
            self.updateModel(at: indexPath)
          }
          deleteAction.image = UIImage(named: "delete")
            print("DeleteCell")
            
          return [deleteAction]
        
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
            cell.delegate = self
                 return cell
        }

   func updateModel(at indexPath: IndexPath){
        //Update the model
    }
    
    
    
}
