//
//  TemperatureAndBarometrics.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/15/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

struct TemperatureAndBarometrics {
    let temperature: TemperatureInformation
    let barometrics: BarometricsInformation
}

extension TemperatureAndBarometrics: Decodable {
    init(from decoder: Decoder) throws {

        var container = try decoder.container(keyedBy: Constants.API.JSONPayloadKeys.ForecastCodingKeys.self)
        if let nestedContainer = try? container.nestedContainer(keyedBy: Constants.API.JSONPayloadKeys.CityCodingKeys.self,
                                                                forKey: .weatherStatus) {
            container = nestedContainer
        }
        
        let container = try decoder.container(keyedBy: Constants.API.JSONPayloadKeys.ForecastCodingKeys.self)
        self.temperature = try container.decode(TemperatureInformation.self, forKey: .temperature)
        self.barometrics = try BarometricsInformation(from: decoder)
    }
}
