import UIKit

class ListCell : UITableViewCell {

    var item: ShoppingItem? {
        didSet {
            guard let item = item else {
                return
            }
            self.titleLabel.text = item.storeItem.name
            self.numberTextField.text = String(item.amount)
        }
    }

    private let numberTextField = UITextField()
    private let titleLabel = UILabel()
    private let seperatorLabel = UILabel()
    private let doneView = UIView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        numberTextField.textAlignment = .right
        numberTextField.layer.borderColor = UIColor.clear.cgColor
        numberTextField.layer.borderWidth = 1.0
        numberTextField.layer.cornerRadius = 5
        numberTextField.clipsToBounds = true
        numberTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        numberTextField.rightViewMode = .always

        contentView.addSubview(numberTextField)

        seperatorLabel.text = "⨯"
        contentView.addSubview(seperatorLabel)

        contentView.addSubview(titleLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        numberTextField.pin.left(10).vCenter().width(45).height(35)
        seperatorLabel.pin.right(of: numberTextField).marginLeft(5).width(10).top().bottom()
        titleLabel.pin.right(of: seperatorLabel).marginLeft(5).right().top().bottom()
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        numberTextField.isEnabled = editing
        if animated {
            numberTextField.layer.add(Animations.borderAnimation(is: editing), forKey: #keyPath(CALayer.borderColor))
        } else {
            numberTextField.layer.borderColor = editing ? Colors.inputBorderColor.cgColor : Colors.clear.cgColor
        }
    }
}


