import UIKit

extension UITableViewCell{
    class func identifier() -> String {
        return NSStringFromClass(self)
    }
}
