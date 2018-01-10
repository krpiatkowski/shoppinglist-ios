//
//  MockDatasource.swift
//  shoplist
//
//  Created by Krzysztof Piatkowski on 09/01/2018.
//  Copyright © 2018 Krzysztof Piatkowski. All rights reserved.
//

import Foundation

class MockDatasource {
    var items = ["test1", "test2", "test3"].map{
        ShoppingItem(name: $0)
    }
    
    func getItems(completion: ([ShoppingItem]) -> Void) {
        completion(self.items)
    }
    
    func deleteItem(item:ShoppingItem, completion: (Bool) -> Void) {
        let index = self.items.index(where: {$0.name == item.name})
        if let index = index {
            items.remove(at: index)
            completion(true)
        } else {
            completion(false)
        }
    }
}
