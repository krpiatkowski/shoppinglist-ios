import Foundation

class MockDatasource {
    func getLists(completion:([ShoppingList]) -> Void) {

        var items = [ShoppingList]();
        for i in 1...15 {
            items.append(ShoppingList(id: "\(i)", name:"list\(i)"))
        }

        completion(items)
    }
    
    func getItems(list: ShoppingList, completion:([ShoppingItem]) -> Void){
        var items = [ShoppingItem]();
        for i in 1...15 {
            let id = "\(i)"
            items.append(ShoppingItem(id: id, amount: 1, storeItem: StoreItem(id: "\(i)", name: "\(i)"), done: false))
        }
        completion(items)
    }
    
    func mark(item: ShoppingItem, done: Bool, completion: (ShoppingItem) -> Void) {
        completion(ShoppingItem(id: item.id, amount: item.amount, storeItem: item.storeItem, done: done))
    }
    
    func deleteItem(item:ShoppingItem, completion: (Bool) -> Void) {
        completion(true)
    }
}
