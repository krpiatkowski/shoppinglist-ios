import Foundation
import UIKit

final class Animations {
    static func borderAnimation(is editing: Bool) -> CABasicAnimation {
        let from = !editing ? Colors.inputBorderColor.cgColor : Colors.clear.cgColor
        let to = editing ? Colors.inputBorderColor.cgColor : Colors.clear.cgColor

        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.borderColor))
        animation.fromValue = from
        animation.toValue = to
        animation.duration = Metrics.animationTimeFast
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        return animation

    }
}
