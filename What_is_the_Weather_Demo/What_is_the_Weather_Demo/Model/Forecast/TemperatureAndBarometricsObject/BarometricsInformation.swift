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
    let currentTemp_Kelvins: Double
    let lowsTemp_Kelvins: Double
    let highsTemp_Kelvins: Double

    static func convertToCelsius(tempKelvins: Double) -> Double {
        return  tempKelvins - 273.15

    }
    static func convertToFahrenheit(tempKelvins: Double) -> Double {
        return (1.8 * (tempKelvins - 273.15) + 32)
    }
}

extension BarometricsInformation: Decodable {
    init(from decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: Constants.API.JSONPayloadKeys.ForecastCodingKeys.self)
        if let nestedContainer = try? container.nestedContainer(keyedBy: Constants.API.JSONPayloadKeys.ForecastCodingKeys.self,
                                                                forKey: .temperatureContainer) {
            container = nestedContainer
        }
        self.pressure = try container.decode(Double.self, forKey: .pressure)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.currentTemp_Kelvins = (try? container.decode(Double.self, forKey: .temperature)) ?? 0
        self.lowsTemp_Kelvins = (try? container.decode(Double.self, forKey: .min)) ?? 0
        self.highsTemp_Kelvins = (try? container.decode(Double.self, forKey: .max)) ?? 0

    }
}
