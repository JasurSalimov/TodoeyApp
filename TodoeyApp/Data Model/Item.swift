//
//  Item.swift
//  TodoeyApp
//
//  Created by Jasur Salimov on 9/4/21.
//

import Foundation
import RealmSwift

class Item: Object{
   @objc dynamic var title: String = ""
   @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
