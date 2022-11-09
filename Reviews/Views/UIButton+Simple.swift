import UIKit

extension UIButton {
    static func simple(title: String,
                       size: CGFloat = 16,
                       weight: UIFont.Weight = .regular,
                       color: UIColor = UIColor(named: "Blue")!,
                       handler: @escaping () -> Void = { }) -> UIButton {

        let action = UIAction(title: title, handler: { _ in handler() })
        let button = UIButton(type: .system, primaryAction: action)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: size, weight: weight)

        return button
    }
}
