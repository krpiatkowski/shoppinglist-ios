import Foundation

class MockDatasource {
    func getLists(completion:([ShoppingList]) -> Void) {
        completion([
            ShoppingList(id: "1", name:"list1"),
            ShoppingList(id: "2", name:"list2")
        ])
    }
    
    func getItems(list: ShoppingList, completion:([ShoppingItem]) -> Void){
        completion(["test1", "test2", "test3"].map{
            ShoppingItem(id: $0, amount: 1, storeItem: StoreItem(id: $0, name: $0), done: false)
        })
    }
    
    func mark(item: ShoppingItem, done: Bool, completion: (ShoppingItem) -> Void) {
        completion(ShoppingItem(id: item.id, amount: item.amount, storeItem: item.storeItem, done: done))
    }
    
    func deleteItem(item:ShoppingItem, completion: (Bool) -> Void) {
        completion(true)
    }
}
