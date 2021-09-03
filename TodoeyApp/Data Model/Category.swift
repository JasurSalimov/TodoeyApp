//
//  Category.swift
//  TodoeyApp
//
//  Created by Jasur Salimov on 9/4/21.
//

import Foundation
import RealmSwift

class Category: Object{
   @objc dynamic var name: String = ""
    let items = List<Item>() // declaring an array of Item objects
}
