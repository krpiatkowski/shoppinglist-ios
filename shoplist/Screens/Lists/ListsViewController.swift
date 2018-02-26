import UIKit

class ListsViewController : BaseViewController {
    let datasource = MockDatasource()
    var lists:[ShoppingList]?


    fileprivate var mainView: ListsView {
        return self.view as! ListsView
    }
    
    override func loadView() {
        view = ListsView()
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        
        mainView.tableView.register(UITableViewCell.self)
        mainView.tableView.allowsMultipleSelection = false
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action:#selector(ListsViewController.onAdd))
        navigationItem.rightBarButtonItem = addButton
        
        datasource.getLists { lists in
            self.lists = lists
        }
    }
    
    @objc
    func onAdd(){
        let list = ShoppingList(id: "1", name: "new list")
        navigationController?.pushViewController(ListViewController(list:list), animated: true)
    }
}

extension ListsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(UITableViewCell.self, for: indexPath)
        cell.textLabel?.text = lists?[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
}

extension ListsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let list = lists?[indexPath.row] else {
            return
        }
        let listViewController = ListViewController(list: list)
        navigationController?.pushViewController(listViewController, animated: true)
    }
}

