import UIKit

class ListCell : UITableViewCell {
    weak var delegate : ListCellDelegate?

    private let numberTextField = UITextField()
    
    var item: ShoppingItem? {
        didSet {
            guard let item = item else {
                self.textLabel?.attributedText = nil
                return
            }
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: item.name)
            if(item.done) {
                attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            }
            self.textLabel?.attributedText = attributeString
        }
    }

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

protocol ListCellDelegate : NSObjectProtocol{
    func didChange(number: Int, for:ShoppingItem)
}
