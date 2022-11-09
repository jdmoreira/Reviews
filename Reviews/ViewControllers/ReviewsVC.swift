//
//  ReviewsVC.swift
//  Reviews

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
    }
}
