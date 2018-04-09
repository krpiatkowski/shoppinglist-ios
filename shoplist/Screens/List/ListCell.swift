import UIKit

class ListCell : UITableViewCell {

    var onTitleSelected: ((ListCell) -> ())?

    var item: ShoppingItem? {
        didSet {
            guard let item = item else {
                return
            }
            self.numberTextField.text = String(item.amount)
            self.numberTextField.textColor = item.done ? Colors.markedDoneText : Colors.normalText
            self.seperatorLabel.textColor = item.done ? Colors.markedDoneText : Colors.normalText
            self.titleTextField.text = item.storeItem.name
            self.titleTextField.textColor = item.done ? Colors.markedDoneText : Colors.normalText
        }
    }

    private let numberTextField = UITextField()
    private let seperatorLabel = UILabel()
    private let titleTextField = UITextField()
    private let actionButton = UIButton()

    private var swipping = false

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

        titleTextField.textAlignment = .left
        titleTextField.layer.borderColor = UIColor.clear.cgColor
        titleTextField.layer.borderWidth = 1.0
        titleTextField.layer.cornerRadius = 5
        titleTextField.clipsToBounds = true
        titleTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        titleTextField.leftViewMode = .always
        titleTextField.delegate = self
        contentView.addSubview(titleTextField)

        actionButton.setImage(UIImage(named: "delete"), for:UIControlState.normal)
        actionButton.alpha = 0
        contentView.addSubview(actionButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        numberTextField.pin.left(10).vCenter().width(45).height(35)

        seperatorLabel.pin.after(of: numberTextField).marginLeft(5).width(10).top().bottom()

        actionButton.pin.vCenter().marginLeft(10).width(25).height(25).right(10)

        titleTextField.pin.after(of: seperatorLabel).before(of: actionButton).vCenter().marginRight(5).marginLeft(5).height(35)

    }

    override func willTransition(to state: UITableViewCellStateMask) {
        swipping = state == .showingDeleteConfirmationMask
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if swipping {
            return
        }
        numberTextField.isEnabled = editing
        titleTextField.isEnabled = editing
        if animated {
            let animation = Animations.borderAnimation(is: editing)
            numberTextField.layer.add(animation, forKey: #keyPath(CALayer.borderColor))
            numberTextField.layer.borderColor = (animation.toValue as! CGColor)
            titleTextField.layer.add(animation, forKey: #keyPath(CALayer.borderColor))
            titleTextField.layer.borderColor = (animation.toValue as! CGColor)
            UIView.animate(withDuration:  Metrics.animationTimeFast) {
                self.actionButton.alpha = editing ? 1 : 0
            }
        } else {
            numberTextField.layer.borderColor = editing ? Colors.inputBorderColor.cgColor : Colors.clear.cgColor
            titleTextField.layer.borderColor = editing ? Colors.inputBorderColor.cgColor : Colors.clear.cgColor
            actionButton.alpha = editing ? 1 : 0
        }
    }

    func setEditingTitle(_ editing: Bool){
        numberTextField.alpha = editing ? 0 : 1
        seperatorLabel.alpha = editing ? 0 : 1
        if(editing) {
            titleTextField.pin.left().before(of: actionButton).vCenter().marginRight(5).marginLeft(10)
        } else {
            self.layoutSubviews()
        }
    }
}

extension ListCell : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        onTitleSelected?(self)
    }

}
