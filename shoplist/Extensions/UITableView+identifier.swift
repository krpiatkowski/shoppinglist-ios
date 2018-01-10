import UIKit

extension UITableView {
    func register<T : UITableViewCell>(_ cellClass: T.Type?) {
        register(T.self, forCellReuseIdentifier: T.identifier())
    }
    
    func dequeue<T : UITableViewCell>(_ cellClass: T.Type?, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier(), for: indexPath) as! T
    }
}
