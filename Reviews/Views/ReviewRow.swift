import UIKit

class ReviewRow: UIView {

    convenience init(with review: Review, onUserWantsToEditCallback: @escaping () -> Void = { }) {
        self.init(frame: .zero)

        let avatarView = UIView(width: 35, height: 35)
        avatarView.embed(UIImageView(image: UIImage(named: review.avatar ?? "avatar_missing")))
        avatarView.layer.cornerRadius = 17.5

        let subtitle = "\(review.timepassed) ago - \(review.source)"
        let subtitleLabel = UILabel.subtitle(with: subtitle)

        let starsView = StarsView(stars: review.score, interactive: false)
        starsView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        starsView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        let subtitleColumns = UIStackView(columns: [starsView, .spacer(width: 10), subtitleLabel])

        let commentView: UIView
        if let comment = review.comment {
            let label = UILabel(with: comment, size: 16, weight: .regular)
            label.numberOfLines = 0
            commentView = label
        } else {
            commentView = UIButton.simple(title: "Describe your experience",
                                          handler: onUserWantsToEditCallback)
        }

        let name = review.name ?? "Anonymous"
        let rows = UIStackView(rows: [UILabel.title(with: name, weight: .medium),
                                      subtitleColumns,
                                      .spacer(height: 10),
                                      commentView])
        rows.alignment = .leading

        let columns = UIStackView(columns: [avatarView, .spacer(width: 15), rows])
        columns.alignment = .leading

        embed(columns, insets: .init(top: 12, left: 0, bottom: 12, right: 0))
    }
}
