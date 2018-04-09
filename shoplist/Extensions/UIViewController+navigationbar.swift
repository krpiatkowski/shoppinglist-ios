import UIKit

extension UIViewController {
    func setNavigationBarHidden(_ visible: Bool) -> CGFloat {
        guard let navigationBar = navigationController?.navigationBar else {
            return 0
        }

        if navigationBarIsVisible() == visible {
            return 0
        }
        let navigationBarHeight = navigationBar.frame.size.height
        let navigationBarOffsetY = visible ? (-navigationBarHeight) : (navigationBarHeight)

        let navigationBarFrame = navigationBar.frame;
        navigationBar.frame = navigationBarFrame.offsetBy(dx: 0, dy: navigationBarOffsetY)
        return navigationBarOffsetY
    }

    private func navigationBarIsVisible() -> Bool {
        guard let navigationBar = navigationController?.navigationBar else {
            return false
        }

        return navigationBar.frame.origin.y < self.view.frame.minY;
    }
}


