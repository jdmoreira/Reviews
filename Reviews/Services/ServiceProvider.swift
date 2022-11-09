/*
 'ServiceProvider' is a protocol that abstracts the implementation details
 so that there can be multiple implementations.

 There is a REST over HTTP implementation at 'HTTPServiceProvider'
 but also a mocked one at 'MockedServiceProvider'

 Others could be sqlite, another backend, graphql, etc...
 */

import Foundation

protocol ServiceProvider {
    func loadBusiness(with: Business.Identifier, callback: @escaping (Result<Business?, Error>) -> Void)
}

enum Service {
    enum Error: Swift.Error {
        case invalidUrl
        case invalidResponse
        case noData
        case unsuccessful(statusCode: Int)
        case unknown(Swift.Error)
    }
}
