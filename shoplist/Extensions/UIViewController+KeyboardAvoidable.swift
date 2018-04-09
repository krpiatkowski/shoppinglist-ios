import UIKit

protocol KeyboardAvoidable {
    func willShowKeyboard(info: KeyboardAttributes)
    func willHideKeyboard(info: KeyboardAttributes)
    func addKeyboardObservers()
    func removeKeyboardObservers()
}

typealias KeyboardAttributes = (height: CGFloat, duration: Double, curve: Int)

extension KeyboardAvoidable where Self: UIViewController {
    func addKeyboardObservers() {
        NotificationCenter
            .default
            .addObserver(forName: NSNotification.Name.UIKeyboardWillShow,
                         object: nil,
                         queue: nil) { [weak self] notification in
                                    self?.keyboardWillShow(notification)
        }

        NotificationCenter
            .default
            .addObserver(forName: NSNotification.Name.UIKeyboardWillHide,
                                object: nil,
                                queue: nil) { [weak self] notification in
                                    self?.keyboardWillHide(notification)
        }
    }

    func removeKeyboardObservers() {
        NotificationCenter
            .default
            .removeObserver(self,
                            name: NSNotification.Name.UIKeyboardWillShow,
                            object: nil)

        NotificationCenter
            .default
            .removeObserver(self,
                            name: NSNotification.Name.UIKeyboardWillHide,
                            object: nil)
    }

    func willShowKeyboard(info: KeyboardAttributes) {

    }

    func willHideKeyboard(info: KeyboardAttributes) {

    }

    private func keyboardWillShow(_ notification: Notification) {
        guard let info = getKeyboardInfo(notification) else { return }
        willShowKeyboard(info: info)
    }

    private func keyboardWillHide(_ notification: Notification) {
        guard let info = getKeyboardInfo(notification) else { return }
        willHideKeyboard(info: info)
    }

    private func getKeyboardInfo(_ notification: Notification) -> KeyboardAttributes? {
        guard let userInfo = notification.userInfo else { return nil }
        guard let rect = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return nil }
        guard let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey]  as? NSNumber)?.doubleValue else { return nil }
        guard let curve = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue else { return nil }
        return (rect.height, duration, curve << 16)
    }
}
