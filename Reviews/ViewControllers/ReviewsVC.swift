import UIKit

class ReviewsVC: UIViewController {
    private var business: Business!

    private let userSectionContainer = UIView()

    convenience init(with business: Business) {
        self.init(nibName: nil, bundle: nil)
        self.business = business
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        userSectionContainer.embed(UserInputRow(onChange: userDidReview(with:)))

        let mockedReviews = UIStackView(rows: Mocked.reviews
            .flatMap { [ReviewRow(with: $0) as UIView, .separator] }
            .dropLast())

        let rows = UIStackView(rows: [
            UILabel.title(with: "Reviews", size: 20),
            .spacer(height: 20),
            StatsRow(reviewsAverage: business.reviews.score, reviewsCount: business.reviews.count),
            .spacer(height: 15),
            .separator,
            userSectionContainer, // dynamic user review section
            .separator,
            .spacer(height: 15),
            UILabel.title(with: "Latest reviews"),
            mockedReviews,
            .spacer(height: 20),
            UIButton.simple(title: "View all reviews", weight: .bold),
            .spacer
        ])

        // add rows as a subview
        rows.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rows)

        // ... and constraint it to safeArea and layoutMargins
        let guide = view.safeAreaLayoutGuide
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            rows.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
            guide.bottomAnchor.constraint(equalToSystemSpacingBelow: rows.bottomAnchor, multiplier: 1.0),
            rows.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            rows.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ])
    }

    func userDidReview(with score: UInt) {
        business.userReview.score = score

        let detailsVC = UserReviewDetailsVC()
        detailsVC.userReview = business.userReview
        detailsVC.title = business.displayName
        detailsVC.savedCallback = { [unowned self] review in
            business.userReview = review
            userSectionContainer.clear()
            userSectionContainer.embed(
                UIStackView(rows: [
                    .spacer(height: 15),
                    UILabel.title(with: "Your Review"),
                    ReviewRow(with: review,
                              onUserWantsToEditCallback: { [unowned self] in
                                  userDidReview(with: review.score)
                              })
                ]))
        }

        // wrap in a navigation controller so we can get the toolbar for free
        let navController = UINavigationController(rootViewController: detailsVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true)
    }
}

private extension UIView {
    func clear() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
