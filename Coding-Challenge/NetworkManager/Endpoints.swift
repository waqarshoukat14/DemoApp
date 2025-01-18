//
//  Endpoints.swift
//  Coding-Challenge
//
//  Created by Waqar Shoukat on 27/11/2024.
//

import Foundation

enum Endpoint {
    case movies
    case custom(path: String)
    
    var baseURL: String {
        return Constants.baseURL
    }
    
    var path: String {
        switch self {
        case .movies:
            return "/movies"
        case .custom(let path):
            return path
        }
    }
    
    var url: URL? {
        return URL(string: baseURL + path)
    }
}
