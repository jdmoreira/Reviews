import UIKit

class UserInputRow: UIView {
    convenience init(onChange: @escaping (UInt) -> Void) {
        self.init(frame: .zero)

        let avatarView = UIView(width: 35, height: 35)
        avatarView.embed(UIImageView(image: UIImage(named: "avatar_missing")))
        avatarView.layer.cornerRadius = 17.5

        let titleLabel: UILabel = .title(with: "Rate and review")
        let subtitleLabel: UILabel = .subtitle(with: "Share your experience and help others")

        let starsView = StarsView(interactive: true, onChange: onChange)
        starsView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        starsView.widthAnchor.constraint(equalToConstant: 280).isActive = true

        let rows = UIStackView(rows: [titleLabel, subtitleLabel, .spacer(height: 10), starsView])
        rows.alignment = .leading

        let columns = UIStackView(columns: [avatarView, .spacer(width: 15), rows])
        columns.alignment = .leading

        embed(columns, insets: .init(top: 20, left: 0, bottom: 20, right: 0))
    }
}
