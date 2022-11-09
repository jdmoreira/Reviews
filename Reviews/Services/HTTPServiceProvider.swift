import Foundation

class HTTPServiceProvider: ServiceProvider {
    private let session: URLSession

    required init() {
        session = URLSession(configuration: URLSessionConfiguration.default)
    }

    func loadBusiness(with businessId: Business.Identifier, callback: @escaping (Result<Business?, Error>) -> Void) {
        guard let url = URL(string: "https://api.hitta.se/search/v7/app/company/\(businessId)") else {
            callback(.failure(Service.Error.invalidUrl))
            return
        }

        let request = URLRequest(url: url)
        execute(request: request) { result in
            callback(
                result.flatMap { data -> Result<Business?, Error> in
                    do {
                        let search = try JSONDecoder().decode(SearchResult.self, from: data)
                        return .success(search.result.companies.company.first)
                    } catch {
                        return .failure(error)
                    }
                })
        }
    }

    private func execute(request: URLRequest, on queue: DispatchQueue = .main, completion: @escaping (Result<Data, Error>) -> Void) {
        // perform task
        session.dataTask(with: request) { (data, response, error) in
            queue.async {
                guard error == nil else {
                    completion(.failure(Service.Error.unknown(error!)))
                    return
                }

                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(Service.Error.invalidResponse))
                    return
                }

                guard 200 ... 299 ~= response.statusCode else {
                    completion(.failure(Service.Error.unsuccessful(statusCode: response.statusCode)))
                    return
                }

                guard let data = data else {
                    completion(.failure(Service.Error.noData))
                    return
                }

                completion(.success(data))
            }
        }.resume()
    }
}

// Boilerplate wrapper needed to parse the backend call
private struct SearchResult: Decodable {
    struct Result: Decodable {
        struct Companies: Decodable {
            let total: UInt
            let company: [Business]
        }

        let companies: Companies
    }

    let result: Result
}
