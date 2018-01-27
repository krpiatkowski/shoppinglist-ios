import UIKit

class ListsView : BaseView {
    fileprivate var contentView = UIView()
    var tableView = UITableView()
    
    override init() {
        super.init()
        
        addSubview(contentView)
        
        tableView = UITableView(frame: CGRect.zero)
        tableView.tableFooterView = UIView()
        contentView.addSubview(self.tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.pin.all().margin(safeArea)
        self.tableView.pin.vertically().horizontally()
    }
}

