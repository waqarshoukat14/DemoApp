//
//  HttpManager.swift
//  DemoApp
//
//  Created by Waqar Mac on 05/07/2022.
//

import Foundation
import Alamofire
import UIKit

struct Constants {
    static let baseURL = "https://reacttask.mkdlabs.com/v2/api/lambda/"
    static let apiKey = "cmVhY3R0YXNrOjVmY2h4bjVtOGhibzZqY3hpcTN4ZGRvZm9kb2Fjc2t5ZQ=="
}



class HTTPManager: APIHandler {
    
    static let shared: HTTPManager = HTTPManager()
    
    
    public func get<T: Codable>( apiName: String , completion: @escaping ( _ response: T?) -> Void) {
        
        let url = "\(Constants.baseURL)\(apiName)"
        let headers: HTTPHeaders = [
//            "Authorization": "Bearer \(MessagesConstants.token)",
            "api-key": Constants.apiKey
        ]
        print(url)
        print(headers)
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: headers).responseDecodable { [weak self] (response: DataResponse<T, AFError>) in
            
            print(response.response?.statusCode)
            guard let weakSelf = self else { return }
            
            guard let response = weakSelf.handleResponse(response) as? T else {
                completion(nil)
                return
            }
            completion(response)
        }
    }
    
    
    public func post<T: Codable>( apiName: String, withparams parameters: [String:Any] = [:]
                                  , noHeaders: Bool = false, completion: @escaping ( _ response: T?) -> Void) {
        
        let url = "\(Constants.baseURL)\(apiName)"
        var headers: HTTPHeaders = [
//            "Authorization": "Bearer \(MessagesConstants.token)",
            "x-project": Constants.apiKey
        ]
        if noHeaders {
            headers = [:]

        }
        
        print("URL: ",url)
        print("Headers: ",headers)
        print("Parameters: ",parameters)
        
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseDecodable { [weak self] (response: DataResponse<T, AFError>) in
            
            print(response.response?.statusCode)
            
            
            guard let weakSelf = self else { return }
            
            guard let response = weakSelf.handleResponse(response) as? T else {
                completion(nil)
                return
            }
            completion(response)
        }
    }
}

struct EndPoints {
    static let login = "login"
}
