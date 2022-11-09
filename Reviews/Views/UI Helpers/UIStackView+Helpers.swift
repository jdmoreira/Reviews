import UIKit

public extension UIStackView {
    convenience init(views: [UIView], axis: NSLayoutConstraint.Axis = .horizontal, spacing: CGFloat = 0) {
        self.init(arrangedSubviews: views)
        self.spacing = spacing
        self.axis = axis
    }

    convenience init(rows: [UIView], spacing: CGFloat = 0) {
        self.init(views: rows, axis: .vertical, spacing: spacing)
    }

    convenience init(columns: [UIView], spacing: CGFloat = 0) {
        self.init(views: columns, axis: .horizontal, spacing: spacing)
        distribution = .fill
        alignment = .center
    }
}
