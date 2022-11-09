import UIKit

extension UILabel {
    static func title(with value: String, size: CGFloat = 16, weight: UIFont.Weight = .bold) -> UILabel {
        return UILabel(with: value, size: size, weight: weight)
    }

    static func subtitle(with value: String, size: CGFloat = 13, weight: UIFont.Weight = .regular) -> UILabel {
        let subtitle = UILabel(with: value, size: size, weight: weight)
        subtitle.textColor = UIColor(named: "DarkGray")
        return subtitle
    }

    convenience init(with value: String, size: CGFloat, weight: UIFont.Weight) {
        self.init(frame: .zero)

        font = UIFont.systemFont(ofSize: size, weight: weight)
        text = value
        textAlignment = .left
    }
}
