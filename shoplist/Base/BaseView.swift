import UIKit

class BaseView: UIView {
    private var legacySafeArea: UIEdgeInsets = .zero
    
    // safeArea returns UIView.safeAreaInsets for iOS 11+ or
    // an UIEdgeInsets initialized with the UIViewController's topLayoutGuide and
    // bottomLayoutGuide for other iOS versions.
    var safeArea: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return safeAreaInsets
        } else {
            return legacySafeArea
        }
    }
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func setSafeArea(_ safeArea: UIEdgeInsets) {
        guard safeArea != self.safeArea else { return }
        legacySafeArea = safeArea
        safeAreaDidChange()
    }
    
    func safeAreaDidChange() {
        setNeedsLayout()
    }
    
    override func safeAreaInsetsDidChange() {
        safeAreaDidChange()
    }
}
