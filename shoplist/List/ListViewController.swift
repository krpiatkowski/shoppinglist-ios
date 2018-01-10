import UIKit
import PinLayout

class ListViewController : BaseViewController {
    let datasource = MockDatasource()
    var items:[ShoppingItem]?
    
    fileprivate var mainView: ListView {
        return self.view as! ListView
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        
        mainView.tableView.register(ListCell.self)
        mainView.tableView.allowsMultipleSelection = false
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        datasource.getItems { (items) in
            self.items = items
        }
    }
    
    override func loadView() {
        view = ListView()
    }

    func handleDone(indexPath: IndexPath, completion:(_: Bool) -> Void) {
        completion(true)
    }
    
    func handleDelete(indexPath: IndexPath, completion:(_: Bool) -> Void) {
        datasource.deleteItem(item: items![indexPath.row], completion: completion)
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
        let doneAction = UIContextualAction(style: .normal, title: "", handler: { (action, view, completion) in
            self.handleDone(indexPath: indexPath, completion: completion)
        })
        doneAction.image = UIImage.init(named: "done")
        return UISwipeActionsConfiguration(actions: [doneAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "", handler: { (action, view, completion) in
            self.handleDelete(indexPath: indexPath, completion: completion)
        })
        deleteAction.image = UIImage.init(named: "delete")
        return UISwipeActionsConfiguration(actions: [deleteAction])

    }
}
