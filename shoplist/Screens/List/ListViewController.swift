import UIKit
import PinLayout

class ListViewController : BaseViewController, KeyboardAvoidable {
    let datasource = MockDatasource()
    private let titleTextView = UITextField()

    var list:ShoppingList
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

    override func viewWillAppear(_ animated: Bool) {
        addKeyboardObservers()
    }

    override func viewDidDisappear(_ animated: Bool) {
        removeKeyboardObservers()
    }


    func willShowKeyboard(info: KeyboardAttributes) {

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
        
        titleTextView.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleTextView.text = list.name
        titleTextView.textAlignment = .center
        titleTextView.layer.borderColor = UIColor.clear.cgColor
        titleTextView.layer.borderWidth = 1.0
        titleTextView.layer.cornerRadius = 5

        titleTextView.pin.width(200)

        navigationItem.title = list.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(ListViewController.toggleEdit))
        setEditing(false, animated: false)

        datasource.getItems(list:self.list) { (items) in
            self.items = items
        }
    }

    @objc
    func toggleEdit(){
        setEditing(!isEditing, animated: true)
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        mainView.isEditing = editing
        if mainView.tableView.isEditing {
            mainView.tableView.setEditing(false, animated: animated)
        }
        mainView.tableView.setEditing(editing, animated: animated)
        mainView.toggleEdit(animated: animated)

        navigationItem.rightBarButtonItem?.title = editing ? "Done" : "Edit"

        navigationItem.titleView = titleTextView
        navigationItem.title = list.name
        if animated {
            titleTextView.layer.add(Animations.borderAnimation(is: editing), forKey: #keyPath(CALayer.borderColor))
        } else {
            titleTextView.layer.borderColor = editing ? Colors.inputBorderColor.cgColor : Colors.clear.cgColor
        }
        titleTextView.isEnabled = editing
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

    func onItemTitleSelected(cell: ListCell) {
        guard let indexPath = mainView.tableView.indexPath(for: cell) else {
            return
        }
        mainView.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1000))

        let otherCells = self.mainView.tableView.visibleCells.filter { other in
            return other != cell
        }

        UIView.animate(withDuration: 0.7) {
            let offset = self.setNavigationBarHidden(true)
            otherCells.forEach { c in c.alpha = 0 }
            cell.setEditingTitle(true)
            self.navigationController?.navigationBar.alpha = 0
            self.mainView.tableView.frame = self.mainView.tableView.frame.offsetBy(dx: 0, dy: offset)
            self.mainView.tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
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
        cell.onTitleSelected = onItemTitleSelected
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

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
