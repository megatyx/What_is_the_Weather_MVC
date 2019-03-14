//
//  ServerResponseInformation.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/14/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

struct ServerResponseInformation {
    let code: Int
    let message: String?
}

extension ServerResponseInformation: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Constants.API.JSONPayloadKeys.ServerCodingKeys.self)
        self.message = try? container.decode(String.self, forKey: .message)
        self.code = try container.decode(Int.self, forKey: .code)
    }
}
