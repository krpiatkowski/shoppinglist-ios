import UIKit

class ListCell : UITableViewCell {
    
    fileprivate let numberTextField = UITextField()
    
    var item: ShoppingItem? {
        didSet {
            self.textLabel?.text = item?.name
        }
    }
    
//    weak var delegate : ListCellDelegate?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        numberTextField.delegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListCell : UITextFieldDelegate {
    
}


protocol ListCellDelegate {
    func didChange(number: Int, for:ShoppingItem)
}
