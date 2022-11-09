import Foundation

struct Business {
    typealias Identifier = String

    struct ReviewSummary: Decodable {
        let score: Float
        let count: Int
    }

    let `id`: Identifier
    let displayName: String
    let reviews: ReviewSummary

    let latestReviews: [Review] = Mocked.reviews
    var userReview: Review = Review()
}

extension Business: Decodable {
    private enum CodingKeys: String, CodingKey {
        case `id`, displayName, reviews
    }
}
