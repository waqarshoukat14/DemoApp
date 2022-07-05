//
//  LoginViewModel.swift
//  DemoApp
//
//  Created by Waqar Mac on 05/07/2022.
//

import Foundation
import Alamofire


class LoginViewModel {
    
    static let loginViewModel = LoginViewModel()
    
    func getLoginResponse(_ email: String, _ password: String, _ role: String) {
        
        let parameter = [
            "email": "adminreacttask@manaknight.com",
            "password": "a123456",
            "role": "admin"
        ] as [String: Any]
        
        HTTPManager.shared.post(apiName: EndPoints.login, withparams: parameter, noHeaders: false) { (response: GenericModel<LoginModel>?) in
        
            guard let response = response else { return }
            
            
        }
    }
    
    
}

struct LoginModel: Codable {
    
    let error : Bool?
    let role : String?
    let token : String?
    let expire_at : Int?
    let user_id: Int?

    enum CodingKeys: String, CodingKey {

        case error = "error"
        case role = "role"
        case token = "token"
        case expire_at = "expire_at"
        case user_id = "user_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(Bool.self, forKey: .error)
        role = try values.decodeIfPresent(String.self, forKey: .role)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        expire_at = try values.decodeIfPresent(Int.self, forKey: .expire_at)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
    }
}




