import UIKit

class ListView : BaseView {
    fileprivate var contentView = UIView()
    var tableView = UITableView()
    
    var isEditing:Bool

    override init() {
        isEditing = false

        super.init()

        addSubview(contentView)
    
        tableView = UITableView(frame: CGRect.zero)
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        contentView.addSubview(self.tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggleEdit(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.layoutSubviews()
            }
        } else {
            self.layoutSubviews()
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.pin.all().margin(safeArea)
        tableView.pin.vertically().horizontally()
        if(isEditing){
            tableView.tableHeaderView?.pin.height(0)
        } else {
            tableView.tableHeaderView?.pin.height(0)
        }
        tableView.tableHeaderView = tableView.tableHeaderView
    }
}
