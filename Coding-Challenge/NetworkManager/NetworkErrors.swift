//
//  NetworkErrors.swift
//  Coding-Challenge
//
//  Created by Waqar Shoukat on 25/11/2024.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
        case .responseError:
            return NSLocalizedString("Response error", comment: "")
        case .unknown:
            return NSLocalizedString("Unknown Error", comment: "")
        }
    }
}

