//
//  GenericModel.swift
//  DemoApp
//
//  Created by Waqar Mac on 05/07/2022.
//

import Foundation

struct GenericModel <T: Codable> : Codable {
    let status : Int?
    let data : [T]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        data = try values.decodeIfPresent([T].self, forKey: .data)
    }
}
