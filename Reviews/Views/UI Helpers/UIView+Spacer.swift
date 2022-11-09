import UIKit

extension UIView {
    // A view the low compression resistance useful for providing spacing between views.
    static var spacer: UIView {
        let spacer = UIView()
        spacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        spacer.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        spacer.setContentHuggingPriority(.defaultLow, for: .vertical)
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return spacer
    }

    static func spacer(height: CGFloat) -> UIView {
        UIView(height: height)
    }

    static func spacer(width: CGFloat) -> UIView {
        UIView(width: width)
    }

    convenience init(width: CGFloat? = nil, height: CGFloat? = nil) {
        self.init()
        if let width = width {
            let constraint = widthAnchor.constraint(equalToConstant: width)
            constraint.priority = .required
            constraint.isActive = true
        }
        if let height = height {
            let constraint = heightAnchor.constraint(equalToConstant: height)
            constraint.priority = .required
            constraint.isActive = true
        }
    }
}
