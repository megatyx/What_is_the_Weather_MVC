//
//  WindInformation.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/15/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

struct WindInformation {
    let speed: Double
    let degree: Double
}

extension WindInformation: Decodable {
    fileprivate enum CodingKeys: String, CodingKey {
        case speed
        case degree = "deg"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.speed = try container.decode(Double.self, forKey: .speed)
        self.degree = try container.decode(Double.self, forKey: .degree)
    }
}
