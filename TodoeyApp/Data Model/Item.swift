//
//  Item.swift
//  TodoeyApp
//
//  Created by Jasur Salimov on 8/31/21.
//

import Foundation

class Item: Encodable{
    var title: String = ""
    var done: String = ""
    init(title: String){
        self.title = title
    }
    
}
