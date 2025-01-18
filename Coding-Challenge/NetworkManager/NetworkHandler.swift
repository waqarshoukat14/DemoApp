//
//  NetworkManager.swift
//  Coding-Challenge
//
//  Created by Waqar Shoukat on 25/11/2024.
//

import Foundation
import Combine

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

class RequestBuilder {
    
    static func buildRequest(for endpoint: Endpoint,
                             method: HTTPMethod = .GET,
                             params: [String: Any]? = nil) -> URLRequest? {
        guard let url = endpoint.url else { return nil }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        if method == .GET, let params = params {
            components?.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        guard let finalURL = components?.url else { return nil }
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        if method != .GET, let params = params {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private var cancellables = Set<AnyCancellable>()
    
    private init() { }
    
    func execute<T: Decodable>(_ request: URLRequest,
                               responseType: T.Type) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode else {
                    throw NetworkError.responseError
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
