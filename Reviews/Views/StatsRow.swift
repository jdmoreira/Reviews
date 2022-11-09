import UIKit

class StatsRow: UIView {

    convenience init(reviewsAverage: Float, reviewsCount: Int) {
        self.init(frame: .zero)

        let average = String(format: "%.1f", reviewsAverage)
        let averageLabel = UILabel.title(with: average, weight: .bold)
        averageLabel.textAlignment = .center

        let averageBubble = UIView()
        averageBubble.backgroundColor = UIColor(named: "Yellow")
        averageBubble.layer.cornerRadius = 8.0
        averageBubble.embed(averageLabel)

        NSLayoutConstraint.activate([
            averageBubble.widthAnchor.constraint(equalTo: averageBubble.heightAnchor),
            averageBubble.widthAnchor.constraint(equalToConstant: 35)
        ])

        embed(UIStackView(columns: [averageBubble,
                                    .spacer(width: 15),
                                    UILabel.subtitle(with: "from \(reviewsCount) ratings"),
                                    .spacer,
                                    UIButton.simple(title: "View all reviews")]))
    }
}
