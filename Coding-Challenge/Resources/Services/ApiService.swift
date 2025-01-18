//
//  ApiService.swift
//  Coding-Challenge
//
//  Created by Waqar Shoukat on 27/11/2024.
//

import Foundation
import Combine

protocol APIService {
    func fetchMovies() -> AnyPublisher<MoviesModel, Error>
}

class MovieService: APIService {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = .shared) {
        self.networkManager = networkManager
    }
    
    func fetchMovies() -> AnyPublisher<MoviesModel, Error> {
        guard let request = RequestBuilder.buildRequest(for: .movies) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        return networkManager.execute(request, responseType: MoviesModel.self)
    }
}
