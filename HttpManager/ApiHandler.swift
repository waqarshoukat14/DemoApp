//
//  ApiHandler.swift
//  DemoApp
//
//  Created by Waqar Mac on 05/07/2022.
//

import Foundation
import Alamofire

class APIHandler {
    
    var statusCode = Int.zero
    
    func handleResponse<T: Codable>(_ response: DataResponse<T, AFError>) -> Any? {
        switch response.result {
        case .success:
            print(response.response?.description as Any)
            return response.value
        case .failure:
            return nil
            
        }
    }
}
