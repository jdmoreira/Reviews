import UIKit

class StarsView: UIView {
    private var callback: (UInt) -> Void = { _ in }
    private var stars: UInt = 0 {
        didSet {
            stars = stars > 5 ? 5 : stars // clamp to maximum 5
            starViews.enumerated().forEach { (index, view) in
                view.isSelected = index < stars
            }
            callback(stars)
        }
    }

    private lazy var starViews = [StarView { [unowned self] in stars = 1 },
                                  StarView { [unowned self] in stars = 2 },
                                  StarView { [unowned self] in stars = 3 },
                                  StarView { [unowned self] in stars = 4 },
                                  StarView { [unowned self] in stars = 5 }]

    convenience init(stars initial: UInt = 0,
                     interactive: Bool = true,
                     onChange: @escaping (UInt) -> Void = { _ in }) {
        self.init(frame: .zero)

        defer {
            stars = initial
            callback = onChange
        }
        isUserInteractionEnabled = interactive

        let stack = UIStackView(columns: starViews)
        stack.distribution = .fillEqually
        embed(stack)
    }
}

private class StarView: UIView {
    private var imageView = UIImageView()
    private var callback: () -> Void = { }

    var isSelected: Bool = false {
        didSet {
            imageView.image = isSelected ? UIImage(named: "star_full") :  UIImage(named: "star_empty")
        }
    }

    convenience init(callback: @escaping () -> Void) {
        self.init(frame: .zero)

        self.callback = callback
        defer { isSelected = false }
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped(recognizer: )))
        imageView.addGestureRecognizer(gesture)
        embed(imageView)
    }

    @objc func tapped(recognizer: UITapGestureRecognizer) {
        callback()
    }
}
