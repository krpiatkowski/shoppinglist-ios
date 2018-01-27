import UIKit
import PinLayout

class ListViewController : BaseViewController {
    let datasource = MockDatasource()
    let list:ShoppingList
    var items:[ShoppingItem]?
    
    fileprivate var mainView: ListView {
        return self.view as! ListView
    }
    
    init(list:ShoppingList) {
        self.list = list
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ListView()
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        
        mainView.tableView.register(ListCell.self)
        mainView.tableView.allowsMultipleSelection = false
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        datasource.getItems(list:self.list) { (items) in
            self.items = items
        }
    }
    
    func onToggleDone(indexPath: IndexPath, completion:(Bool) -> Void) {
        let item = items?[indexPath.row]
        if let item = item {
            datasource.mark(item: item, done: !item.done) { item in
                let cell = mainView.tableView.cellForRow(at: indexPath) as! ListCell
                items?[indexPath.row] = item
                cell.item = item
                completion(true)
            }
        }
    }
}

extension ListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(ListCell.self, for: indexPath)
        cell.item = items?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
}

extension ListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let item = items![indexPath.row]
        let toggleDoneAction = UIContextualAction(style: .normal, title: item.done ? "Todo" : "Done", handler: { (action, view, completion) in
            self.onToggleDone(indexPath: indexPath, completion: completion)
        })
        return UISwipeActionsConfiguration(actions: [toggleDoneAction])
    }
}
