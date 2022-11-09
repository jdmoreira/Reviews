import Foundation

class MockedServiceProvider: ServiceProvider {
    private let session: URLSession

    required init() {
        session = URLSession(configuration: URLSessionConfiguration.default)
    }

    func loadBusiness(with businessId: Business.Identifier, callback: @escaping (Result<Business?, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(.random(in: 1...5))) {

            switch Int.random(in: 1...5) {
            case 1:
                callback(.failure(Service.Error.unsuccessful(statusCode: 500)))
            case 2:
                callback(.failure(Service.Error.invalidResponse))
            case 3:
                callback(.failure(Service.Error.noData))
            case 4:
                callback(.success(nil))
            default:
                callback(.success(Business(id: .philsBurger, displayName: "Phil's Burger",
                                           reviews: Business.ReviewSummary(score: 4.1, count: 27))))
            }
        }
    }
}
