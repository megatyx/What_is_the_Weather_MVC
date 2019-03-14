//
//  BarometricsInformation.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/15/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

struct BarometricsInformation {
    let pressure: Double
    let humidity: Int
}

extension BarometricsInformation: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Constants.API.JSONPayloadKeys.ForecastCodingKeys.self)
        self.pressure = try container.decode(Double.self, forKey: .pressure)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
    }
}
