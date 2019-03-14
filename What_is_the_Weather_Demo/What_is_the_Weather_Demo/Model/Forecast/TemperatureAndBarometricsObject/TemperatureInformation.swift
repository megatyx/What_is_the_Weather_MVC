//
//  TemperatureInformation.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/15/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

struct TemperatureInformation {
    let min: Double
    let max: Double
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}

extension TemperatureInformation: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Constants.API.JSONPayloadKeys.ForecastCodingKeys.self)
        self.min = try container.decode(Double.self, forKey: .min)
        self.max = try container.decode(Double.self, forKey: .max)
        self.day = try container.decode(Double.self, forKey: .day)
        self.night = try container.decode(Double.self, forKey: .night)
        self.eve = try container.decode(Double.self, forKey: .eve)
        self.morn = try container.decode(Double.self, forKey: .morn)
    }
}
