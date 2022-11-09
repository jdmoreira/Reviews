import UIKit

class UserReviewDetailsVC: UIViewController {
    var userReview: Review!
    var savedCallback: (Review) -> Void = { _ in }

    private let starsView = StarsView(stars: 0, interactive: true)
    private let nameTextField = UITextField()
    private let commentTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupNavBarAppearance()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain,
                                                            target: self,
                                                            action: #selector(save))

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain,
                                                           target: self,
                                                           action: #selector(close))


        let descriptionLabel = UILabel.subtitle(with: userReview.scoreMood)
        descriptionLabel.textAlignment = .center

        nameTextField.placeholder = "Your name"
        nameTextField.autocorrectionType = .no
        nameTextField.text = userReview.name

        commentTextField.placeholder = "Add more details on your experience..."
        commentTextField.autocorrectionType = .no
        commentTextField.text = userReview.comment

        let starsView = StarsView(stars: userReview.score, interactive: true) { [unowned self] newScore in
            userReview.score = newScore
            descriptionLabel.text = userReview.scoreMood
        }

        let rows = UIStackView(rows: [.spacer(height: 15),
                                      starsView,
                                      .spacer(height: 20),
                                      descriptionLabel,
                                      .spacer(height: 15),
                                      .separator,
                                      .spacer(height: 15),
                                      nameTextField,
                                      .spacer(height: 15),
                                      .separator,
                                      .spacer(height: 15),
                                      commentTextField,
                                      .spacer])

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

    @objc func save() {
        let alert = UIAlertController(title: "Thank you for your review",
                                              message: "You're helping others make smarter decisions every day.",
                                              preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay!", style: .default) { [unowned self] _ in close() })
        present(alert, animated: true)
    }

    @objc func close() {
        userReview.name = nameTextField.text == "" ? nil : nameTextField.text
        userReview.comment = commentTextField.text == "" ? nil : commentTextField.text

        savedCallback(userReview)

        dismiss(animated: true)
    }
}

// Too much boilerplate for what it's worth 😅
private extension UIViewController {
    func setupNavBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "Blue")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        let buttonAppearance = UIBarButtonItemAppearance()
        buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        buttonAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.buttonAppearance = buttonAppearance

        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.standardAppearance = appearance
    }
}

private extension Review {
    var scoreMood: String {
        switch score {
        case 1:
            return "I hated it"
        case 2:
            return "I didn't like it"
        case 3:
            return "It was OK"
        case 4:
            return "I liked it"
        case 5:
            return "I loved it"
        default:
            return ""
        }
    }
}
